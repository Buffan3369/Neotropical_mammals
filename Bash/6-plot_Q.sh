#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=500 [SALMA_kept/genus_level/2-Singleton]=50 [SALMA_kept/genus_level/3-Spatially_scaled]=10 \
		[SALMA_kept/species_level/1-Full]=250 [SALMA_kept/species_level/2-Singleton]=250 [SALMA_kept/species_level/3-Spatially_scaled]=50 \
		[SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=10 \
		[SALMA_smoothed/species_level/1-Full]=250 [SALMA_smoothed/species_level/2-Singleton]=50 [SALMA_smoothed/species_level/3-Spatially_scaled]=10)


for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		for ana in 1-Full 2-Singleton 3-Spatially_scaled
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



