#!/bin/bash

for dir in SALMA_kept/genus_level/1-Full/BDS_5M SALMA_kept/genus_level/1-Full/BDS SALMA_smoothed/genus_level/1-Full/BDS SALMA_smoothed/genus_level/1-Full/BDS_5M
do
	#Combine logs
	python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag mcmc -b 10
	python ~/PyRate/PyRate.py -combLog ../../results_EXTENDED/$dir/pyrate_mcmc_logs -tag marginal_rates -b 10
	mkdir -p ../../results_EXTENDED/$dir/combined_logs
	mv ../../results_EXTENDED/$dir/pyrate_mcmc_logs/combined_* ../../results_EXTENDED/$dir/combined_logs
	#Plot RTT
	python ~/PyRate/PyRate.py -plot2 ../../results_EXTENDED/$dir/combined_logs -b 10
done
