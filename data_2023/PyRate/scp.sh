#!/bin/bash

for salma in SALMA_kept SALMA_smoothed
do
	for s in genus_level species_level
	do
		sshpass -p entomologie0 scp -r ./EXTENDED/$salma/$s/1-Full/*_PyRate.py fcondamine@162.38.181.169:~/South_American_mammals/EXTENDED/results_EXTENDED_RJMCMC/$salma/$s/2-Singleton
		sshpass -p entomologie0 scp -r ./EXTENDED/$salma/$s/2-Spatially_scaled/*_PyRate.py fcondamine@162.38.181.169:~/South_American_mammals/EXTENDED/results_EXTENDED_RJMCMC/$salma/$s/3-Spatially_scaled
	done
done




