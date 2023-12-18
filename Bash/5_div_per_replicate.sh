## Needs retained mcmc log files to have been previously flagged with "KEEP"

declare -A burnin1=([regular]=10 [spatially_scaled]=10)

for type in regular spatially_scaled
do
    mkdir -p ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/tmp_stages
    mkdir -p ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/per_replicate
    for file in ../EOCENE_OLIGOCENE_${type}/q_stages/pyrate_mcmc_logs/*_KEEP_mcmc.log
    do
        cp ${file} ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/tmp_stages
        # LTT        
        python3.8 ~/PyRate/PyRate.py -ginput ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/tmp_stages -b ${burnin1[${type}]}
        # Diversity through time in the right format for MBD
        python3.8 ~/PyRate/PyRate.py -d ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/tmp_stages/*_se_est.txt -ltt 1
      	# Move content of the temporary folder at another location and empty it
        mv ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/tmp_stages/* ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/per_replicate
        rm ../EOCENE_OLIGOCENE_${type}/LTT/q_stages/tmp_stages/*
    done
    #combining the TsTe of each replicate within a single file
    python3.8 ~/PyRate/comb_TsTe.py -dir "$PWD"/../EOCENE_OLIGOCENE_${type}/LTT/q_stages/per_replicate
done

