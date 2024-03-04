#!/bin/bash

#python ~/PyRate/PyRate.py -plot ../../results/BDCS/SALMA_smoothed/genus-level/1-Full/pyrate_mcmc_logs/ -tag TsTe -b 20
#mv *.r ../../results/BDCS/SALMA_smoothed/genus-level/1-Full/combined_logs
Rscript ~/Documents/GitHub/CorsaiR/R/Plot_rates.r "BDS" \
					"../../results/BDCS/SALMA_smoothed/genus-level/1-Full/combined_logs/TsTe_good_format_0__BDS_marginal_rates_RTT.r" \
					"../../results/SALMA_smoothed/genus-level/1-Full/LTT/per_replicate/" \
					"../../results/SALMA_smoothed/genus-level/1-Full/Q_SHIFTS/Parsed_Q_rates.csv" \
					"../../figures/BDCS/RTT_LTT_Q_all_genera.png" \
					"~/Documents/GitHub/CorsaiR/R/"
			  	      
