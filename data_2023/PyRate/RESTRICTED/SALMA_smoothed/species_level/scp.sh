#!/bin/bash


sshpass -p eRooch_eap4i scp -r 1-Full/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/SALMA_smoothed/species_level/1-Full/
sshpass -p eRooch_eap4i scp -r 1-Full/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/SALMA_smoothed/species_level/2-Singleton/
sshpass -p eRooch_eap4i scp -r 2-Spatially_scaled/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/SALMA_smoothed/species_level/3-Spatially_scaled/
sshpass -p eRooch_eap4i scp -r 3-Tropical_Extratropical/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/SALMA_smoothed/species_level/4-Tropical/
sshpass -p eRooch_eap4i scp -r 4-Ecomorphotype/*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/SALMA_smoothed/species_level/5-Ecomorphotype/
for odr in Notoungulata Rodentia Xenarthra Other_SANUs Metatheria
do
	sshpass -p eRooch_eap4i scp -r 5-Order_level/${odr}*_PyRate.py lbuffan@162.38.181.170:~/Updated_Pipeline/SALMA_smoothed/species_level/6-Order/${odr}
done



