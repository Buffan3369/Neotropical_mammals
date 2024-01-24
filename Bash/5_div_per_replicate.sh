## Needs retained mcmc log files to have been previously flagged with "KEEP"

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=500 [SALMA_kept/genus_level/2-Singleton]=50 [SALMA_kept/genus_level/3-Spatially_scaled]=10 \
		[SALMA_kept/species_level/1-Full]=250 [SALMA_kept/species_level/2-Singleton]=250 [SALMA_kept/species_level/3-Spatially_scaled]=50 \
		[SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=10 \
		[SALMA_smoothed/species_level/1-Full]=250 [SALMA_smoothed/species_level/2-Singleton]=50 [SALMA_smoothed/species_level/3-Spatially_scaled]=10)

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		for ana in 1-Full 2-Singleton 3-Spatially_scaled
		do
			mkdir -p ../results/$s/$ss/$ana/LTT/tmp
			mkdir -p ../results/$s/$ss/$ana/LTT/per_replicate
			for file in ../results/$s/$ss/$ana/pyrate_mcmc_logs/*_KEEP_mcmc.log
			do
				cp ${file} ../results/$s/$ss/$ana/LTT/tmp
				# LTT        
				python ~/PyRate/PyRate.py -ginput ../results/$s/$ss/$ana/LTT/tmp -b ${burnin1[$s/$ss/$ana]}
				# Diversity through time in the right format for MBD
				python ~/PyRate/PyRate.py -d ../results/$s/$ss/$ana/LTT/tmp/*_se_est.txt -ltt 1
				# Move content of the temporary folder at another location and empty it
				mv ../results/$s/$ss/$ana/LTT/tmp/* ../results/$s/$ss/$ana/LTT/per_replicate
				rm ../results/$s/$ss/$ana/LTT/tmp/*
			done
			#combining the TsTe of each replicate within a single file
			python ~/Documents/GitHub/CorsaiR/Python/comb_TsTe.py -dir "$PWD"/../results/$s/$ss/$ana/LTT/per_replicate
		done
	done
done
