#!/bin/bash

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level
	do
		mkdir -p ../results/$s/$ss/1-Full
		sshpass -p eRooch_eap4i scp -r lbuffan@162.38.181.170:~/Updated_Pipeline/$s/$ss/1-Full/pyrate_mcmc_logs ../results/$s/$ss/1-Full
		mkdir -p ../results/$s/$ss/2-Singleton
                sshpass -p eRooch_eap4i scp -r lbuffan@162.38.181.170:~/Updated_Pipeline/$s/$ss/2-Singleton/pyrate_mcmc_logs/ ../results/$s/$ss/2-Singleton
	done
done
