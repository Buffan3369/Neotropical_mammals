#!/bin/bash

declare -A burnin1=([SALMA_kept/species_level/1-Full]=50 \
		    [SALMA_kept/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/genus_level/4-Tropical_Extratropical/Extratropical]=50 \
		    [SALMA_smoothed/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/genus_level/4-Tropical_Extratropical/Extratropical]=10)

ana=4-Tropical_Extratropical

for s in SALMA_kept SALMA_smoothed
do
	for ss in species_level
	do
		### Full ###
		python ~/PyRate/PyRate.py -combLogRJ ../results_EXTENDED/$s/$ss/1-Full/pyrate_mcmc_logs -tag KEEP -b ${burnin1[$s/$ss/1-Full]}
		mkdir -p ../results_EXTENDED/$s/$ss/1-Full/combined_logs
		mv ../results_EXTENDED/$s/$ss/1-Full/pyrate_mcmc_logs/combined_* ../results_EXTENDED/$s/$ss/1-Full/combined_logs
		#Plot RTT
		python ~/PyRate/PyRate.py -plotRJ ../results_EXTENDED/$s/$ss/1-Full/combined_logs -b ${burnin1[$s/$ss/1-Full]}
		#Plot LTT
		mkdir -p ../results_EXTENDED/$s/$ss/1-Full/LTT/
		python ~/PyRate/PyRate.py -ginput ../results_EXTENDED/$s/$ss/1-Full/pyrate_mcmc_logs -tag KEEP_ -b ${burnin1[$s/$ss/1-Full]}
		mv ../results_EXTENDED/$s/$ss/1-Full/pyrate_mcmc_logs/*_se_est.txt ../results_EXTENDED/$s/$ss/1-Full/LTT/
		mv ../results_EXTENDED/$s/$ss/1-Full/combined_logs/*_LTT.r ../results_EXTENDED/$s/$ss/1-Full/LTT/
		#Diversity through time in the right format for BDS and MBD
		python ~/PyRate/PyRate.py -d ../results_EXTENDED/$s/$ss/1-Full/LTT/*_se_est.txt -ltt 1
		
		### Tropical/Extratropical ###
#		for dir in Tropical Extratropical
#		do
#			#Combine logs
#			python ~/PyRate/PyRate.py -combLogRJ ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/pyrate_mcmc_logs -tag KEEP -b ${burnin1[$s/$ss/4-Tropical_Extratropical/$dir]}
#			mkdir -p ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/combined_logs
#			mv ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/pyrate_mcmc_logs/combined_* ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/combined_logs
#			#Plot RTT
#			python ~/PyRate/PyRate.py -plotRJ ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/combined_logs -b ${burnin1[$s/$ss/4-Tropical_Extratropical/$dir]}
#			#Plot LTT
#			mkdir -p ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/LTT/
#			python ~/PyRate/PyRate.py -ginput ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/pyrate_mcmc_logs -tag KEEP_ -b ${burnin1[$s/$ss/4-Tropical_Extratropical/$dir]}
#			mv ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/pyrate_mcmc_logs/*_se_est.txt ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/LTT/
#			mv ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/combined_logs/*_LTT.r ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/LTT/
#			#Diversity through time in the right format for BDS and MBD
#			python ~/PyRate/PyRate.py -d ../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/$dir/LTT/*_se_est.txt -ltt 1
#		done
	done
done
