#!/bin/bash

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level
	do
		for ana in 1-Full 2-Singleton
		do
			#specify arguments
			rtt=../results/$s/$ss/$ana/combined_logs/q_stages/RTT_plots.r 
			ltt=../results/$s/$ss/$ana/LTT/q_stages/per_replicate/
			q=../results/$s/$ss/$ana/Q_SHIFTS/q_stages/Parsed_Q_rates.csv
			out=../results/$s/$ss/$ana/RTT_LTT_${s}_${ss}_${ana}.png
			#execute plotting function
			Rscript ~/Documents/GitHub/CorsaiR/R/Plot_rates.r $rtt $ltt $q $out
		done
	done
done
