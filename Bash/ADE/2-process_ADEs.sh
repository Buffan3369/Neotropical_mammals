#!/bin/bash

## Early phase -------------------------------------
pth=../../results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_early/pyrate_mcmc_logs_mG
	# Convergence
#python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir $pth -ana "ADE" -thr 100
	# Combine logs
#python ~/PyRate/PyRate.py -combLog $pth -tag KEEP_ADE_ADE_mcmc -b 10 -col_tag ['posterior', 'prior', 'PP_lik', 'BD_lik', 'q_0', 'q_1', 'q_2', 'q_3', 'alpha', 'root_age', 'death_age','w_shape',' w_scale_0']
python ~/PyRate/PyRate.py -combLog $pth -tag KEEP_ADE_ADE_mcmc -b 10 -col_tag w_

## Late phase ------------------------------------
pth=../../results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_late/pyrate_mcmc_logs_mG
	# Convergence
#python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir $pth -ana "ADE" -thr 100
	# Combine logs
#python ~/PyRate/PyRate.py -combLog $pth -tag KEEP_ADE_ADE_mcmc -b 10 -col_tag ['posterior', 'prior', 'PP_lik', 'BD_lik', 'q_0', 'q_1', 'q_2', 'q_3', 'alpha', 'root_age', 'death_age','w_shape',' w_scale_0']
