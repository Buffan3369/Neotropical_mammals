#!/bin/bash

for salma in SALMA_kept SALMA_smoothed
do
	for s in genus_level species_level
	do
		sshpass -p eRooch_eap4i scp -r ./$salma/$s/1-Full/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/$salma/$s/1-Full/
		sshpass -p eRooch_eap4i scp -r ./$salma/$s/1-Full/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/$salma/$s/2-Singleton/
		sshpass -p eRooch_eap4i scp -r ./$salma/$s/2-Spatially_scaled/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/$salma/$s/3-Spatially_scaled/
		sshpass -p eRooch_eap4i scp -r ./$salma/$s/3-Tropical_Extratropical/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/$salma/$s/4-Tropical/
		sshpass -p eRooch_eap4i scp -r ./$salma/$s/4-Ecomorphotype/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/$salma/$s/5-Ecomorphotype/
		sshpass -p eRooch_eap4i scp -r ./$salma/$s/5-Order_level/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/$salma/$s/6-Order/
	done
done




