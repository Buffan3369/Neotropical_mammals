#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=100 [SALMA_kept/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10)

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level
	do
		for ana in 1-Full 2-Singleton
		do
			# For each individual retained run
			for file in ../$s/$ss/$ana/q_stages/pyrate_mcmc_logs/*_KEEP_mcmc.log
			do
				python3.8 ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/EO_stages.txt -b ${burnin1[$s/$ss/$ana]}
				done
				mkdir -p ../$s/$ss/$ana/Q_SHIFTS/q_stages
				mv ./*_Qrates* ../$s/$ss/$ana/Q_SHIFTS/q_stages
				#Parse and save individual q_rates to compile them in a table
				python3.8 ~/PyRate/parse_Q_rates.py -dir ../$s/$ss/$ana/Q_SHIFTS/q_stages -out ../$s/$ss/$ana/Q_SHIFTS/q_stages/Parsed_Q_rates.csv
			done
		done
	done
done



