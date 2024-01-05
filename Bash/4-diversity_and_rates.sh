#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=100 [SALMA_kept/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10)

for s in SALMA_kept SALMA_smoothed 
do
    for ss in genus_level
    do
        for ana in 1-Full 2-Singleton
        do
            #Combine logs
            python3.8 ~/PyRate/PyRate.py -combLogRJ ../results/$s/$ss/$ana/pyrate_mcmc_logs -tag _KEEP -b ${burnin1[$s/$ss/$ana]}
            mkdir -p ../$s/$ss/$ana/combined_logs
            mv ../results/$s/$ss/$ana/pyrate_mcmc_logs/combined_* ../$s/$ss/$ana/combined_logs
            #Plot RTT
            python3.8 ~/PyRate/PyRate.py -plotRJ ../$s/$ss/$ana/combined_logs -b ${burnin1[$s/$ss/$ana]}
            #Plot LTT
            mkdir -p ../$s/$ss/$ana/LTT/
            python3.8 ~/PyRate/PyRate.py -ginput ../$s/$ss/$ana/combined_logs -b ${burnin1[$s/$ss/$ana]}
            mv ../$s/$ss/$ana/combined_logs/*_se_est.txt ../$s/$ss/$ana/LTT/
            mv ../$s/$ss/$ana/combined_logs/*_LTT.r ../$s/$ss/$ana/LTT/
            #Diversity through time in the right format for MBD
            python3.8 ~/PyRate/PyRate.py -d ../$s/$ss/$ana/LTT/*_se_est.txt -ltt 1
        done
    done
done
