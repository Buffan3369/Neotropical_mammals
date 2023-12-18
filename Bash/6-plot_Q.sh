#!/bin/bash

declare -A burnin1=([regular]=10 [spatially_scaled]=10)

for type in regular spatially_scaled
do
    # For each individual retained run
    for file in ../EOCENE_OLIGOCENE_${type}/q_stages/pyrate_mcmc_logs/*_KEEP_mcmc.log
	    do
	    python3.8 ~/PyRate/PyRate.py -plotQ ${file} -qShift ../EO_stages.txt -b ${burnin1[${type}]}
	    done
    mkdir -p ../EOCENE_OLIGOCENE_${type}/Q_SHIFTS/q_stages
    mv ./*_Qrates* ../EOCENE_OLIGOCENE_${type}/Q_SHIFTS/q_stages
    #Parse and save individual q_rates to compile them in a table
    python3.8 ~/PyRate/parse_Q_rates.py -dir ../EOCENE_OLIGOCENE_${type}/Q_SHIFTS/q_stages -out ../EOCENE_OLIGOCENE_${type}/Q_SHIFTS/q_stages/Parsed_Q_rates.csv
done

