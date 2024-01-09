#!/bin/bash

#Simulate origination and extinction times within a birth-death process with constant origination (lamb) and extinction (mu) rates
python ~/PyRate/pyrate_lib/birthdeath_simulator.py -n_reps 100 -dir "../../data_2023/simulated_data/All_lineages_TsTe/"
#Sample fossil occurrences for each lineage using a Poisson process of rate informed by our empirical analysis (predictive posterior)
python ../../Python/sampling_lineages_simulated.py -n_reps 100 -bin_path "../../data_2023/simulated_data/EOM_bins.csv" -post_path "../../results/SALMA_smoothed/genus_level/1-Full/" -out "./data_2023/simulated_data/All_lineages_TsTe"
