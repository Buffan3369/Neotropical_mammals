#!/bin/bash

for salma in SALMA_kept SALMA_smoothed
do
	for s in genus_level species_level
	do
		sshpass -p lbuffanlbuffan scp -r ./EXTENDED/$salma/$s/1-Full/*_PyRate.py lbuffan@162.38.181.170:~/SOA_mammals_EOT/results/$salma/$s/2-singleton
		sshpass -p lbuffanlbuffan scp -r ./EXTENDED/$salma/$s/2-Spatially_scaled/*_PyRate.py lbuffan@162.38.181.170:~/SOA_mammals_EOT/results/$salma/$s/3-spatially_scaled
	done
done




