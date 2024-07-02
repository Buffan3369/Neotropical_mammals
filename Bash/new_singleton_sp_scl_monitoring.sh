#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/2-Singleton]=50 [SALMA_kept/genus_level/3-Spatially_scaled]=10 \
		    [SALMA_kept/species_level/2-Singleton]=50 [SALMA_kept/species_level/3-Spatially_scaled]=10 \
		    [SALMA_smoothed/species_level/2-Singleton]=100 [SALMA_smoothed/species_level/3-Spatially_scaled]=250 \
		    [SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=50)


for s in SALMA_kept 
do
	for ss in species_level
	do
		for ana in 3-Spatially_scaled
		do
			dir=../results_EXTENDED/$s/$ss/$ana
			## 1. Assess run cv (thr = 100, bad CV..)
#			python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/pyrate_mcmc_logs -thr 100
#			Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/pyrate_mcmc_logs/ESS_summary.txt "$PWD"/$dir/pyrate_mcmc_logs/ESS_plot.png
			## 2. RTT/LTT plots
#			python ~/PyRate/PyRate.py -combLogRJ $dir/pyrate_mcmc_logs -tag KEEP -b ${burnin1[$s/$ss/$ana]}
#			mkdir -p $dir/combined_logs
#			mv $dir/pyrate_mcmc_logs/combined_* $dir/combined_logs
#				#Plot RTT
#			python ~/PyRate/PyRate.py -plotRJ $dir/combined_logs -b ${burnin1[$s/$ss/$ana]}
#				#Plot LTT
#			mkdir -p $dir/LTT/
#			python ~/PyRate/PyRate.py -ginput $dir/pyrate_mcmc_logs -tag KEEP_ -b ${burnin1[$s/$ss/$ana]}
#			mv $dir/pyrate_mcmc_logs/*_se_est.txt $dir/LTT/
#			mv $dir/combined_logs/*_LTT.r $dir/LTT/
#				#Diversity through time in the right format for BDS and MBD
#			python ~/PyRate/PyRate.py -d $dir/LTT/*_se_est.txt -ltt 1
			## 3. Q rates
			for file in $dir/pyrate_mcmc_logs/*_KEEP_mcmc.log
			do
				python ~/PyRate/PyRate.py -plotQ ${file} -qShift ../data_2023/Extended_EO_stages.txt -b ${burnin1[$s/$ss/$ana]}
			done
				#Parse and save individual q_rates to compile them in a table
			mkdir -p $dir/Q_SHIFTS
			mv $dir/pyrate_mcmc_logs/*_Qrates* $dir/Q_SHIFTS
			python ~/Documents/GitHub/CorsaiR/Python/parsecd_Q_rates.py -q_dir $dir/Q_SHIFTS -bin_dir ../data_2023/Extended_EO_stages.txt -out $dir/Q_SHIFTS/Parsed_Q_rates.txt
		done
	done
done
