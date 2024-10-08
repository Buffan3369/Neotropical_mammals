#!/bin/bash

## Burn-in dictionary
declare -A burnin1=([SALMA_kept/genus_level/1-Full]=10 \ 
#		[SALMA_kept/genus_level/2-Singleton]=50 [SALMA_kept/genus_level/3-Spatially_scaled]=10 \
#		[SALMA_kept/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/genus_level/4-Tropical_Extratropical/Extratropical]=50 \
#		[SALMA_kept/genus_level/5-Ecomorphotype/carnivore]=10 [SALMA_kept/genus_level/5-Ecomorphotype/herbivore]=10 [SALMA_kept/genus_level/5-Ecomorphotype/omnivore]=10 \
#		[SALMA_kept/genus_level/5-Ecomorphotype/insectivore]=10 [SALMA_kept/genus_level/6-Order_level/Notoungulata]=10 [SALMA_kept/genus_level/6-Order_level/Other_SANUs]=10 \
#		[SALMA_kept/genus_level/6-Order_level/Rodentia]=10 [SALMA_kept/genus_level/6-Order_level/Xenarthra]=10 [SALMA_kept/genus_level/6-Order_level/Metatheria]=10 \
#		##
#		[SALMA_kept/species_level/1-Full]=250 [SALMA_kept/species_level/2-Singleton]=250 [SALMA_kept/species_level/3-Spatially_scaled]=50 \
#		[SALMA_kept/species_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/species_level/4-Tropical_Extratropical/Extratropical]=50 \
#		[SALMA_kept/species_level/5-Ecomorphotype/carnivore]=10 [SALMA_kept/species_level/5-Ecomorphotype/herbivore]=50 [SALMA_kept/species_level/5-Ecomorphotype/omnivore]=10 \
#		[SALMA_kept/species_level/5-Ecomorphotype/insectivore]=10 [SALMA_kept/species_level/6-Order_level/Notoungulata]=100 [SALMA_kept/species_level/6-Order_level/Other_SANUs]=10 \
#		[SALMA_kept/species_level/6-Order_level/Rodentia]=10 [SALMA_kept/species_level/6-Order_level/Xenarthra]=10 [SALMA_kept/species_level/6-Order_level/Metatheria]=10 \
		##
		[SALMA_smoothed/genus_level/1-Full]=10 \
#		[SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=10 \
#		[SALMA_smoothed/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/genus_level/4-Tropical_Extratropical/Extratropical]=10 \
#		[SALMA_smoothed/genus_level/5-Ecomorphotype/carnivore]=10 [SALMA_smoothed/genus_level/5-Ecomorphotype/herbivore]=10 [SALMA_smoothed/genus_level/5-Ecomorphotype/omnivore]=10 \
#		[SALMA_smoothed/genus_level/5-Ecomorphotype/insectivore]=10 [SALMA_smoothed/genus_level/6-Order_level/Notoungulata]=10 [SALMA_smoothed/genus_level/6-Order_level/Other_SANUs]=10 \
#		[SALMA_smoothed/genus_level/6-Order_level/Rodentia]=10 [SALMA_smoothed/genus_level/6-Order_level/Xenarthra]=10 [SALMA_smoothed/genus_level/6-Order_level/Metatheria]=10 \
		##
#		[SALMA_smoothed/species_level/1-Full]=250 [SALMA_smoothed/species_level/2-Singleton]=50 [SALMA_smoothed/species_level/3-Spatially_scaled]=10 \
#		[SALMA_smoothed/species_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/species_level/4-Tropical_Extratropical/Extratropical]=50 \
#		[SALMA_smoothed/species_level/5-Ecomorphotype/carnivore]=10 [SALMA_smoothed/species_level/5-Ecomorphotype/herbivore]=10 [SALMA_smoothed/species_level/5-Ecomorphotype/omnivore]=10 \
#		[SALMA_smoothed/species_level/5-Ecomorphotype/insectivore]=10 [SALMA_smoothed/species_level/6-Order_level/Notoungulata]=10 [SALMA_smoothed/species_level/6-Order_level/Other_SANUs]=10 \
#		[SALMA_smoothed/species_level/6-Order_level/Rodentia]=10 [SALMA_smoothed/species_level/6-Order_level/Xenarthra]=10 [SALMA_smoothed/species_level/6-Order_level/Metatheria]=10
		)


for s in SALMA_smoothed SALMA_kept
do
	for ss in genus_level
	do
#		for ana in 1-Full 
#		2-Singleton 3-Spatially_scaled
#		do
			# For each individual retained run
#			for file in ../results_EXTENDED/$s/$ss/$ana/MH_sampler/pyrate_mcmc_logs/*_KEEP_mcmc.log
#			do
#				python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/Extended_EO_stages.txt -b ${burnin1[$s/$ss/$ana]}
#			done
			# Parse and save individual q_rates to compile them in a table
#			mkdir -p ../results_EXTENDED/$s/$ss/$ana/MH_sampler/Q_SHIFTS
#			mv ./*_Qrates* ../results_EXTENDED/$s/$ss/$ana/MH_sampler/Q_SHIFTS
#			python ~/Documents/GitHub/CorsaiR/Python/parse_Q_rates.py -dir ../results_EXTENDED/$s/$ss/$ana/MH_sampler/Q_SHIFTS -out ../results_EXTENDED/$s/$ss/$ana/MH_sampler/Q_SHIFTS/Parsed_Q_rates.csv
#		done
		## Tropical / Extratropicals
		for T in Extratropical Tropical
		do
#			for file in ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/RJMCMC/$T/pyrate_mcmc_logs/*_KEEP_mcmc.log
#			do
#				python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/Extended_EO_stages.txt -b 10
#			done
#			# Parse and save individual q_rates to compile them in a table
#			mkdir -p ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/RJMCMC/$T/Q_SHIFTS
#			mv ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/RJMCMC/$T/pyrate_mcmc_logs/*_Qrates* ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/RJMCMC/$T/Q_SHIFTS
			python ~/Documents/GitHub/CorsaiR/Python/parse_Q_rates.py -q_dir ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/RJMCMC/$T/Q_SHIFTS -bin_dir ../data_2023/Extended_EO_stages.txt -out ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/RJMCMC/$T/Q_SHIFTS/Parsed_Q_rates.txt
		done
#		## Ecomorphotype
#		for E in carnivore herbivore omnivore insectivore
#		do
#			for file in ../results/$s/$ss/5-Ecomorphotype/$E/pyrate_mcmc_logs/*_KEEP_mcmc.log
#			do
#				python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/EO_stages.txt -b ${burnin1[$s/$ss/5-Ecomorphotype/$E]}
#			done
#			# Parse and save individual q_rates to compile them in a table
#			mkdir -p ../results/$s/$ss/5-Ecomorphotype/$E/Q_SHIFTS
#			mv ./*_Qrates* ../results/$s/$ss/5-Ecomorphotype/$E/Q_SHIFTS
#			python ~/Documents/GitHub/CorsaiR/Python/parse_Q_rates.py -dir ../results/$s/$ss/5-Ecomorphotype/$E/Q_SHIFTS -out ../results/$s/$ss/5-Ecomorphotype/$E/Q_SHIFTS/Parsed_Q_rates.csv
#		done
#		## Taxonomic assignment
#		for O in Notoungulata Other_SANUs Rodentia Xenarthra Metatheria
#		do
#			for file in ../results/$s/$ss/6-Order_level/$O/pyrate_mcmc_logs/*_KEEP_mcmc.log
#			do
#				python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/EO_stages.txt -b ${burnin1[$s/$ss/6-Order_level/$O]}
#			done
#			# Parse and save individual q_rates to compile them in a table
#			mkdir -p ../results/$s/$ss/6-Order_level/$O/Q_SHIFTS
#			mv ./*_Qrates* ../results/$s/$ss/6-Order_level/$O/Q_SHIFTS
#			python ~/Documents/GitHub/CorsaiR/Python/parse_Q_rates.py -dir ../results/$s/$ss/6-Order_level/$O/Q_SHIFTS -out ../results/$s/$ss/6-Order_level/$O/Q_SHIFTS/Parsed_Q_rates.csv
#		done
	done
done



