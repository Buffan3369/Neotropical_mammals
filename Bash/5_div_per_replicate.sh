## Needs retained mcmc log files to have been previously flagged with "KEEP"

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=100 [SALMA_kept/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10)

for s in SALMA_kept SALMA_smoothed 
do
	for ss in genus_level
	do
		for ana in 1-Full 2-Singleton
		do
			mkdir -p ../$s/$ss/$ana/LTT/q_stages/tmp_stages
			mkdir -p ../$s/$ss/$ana/LTT/q_stages/per_replicate
			for file in ../$s/$ss/$ana/q_stages/pyrate_mcmc_logs/*_KEEP_mcmc.log
			do
			cp ${file} ../$s/$ss/$ana/LTT/q_stages/tmp_stages
			# LTT        
			python3.8 ~/PyRate/PyRate.py -ginput ../$s/$ss/$ana/LTT/q_stages/tmp_stages -b ${burnin1[$s/$ss/$ana]}
			# Diversity through time in the right format for MBD
			python3.8 ~/PyRate/PyRate.py -d ../$s/$ss/$ana/LTT/q_stages/tmp_stages/*_se_est.txt -ltt 1
			# Move content of the temporary folder at another location and empty it
			mv ../$s/$ss/$ana/LTT/q_stages/tmp_stages/* ../$s/$ss/$ana/LTT/q_stages/per_replicate
			rm ../$s/$ss/$ana/LTT/q_stages/tmp_stages/*
			done
		#combining the TsTe of each replicate within a single file
		python3.8 ~/PyRate/comb_TsTe.py -dir "$PWD"/../$s/$ss/$ana/LTT/q_stages/per_replicate
		done
	done
done
