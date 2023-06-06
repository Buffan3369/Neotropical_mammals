# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 14:32:14 2023

Parse and save preservation rate estimates from multiple replicates.

@author: Lucas Buffan
"""
import os
import pandas as pd
import numpy as np

os.chdir("E:/Internship_ISEM/Neotropical_Mammals/REPO/Neotropical_mammals")

dir = "../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch/Q_shifts/all_in_one/"
#dir = "../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch/Q_shifts/one_place-one_time-one_occ/"
files = os.listdir(dir)
files = [file for file in files if ".pdf" not in file and ".csv" not in file]

mean_q = pd.DataFrame([])
min_HPD = pd.DataFrame([])
max_HPD = pd.DataFrame([])

i = 0
for file in files:
    i += 1
    tmp_qmean = []
    tmp_minHPD = []
    tmp_maxHPD = []
    with open(dir+file) as f:
        for line in f:
            if "Q_mean = " in line:
                q = float(line.split(" = ")[1])
                tmp_qmean.append(q)
            elif "Q_hpd_m = " in line:
                q = float(line.split(" = ")[1])
                tmp_minHPD.append(q)
            elif "Q_hpd_M = " in line:
                q = float(line.split(" = ")[1])
                tmp_maxHPD.append(q)
    mean_q["replicate_"+str(i)] = tmp_qmean
    min_HPD["replicate"+str(i)] = tmp_minHPD
    max_HPD["replicate"+str(i)] = tmp_maxHPD

final = pd.DataFrame([])
final["mean_Q"] = mean_q.apply(np.mean, axis = 1)
final["min_HPD"] = min_HPD.apply(np.nanmin, axis = 1)
final["max_HPD"] = max_HPD.apply(np.nanmax, axis = 1)
final["epoch"] = ["Palaeocene", "Eocene", "Oligocene", "Miocene", "Pliocene", "Pleistocene", "Holocene"]

final.to_csv(dir+"Parsed_Q_rates.csv",
             index = False)
