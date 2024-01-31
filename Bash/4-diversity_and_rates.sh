#!/bin/bash

## Burn-in dictionary
declare -A burnin1=([SALMA_kept/genus_level/1-Full]=500 [SALMA_kept/genus_level/2-Singleton]=50 [SALMA_kept/genus_level/3-Spatially_scaled]=10 \
		[SALMA_kept/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/genus_level/4-Tropical_Extratropical/Extratropical]=50 \
		[SALMA_kept/genus_level/5-Ecomorphotype/carnivore]=10 [SALMA_kept/genus_level/5-Ecomorphotype/herbivore]=10 [SALMA_kept/genus_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_kept/genus_level/5-Ecomorphotype/insectivore]=10 \
		##
		[SALMA_kept/species_level/1-Full]=250 [SALMA_kept/species_level/2-Singleton]=250 [SALMA_kept/species_level/3-Spatially_scaled]=50 \
		[SALMA_kept/species_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/species_level/4-Tropical_Extratropical/Extratropical]=50 \
		[SALMA_kept/species_level/5-Ecomorphotype/carnivore]=10 [SALMA_kept/species_level/5-Ecomorphotype/herbivore]=50 [SALMA_kept/species_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_kept/species_level/5-Ecomorphotype/insectivore]=10 \
		##
		[SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=10 \
		[SALMA_smoothed/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/genus_level/4-Tropical_Extratropical/Extratropical]=10 \
		[SALMA_smoothed/genus_level/5-Ecomorphotype/carnivore]=10 [SALMA_smoothed/genus_level/5-Ecomorphotype/herbivore]=10 [SALMA_smoothed/genus_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_smoothed/genus_level/5-Ecomorphotype/insectivore]=10 \
		##
		[SALMA_smoothed/species_level/1-Full]=250 [SALMA_smoothed/species_level/2-Singleton]=50 [SALMA_smoothed/species_level/3-Spatially_scaled]=10 \
		[SALMA_smoothed/species_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/species_level/4-Tropical_Extratropical/Extratropical]=50 \
		[SALMA_smoothed/species_level/5-Ecomorphotype/carnivore]=10 [SALMA_smoothed/species_level/5-Ecomorphotype/herbivore]=10 [SALMA_smoothed/species_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_smoothed/species_level/5-Ecomorphotype/insectivore]=10)
		
		
for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
#		for ana in 1-Full 2-Singleton 3-Spatially_scaled
#		do
#			#Combine logs
#			python ~/PyRate/PyRate.py -combLogRJ ../results/$s/$ss/$ana/pyrate_mcmc_logs -tag _KEEP -b ${burnin1[$s/$ss/$ana]}
#			mkdir -p ../results/$s/$ss/$ana/combined_logs
#			mv ../results/$s/$ss/$ana/pyrate_mcmc_logs/combined_* ../results/$s/$ss/$ana/combined_logs
#			#Plot RTT
#			python ~/PyRate/PyRate.py -plotRJ ../results/$s/$ss/$ana/combined_logs -b ${burnin1[$s/$ss/$ana]}
#			#Plot LTT
#			mkdir -p ../results/$s/$ss/$ana/LTT/
#			python ~/PyRate/PyRate.py -ginput ../results/$s/$ss/$ana/combined_logs -b ${burnin1[$s/$ss/$ana]}
#			mv ../results/$s/$ss/$ana/combined_logs/*_se_est.txt ../results/$s/$ss/$ana/LTT/
#			mv ../results/$s/$ss/$ana/combined_logs/*_LTT.r ../results/$s/$ss/$ana/LTT/
#			#Diversity through time in the right format for MBD
#			python ~/PyRate/PyRate.py -d ../results/$s/$ss/$ana/LTT/*_se_est.txt -ltt 1
#		done
		## Tropical
		for T in Tropical Extratropical
		do
			#Combine logs
			python ~/PyRate/PyRate.py -combLogRJ ../results/$s/$ss/4-Tropical_Extratropical/$T/pyrate_mcmc_logs -tag _KEEP -b ${burnin1[$s/$ss/4-Tropical_Extratropical/$T]}
			mkdir -p ../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs
			mv ../results/$s/$ss/4-Tropical_Extratropical/$T/pyrate_mcmc_logs/combined_* ../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs
			#Plot RTT
			python ~/PyRate/PyRate.py -plotRJ ../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs -b ${burnin1[$s/$ss/4-Tropical_Extratropical/$T]}
			#Plot LTT
			mkdir -p ../results/$s/$ss/4-Tropical_Extratropical/$T/LTT/
			python ~/PyRate/PyRate.py -ginput ../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs -b ${burnin1[$s/$ss/4-Tropical_Extratropical/$T]}
			mv ../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs/*_se_est.txt ../results/$s/$ss/4-Tropical_Extratropical/$T/LTT/
			mv ../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs/*_LTT.r ../results/$s/$ss/4-Tropical_Extratropical/$T/LTT/
			#Diversity through time in the right format for MBD
			python ~/PyRate/PyRate.py -d ../results/$s/$ss/4-Tropical_Extratropical/$T/LTT/*_se_est.txt -ltt 1
		done
		## Ecomorphotype
		for E in carnivore herbivore omnivore insectivore
		do
			#Combine logs
			python ~/PyRate/PyRate.py -combLogRJ ../results/$s/$ss/5-Ecomorphotype/$E/pyrate_mcmc_logs -tag _KEEP -b ${burnin1[$s/$ss/5-Ecomorphotype/$E]}
			mkdir -p ../results/$s/$ss/5-Ecomorphotype/$E/combined_logs
			mv ../results/$s/$ss/5-Ecomorphotype/$E/pyrate_mcmc_logs/combined_* ../results/$s/$ss/5-Ecomorphotype/$E/combined_logs
			#Plot RTT
			python ~/PyRate/PyRate.py -plotRJ ../results/$s/$ss/5-Ecomorphotype/$E/combined_logs -b ${burnin1[$s/$ss/5-Ecomorphotype/$E]}
			#Plot LTT
			mkdir -p ../results/$s/$ss/5-Ecomorphotype/$E/LTT/
			python ~/PyRate/PyRate.py -ginput ../results/$s/$ss/5-Ecomorphotype/$E/combined_logs -b ${burnin1[$s/$ss/5-Ecomorphotype/$E]}
			mv ../results/$s/$ss/5-Ecomorphotype/$E/combined_logs/*_se_est.txt ../results/$s/$ss/5-Ecomorphotype/$E/LTT/
			mv ../results/$s/$ss/5-Ecomorphotype/$E/combined_logs/*_LTT.r ../results/$s/$ss/5-Ecomorphotype/$E/LTT/
			#Diversity through time in the right format for MBD
			python ~/PyRate/PyRate.py -d ../results/$s/$ss/5-Ecomorphotype/$E/LTT/*_se_est.txt -ltt 1
		done
	done
done
