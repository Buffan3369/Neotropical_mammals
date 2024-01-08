# -*- coding: utf-8 -*-
"""
Sample the number of occurrences from each simulated lineage based on empirical q_rates.

@author: Lucas Buffan
@date: 11/2023
"""

#import sys
## Generate input (10 simulated datasets with constant rates lam = 0.17 and mu = 0.1)
exec(open("/home/lucas.buffan/PyRate/pyrate_lib/birthdeath_simulator.py").read())
#sys.modules[__name__].__dict__.clear() #clear environment

import numpy as np
import pandas as pd
import os

os.chdir("/home/lucas.buffan/Documents/GitHub/Neotropical_mammals/")
stages = pd.read_csv("./data_2023/simulated_data/EOM_bins.csv")

EO_stages = ["Ypresian", "Lutetian", "Bartonian", "Priabonian", "Rupelian", "Chattian"]

n_reps = 100 #number of replicates

## Empirical lambdas => mean q_rates ------------------------------------------
empirical_lamb = pd.read_csv("./results/SALMA_smoothed/genus_level/1-Full/Q_SHIFTS/Parsed_Q_rates.csv", sep = "\t")
empirical_lamb = empirical_lamb.drop(0) #above 56Ma
emp_lamb_dict = {key:None for key in EO_stages} #stored in a dictionary
for key in EO_stages:
    idx = EO_stages.index(key)
    emp_lamb_dict[key] = round(empirical_lamb["mean_Q"][idx+1], ndigits=2)
    
## Empirical alphas => preservation heterogenity across lineages --------------
ESS_sum = pd.read_csv("./results/SALMA_smoothed/genus_level/1-Full/pyrate_mcmc_logs/ESS_summary.txt",
                      sep = "\t")
CV = np.where(ESS_sum["ESS_posterior"] > 200)[0] # index of the runs that effectively converged
ESS_sum = ESS_sum.iloc[CV] #subset runs that converged only
alpha = np.mean(np.array(ESS_sum["Mean_alpha"]))

## Function to bin based on mid age -------------------------------------------
def bin_mid(mid):
    i = 0
    corr_bin = stages["interval_name"][0]
    while mid < stages["min_ma"][i]:
        corr_bin = stages["interval_name"][i]
        i += 1
#    print(i)
    return(corr_bin)

## Function choosing min and max ages of an occurrence given a [ts,te] range --
def choose_min_max(sp_name):
    idx = np.where(simulated_TsTe["species"] == sp_name)[0][0] #index of the target species
    st = simulated_TsTe["status"][idx]
    ts = simulated_TsTe["ts"][idx]
    te = simulated_TsTe["te"][idx]
    n = simulated_TsTe["nb_occ"][idx] #number of occurrences we want to sample in the [te,ts] interval
    str_out = ""
    for i in range(n):
        r_min = np.random.uniform(low = te, high = ts-1, size = 1)[0]
#        print("min_ma = "+str(r_min))
        r_max = np.random.uniform(low = te, high = ts, size = 1)[0]
        while r_max <= r_min:
            r_max = np.random.uniform(low = te, high = ts, size = 1)[0]
#        print("max_ma = "+str(r_max))
        str_out += "%s\t%s\t%s\t%s\n" % (sp_name, st, round(r_min, ndigits = 2), round(r_max, ndigits=2))
    return str_out

for it in range(n_reps):
## Load simulated occurrence dataset ------------------------------------------
    simulated_TsTe = pd.read_csv("./data_2023/simulated_data/All_lineages_TsTe/"+str(n_reps)+"_replicates/sim_"+str(it)+".txt", sep="\t")
    simulated_TsTe["mid"] = (simulated_TsTe["ts"] + simulated_TsTe["te"]) / 2
    bins = map(bin_mid, simulated_TsTe["mid"])
    bins = list(bins)
    simulated_TsTe["bin"] = bins
    
        # Eliminate occurrences binned outside Eocene-Oligocene
    to_drop = []
    for i in range(len(simulated_TsTe)):
        if simulated_TsTe["bin"][i] not in EO_stages:
            to_drop.append(i)
    simulated_TsTe = simulated_TsTe.drop(to_drop)
    simulated_TsTe = simulated_TsTe.sort_values(by = "bin",
                                                key=lambda s: s.apply(EO_stages.index), 
                                                ignore_index=True) #sort with user-defined key (from earlier to later stage)
    simulated_TsTe = simulated_TsTe.reset_index(drop = True) #reset index after eliminating/sorting columns
    
    
## Simulate 6 poisson samples (one per stage) of size corresponding to the number of taxa within each stage bin and intensity determined by the bin -------------
    samples = {stage:None for stage in EO_stages}
    for stg in EO_stages:
        idx = list(np.where(np.array(simulated_TsTe["bin"] == stg))[0])
        nb_occ_stg = []
        #for each lineage i, we sample a number of occurrence in a poisson distribution of intensity (lambda * g_i), g_i being sampled in a Gamma(alpha, alpha) distribution
        for lin in range(len(idx)):
            g = np.random.gamma(shape = alpha, scale = alpha)
            nb_occ_stg.append(np.random.poisson(lam = emp_lamb_dict[stg] * g, 
                                           size = 1)[0])
        samples[stg] = nb_occ_stg
        
## Choose the ages ------------------------------------------------------------
    nb_occ_tot = samples['Ypresian']
    for key in EO_stages[1:]:
        nb_occ_tot += samples[key]
    simulated_TsTe["nb_occ"] = nb_occ_tot #create the number of occurrences sampled per lineage column
    #Save full diversity and sampled occ file
    simulated_TsTe.to_csv("./data_2023/simulated_data/All_lineages_TsTe/"+str(n_reps)+"_replicates/Full_simulated_diversity_and_sampled_occ_"+str(it)+".csv", index = False)
    
    #Remove species with 0 sampled occurrences (makes the rest faster)
    simulated_TsTe.drop(simulated_TsTe[simulated_TsTe["nb_occ"] == 0].index, inplace = True)
    simulated_TsTe = simulated_TsTe.reset_index(drop = True)
    simulated_TsTe["status"] = "extinct"
    
    #Prepare PyRate input
    MinMax = "Species\tStatus\tMinT\tMaxT\n"
    for species in simulated_TsTe["species"]:
        MinMax += choose_min_max(species)
    
    with open("./data_2023/simulated_data/Simulated_occurrence_datasets/"+str(n_reps)+"_replicates/sampled_simulated_occurrences_"+str(it)+".txt", 'w') as file:
        file.write(MinMax)
    file.close()
