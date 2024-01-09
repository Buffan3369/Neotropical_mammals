## Needs retained mcmc log files to have been previously flagged with "KEEP"

basal_dir=../../results/SALMA_smoothed/genus_level/simulations

for i in {0..12}
do
	mkdir -p ${basal_dir}/replicate_$i/LTT/tmp
	mkdir -p ${basal_dir}/replicate_$i/LTT/per_replicate
	for file in ${basal_dir}/replicate_$i/pyrate_mcmc_logs/*_KEEP_mcmc.log
	do
		cp ${file} ${basal_dir}/replicate_$i/LTT/tmp
		# LTT        
		python ~/PyRate/PyRate.py -ginput ${basal_dir}/replicate_$i/LTT/tmp -b 10
		# Diversity through time in the right format for MBD
		python ~/PyRate/PyRate.py -d ${basal_dir}/replicate_$i/LTT/tmp/*_se_est.txt -ltt 1
		# Move content of the temporary folder at another location and empty it
		mv ${basal_dir}/replicate_$i/LTT/tmp/* ${basal_dir}/replicate_$i/LTT/per_replicate
		rm ${basal_dir}/replicate_$i/LTT/tmp/*
	done
	#combining the TsTe of each replicate within a single file
	python ~/Documents/GitHub/CorsaiR/Python/comb_TsTe.py -dir "$PWD"/${basal_dir}/replicate_$i/LTT/per_replicate
done
