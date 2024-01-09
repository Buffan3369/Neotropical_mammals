#!/bin/bash

basal_dir="$PWD"/../../results/SALMA_smoothed/genus_level/simulations

for i in {0..12}
do
	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir ${basal_dir}/replicate_$i/pyrate_mcmc_logs/
	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r ${basal_dir}/replicate_$i/pyrate_mcmc_logs/ESS_summary.txt ${basal_dir}/replicate_$i/pyrate_mcmc_logs/ESS_plot_${type}.png
done
