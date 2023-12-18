#!/bin/bash

for type in regular spatially_scaled
do
    #specify arguments
    rtt=../EOCENE_OLIGOCENE_${type}/combined_logs/q_stages/RTT_plots.r 
    ltt=../EOCENE_OLIGOCENE_${type}/LTT/q_stages/per_replicate/
    q=../EOCENE_OLIGOCENE_${type}/Q_SHIFTS/q_stages/Parsed_Q_rates.csv
    out=../../../../../REPO/Neotropical_mammals/figures/EOT/genus_level/${type}/RTT_LTT_q_stages.png
    #execute plotting function
    Rscript ~/PyRate/plot_rates.r $rtt $ltt $q $out 
done
