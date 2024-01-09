#!/bin/bash

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level
	do
		for ana in 1-Full 2-Singleton
		do
			python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../results/$s/$ss/$ana/pyrate_mcmc_logs/
			Rscript ~/Documents/GitHub/CorsaiR/Python/plot_ess.r "$PWD"/../results/$s/$ss/$ana/pyrate_mcmc_logs/ESS_summary.txt "$PWD"/../results/$s/$ss/$ana/pyrate_mcmc_logs/ESS_plot_${type}.png
		done
	done
done
