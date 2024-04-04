#!/bin/bash

#for dir in SALMA_kept/genus_level/1-Full/BDS_5M SALMA_kept/genus_level/1-Full/BDS SALMA_smoothed/genus_level/1-Full/BDS SALMA_smoothed/genus_level/1-Full/BDS_5M \
#	SALMA_kept/species_level/1-Full/BDCS SALMA_kept/species_level/1-Full/BDCS_5M
#do
#	#Combine logs
#	python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag mcmc -b 10
#	python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag marginal_rates -b 10
#	mkdir -p ../../results_EXTENDED/$dir/combined_logs
#	mv ../../results_EXTENDED/$dir/pyrate_mcmc_logs/combined_* ../../results_EXTENDED/$dir/combined_logs
#	#Plot RTT
#	python ~/PyRate/PyRate.py -plot2 ../../results_EXTENDED/$dir/combined_logs -b 10
#done


#for s in SALMA_kept SALMA_smoothed
#do
#	for ss in BDCS BDCS_5M
#	do
#		for ana in Tropical Extratropical
#		do
#			dir=$s/genus_level/4-Tropical_Extratropical/$ss/$ana
#			#Combine logs
#			python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag mcmc -b 10
#			python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag marginal_rates -b 10
#			mkdir -p ../../results_EXTENDED/$dir/combined_logs
#			mv ../../results_EXTENDED/$dir/pyrate_mcmc_logs/combined_* ../../results_EXTENDED/$dir/combined_logs
#			#Plot RTT
#			python ~/PyRate/PyRate.py -plot2 ../../results_EXTENDED/$dir/combined_logs -b 10
#		done
#	done
#done

for s in SALMA_smoothed
do
	for ss in species_level
	do
		for ana in BDCS BDCS_5M
		do
			for odr in Notoungulata Other_SANUs Rodentia Xenarthra Metatheria
			do
				dir=$s/$ss/6-Order_level/$odr/$ana
				#Combine logs
				python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag mcmc -b 10
				python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag marginal_rates -b 10
				mkdir -p ../../results_EXTENDED/$dir/combined_logs
				mv ../../results_EXTENDED/$dir/pyrate_mcmc_logs/combined_* ../../results_EXTENDED/$dir/combined_logs
				#Plot RTT
				python ~/PyRate/PyRate.py -plot2 ../../results_EXTENDED/$dir/combined_logs -b 10
			done
		done
	done
done
