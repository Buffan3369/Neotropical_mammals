#!/bin/bash

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level species_level
	do
		## Analyses from 1 to 3
#		for ana in 1-Full 2-Singleton 3-Spatially_scaled
#		do
#			python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../results/$s/$ss/$ana/pyrate_mcmc_logs	
#			Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/../results/$s/$ss/$ana/pyrate_mcmc_logs/ESS_summary.txt "$PWD"/../results/$s/$ss/$ana/pyrate_mcmc_logs/ESS_plot.png
#		done
		## Tropical / Extratropical
		for T in Tropical Extratropical
		do
			python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../results/$s/$ss/4-Tropical_Extratropical/$T/pyrate_mcmc_logs
			Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/../results/$s/$ss/4-Tropical_Extratropical/$T/pyrate_mcmc_logs/ESS_summary.txt "$PWD"/../results/$s/$ss/4-Tropical_Extratropical/$T/pyrate_mcmc_logs/ESS_plot.png
		done
		## Ecomorphotype
		for E in carnivore herbivore omnivore insectivore
		do
			python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../results/$s/$ss/5-Ecomorphotype/$E/pyrate_mcmc_logs
			Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/../results/$s/$ss/5-Ecomorphotype/$E/pyrate_mcmc_logs/ESS_summary.txt "$PWD"/../results/$s/$ss/5-Ecomorphotype/$E/pyrate_mcmc_logs/ESS_plot.png
		done
		## Order Level
#		for O in Notoungulata Other_SANUs Rodentia Xenarthra Metatheria
#		do
#			python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../results/$s/$ss/6-Order_level/$O/pyrate_mcmc_logs
#			Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/../results/$s/$ss/6-Order_level/$O/pyrate_mcmc_logs/ESS_summary.txt "$PWD"/../results/$s/$ss/6-Order_level/$O	/pyrate_mcmc_logs/ESS_plot.png
#		done
	done
done	
