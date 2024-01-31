#!/bin/bash

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
#		for ana in 1-Full 2-Singleton 3-Spatially_scaled
#		do
#			#specify arguments
#			rtt=../results/$s/$ss/$ana/combined_logs/RTT_plots.r 
#			ltt=../results/$s/$ss/$ana/LTT/per_replicate/
#			q=../results/$s/$ss/$ana/Q_SHIFTS/Parsed_Q_rates.csv
#			out_plot=../figures/Sensitivity_analyses/Mustersan_38.2_35/RTT_LTT_${s}_${ss}_${ana}.png
#			out_freq=../figures/Sensitivity_analyses/Mustersan_38.2_35/freq_rate_shifts_${s}_${ss}_${ana}.png
#			acc=~/Documents/GitHub/CorsaiR/R/
#			#execute plotting function
#			Rscript ../R/fancy_plots/2-Plot_rates.r "RJMCMC" $rtt $ltt $q $out_plot $out_freq $acc
#		done
		for T in Tropical Extratropical
		do
			rtt=../results/$s/$ss/4-Tropical_Extratropical/$T/combined_logs/RTT_plots.r 
			ltt=../results/$s/$ss/4-Tropical_Extratropical/$T/LTT/per_replicate/
			q=../results/$s/$ss/4-Tropical_Extratropical/$T/Q_SHIFTS/Parsed_Q_rates.csv
			out_plot=../figures/Sensitivity_analyses/Mustersan_38.2_35/RTT_LTT_${s}_${ss}_$T.png
			out_freq=../figures/Sensitivity_analyses/Mustersan_38.2_35/freq_rate_shifts_${s}_${ss}_$T.png
			acc=~/Documents/GitHub/CorsaiR/R/
			#execute plotting function
			Rscript ../R/fancy_plots/2-Plot_rates.r "RJMCMC" $rtt $ltt $q $out_plot $out_freq $acc
		done
		for E in carnivore herbivore omnivore insectivore
		do
			rtt=../results/$s/$ss/5-Ecomorphotype/$E/combined_logs/RTT_plots.r 
			ltt=../results/$s/$ss/5-Ecomorphotype/$E/LTT/per_replicate/
			q=../results/$s/$ss/5-Ecomorphotype/$E/Q_SHIFTS/Parsed_Q_rates.csv
			out_plot=../figures/Sensitivity_analyses/Mustersan_38.2_35/RTT_LTT_${s}_${ss}_$E.png
			out_freq=../figures/Sensitivity_analyses/Mustersan_38.2_35/freq_rate_shifts_${s}_${ss}_$E.png
			acc=~/Documents/GitHub/CorsaiR/R/
			#execute plotting function
			Rscript ../R/fancy_plots/2-Plot_rates.r "RJMCMC" $rtt $ltt $q $out_plot $out_freq $acc

		done
	done
done
