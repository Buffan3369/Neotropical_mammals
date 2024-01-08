#!/bin/bash

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level
	do
		for ana in 1-Full 2-Singleton
		do
			#specify arguments
			rtt=../results/$s/$ss/$ana/combined_logs/RTT_plots.r 
			ltt=../results/$s/$ss/$ana/LTT/per_replicate/
			q=../results/$s/$ss/$ana/Q_SHIFTS/Parsed_Q_rates.csv
			out=../results/$s/$ss/$ana/RTT_LTT_${s}_${ss}_${ana}.png
			acc=~/Documents/GitHub/CorsaiR/R/
			#execute plotting function
			Rscript ~/Documents/GitHub/CorsaiR/R/Plot_rates.r "RJMCMC" $rtt $ltt $q $out $acc
		done
	done
done
