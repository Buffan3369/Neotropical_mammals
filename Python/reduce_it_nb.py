# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 13:56:20 2023

Just to reduce the number of iterations

@author: lucas
"""

import os

os.chdir("E:/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/Tropical_analysis/dir_Tropical")
hdr = {"mcmc":402, "sp_rates":401, "ex_rates":401}

for j in range(1, 11):
    for typ in ["mcmc", "sp_rates", "ex_rates"]:        
        tmp = []
        with open("./pyrate_mcmc_logs/Tropical_taxa_"+str(j)+"_Grj_"+typ+".log") as file:
            i = 0
            for line in file:
                i += 1
                if i > hdr[typ]:
                    break
                tmp.append(line)
        with open("./pyrate_mcmc_logs_20M/Tropical_taxa_"+str(j)+"_Grj_"+typ+".log", "w") as f:
            for line in tmp:
                f.write(line)
                f.write("\n")
            
        
        