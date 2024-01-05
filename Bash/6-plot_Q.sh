#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=100 [SALMA_kept/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10)

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level
	do
		for ana in 1-Full 2-Singleton
		do
			# For each individual retained run
			for file in ../results/$s/$ss/$ana/pyrate_mcmc_logs/*_KEEP_mcmc.log
			do
				python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/EO_stages.txt -b ${burnin1[$s/$ss/$ana]}
			done
			# Parse and save individual q_rates to compile them in a table
			mkdir -p ../results/$s/$ss/$ana/Q_SHIFTS
			mv ./*_Qrates* ../results/$s/$ss/$ana/Q_SHIFTS
			python ~/Documents/GitHub/CorsaiR/Python/parse_Q_rates.py -dir ../results/$s/$ss/$ana/Q_SHIFTS -out ../results/$s/$ss/$ana/Q_SHIFTS/Parsed_Q_rates.csv
		done
	done
done



