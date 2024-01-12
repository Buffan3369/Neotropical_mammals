#!/bin/bash

basal_dir=../../results/SALMA_smoothed/genus_level/simulations

for i in {13..55} 
do
	# For each individual retained run
	for file in ${basal_dir}/replicate_$i/pyrate_mcmc_logs/*_KEEP_mcmc.log
	do
		python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../../data_2023/EO_stages.txt -b 10
	done
	# Parse and save individual q_rates to compile them in a table
	mkdir -p ${basal_dir}/replicate_$i/Q_SHIFTS
	mv ./*_Qrates* ${basal_dir}/replicate_$i/Q_SHIFTS
	python ~/Documents/GitHub/CorsaiR/Python/parse_Q_rates.py -dir ${basal_dir}/replicate_$i/Q_SHIFTS -out ${basal_dir}/replicate_$i/Q_SHIFTS/Parsed_Q_rates.csv
done



