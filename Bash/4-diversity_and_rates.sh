#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=100 [SALMA_kept/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=10 [SALMA_kept/genus_level/3-Spatially_scaled]=10)

for s in SALMA_kept SALMA_smoothed 
do
    for ss in genus_level
    do
        for ana in 3-Spatially_scaled
        do
            #Combine logs
            python ~/PyRate/PyRate.py -combLogRJ ../results/$s/$ss/$ana/pyrate_mcmc_logs -tag _KEEP -b ${burnin1[$s/$ss/$ana]}
            mkdir -p ../results/$s/$ss/$ana/combined_logs
            mv ../results/$s/$ss/$ana/pyrate_mcmc_logs/combined_* ../results/$s/$ss/$ana/combined_logs
            #Plot RTT
            python ~/PyRate/PyRate.py -plotRJ ../results/$s/$ss/$ana/combined_logs -b ${burnin1[$s/$ss/$ana]}
            #Plot LTT
            mkdir -p ../results/$s/$ss/$ana/LTT/
            python ~/PyRate/PyRate.py -ginput ../results/$s/$ss/$ana/combined_logs -b ${burnin1[$s/$ss/$ana]}
            mv ../results/$s/$ss/$ana/combined_logs/*_se_est.txt ../results/$s/$ss/$ana/LTT/
            mv ../results/$s/$ss/$ana/combined_logs/*_LTT.r ../results/$s/$ss/$ana/LTT/
            #Diversity through time in the right format for MBD
            python ~/PyRate/PyRate.py -d ../results/$s/$ss/$ana/LTT/*_se_est.txt -ltt 1
        done
    done
done
