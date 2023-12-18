#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=100 [SALMA_kept/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10)

for s in SALMA_kept SALMA_smoothed 
do
    for ss in genus_level
    do
        for ana in 1-Full 2-Singleton
        do
            #Combine logs
            python3.8 ~/PyRate/PyRate.py -combLogRJ ../results/$s/$ss/$ana/pyrate_mcmc_logs -tag _KEEP -b ${burnin1[${type}]}
            mkdir -p ../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages
            mv ../results/$s/$ss/$ana/pyrate_mcmc_logs/combined_* ../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages
            #Plot RTT
            python3.8 ~/PyRate/PyRate.py -plotRJ ../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages -b ${burnin1[${type}]}
            #Plot LTT
            mkdir -p ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/
            python3.8 ~/PyRate/PyRate.py -ginput ../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages -b ${burnin1[${type}]}
            mv ../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages/*_se_est.txt ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/
            mv ../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages/*_LTT.r ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/
            #Diversity through time in the right format for MBD
            python3.8 ~/PyRate/PyRate.py -d ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/*_se_est.txt -ltt 1
        done
    done
done
