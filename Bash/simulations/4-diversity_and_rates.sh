#!/bin/bash

basal_dir=../../results/SALMA_smoothed/genus_level/simulations

for i in {0..12}
do
	#Combine logs
	python ~/PyRate/PyRate.py -combLogRJ ${basal_dir}/replicate_$i/pyrate_mcmc_logs -tag _KEEP -b 10
	mkdir -p ${basal_dir}/replicate_$i/combined_logs
	mv ${basal_dir}/replicate_$i/pyrate_mcmc_logs/combined_* ${basal_dir}/replicate_$i/combined_logs
	#Plot RTT
	python ~/PyRate/PyRate.py -plotRJ ${basal_dir}/replicate_$i/combined_logs -b 10
	#Plot LTT
        mkdir -p ${basal_dir}/replicate_$i/LTT/
        python ~/PyRate/PyRate.py -ginput ${basal_dir}/replicate_$i/combined_logs -b 10
        mv ${basal_dir}/replicate_$i/combined_logs/*_se_est.txt ${basal_dir}/replicate_$i/LTT/
        mv ${basal_dir}/replicate_$i/combined_logs/*_LTT.r ${basal_dir}/replicate_$i/LTT/
        #Diversity through time in the right format for MBD
        python ~/PyRate/PyRate.py -d ${basal_dir}/replicate_$i/LTT/*_se_est.txt -ltt 1
done
