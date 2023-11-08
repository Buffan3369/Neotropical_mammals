# -*- coding: utf-8 -*-
"""
Simulate a poisson sampling of varying intensity (=mean number of sampled occurrence)
through time. The latter Will be exactly equal to the mean q_rates we obtained from our data.

@author: Lucas Buffan
@date: 11/2023
"""

import numpy as np
import pandas as pd
import os

os.chdir("E:\\Internship_ISEM\\Neotropical_Mammals\\REPO\\Neotropical_mammals\\")
stages = pd.read_csv("./data_2023/simulated_data/EOM_bins.csv")

EO_stages = ["Ypresian", "Lutetian", "Bartonian", "Priabonian", "Rupelian", "Chattian"]

## Empirical lambdas => q_rates -----------------------------------------------
empirical_lamb = pd.read_csv("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/GENUS_LEVEL/EOCENE_OLIGOCENE_singleton/Q_SHIFTS/q_stages/Parsed_Q_rates.csv")
empirical_lamb = empirical_lamb.drop(6) #under 23.03Ma
emp_lamb_dict = {key:None for key in EO_stages} #stored in a dictionary
for key in EO_stages:
    idx = EO_stages.index(key)
    emp_lamb_dict[key] = round(empirical_lamb["mean_Q"][idx], ndigits=2)
    
## Load simulated occurrence dataset ------------------------------------------
simulated_TsTe = pd.read_csv("./data_2023/simulated_data/sim_0.txt", sep="\t")
    # Bin time function (method = mid)
simulated_TsTe["mid"] = (simulated_TsTe["ts"] + simulated_TsTe["te"]) / 2
def bin_mid(mid):
    i = 0
    corr_bin = stages["interval_name"][0]
    while mid < stages["min_ma"][i]:
        corr_bin = stages["interval_name"][i]
        i += 1
#    print(i)
    return(corr_bin)

    #Apply to our simulated data
bins = map(bin_mid, simulated_TsTe["mid"])
bins = list(bins)
simulated_TsTe["bin"] = bins

    # Eliminate occurrences binned outside Eocene-Oligocene
to_drop = []
for i in range(len(simulated_TsTe)):
    if simulated_TsTe["bin"][i] not in EO_stages:
        to_drop.append(i)
simulated_TsTe = simulated_TsTe.drop(to_drop)

## Simulate 6 poisson samples of size corresponding to the number of taxa within each stage bin and intensity determined by the bin -------------
samples = {stage:None for stage in EO_stages}
for stg in EO_stages:
    idx = list(np.where(np.array(simulated_TsTe["bin"] == stg))[0])
    samples[stg] = np.random.poisson(lam = emp_lamb_dict[stg],
                                     size = len(idx))
    
for i in samples.values():
    print(np.shape(i))
