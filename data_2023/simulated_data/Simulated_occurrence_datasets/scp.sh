#!/bin/bash

for i in {0..9}
do
	sshpass -p eRooch_eap4i scp -r sampled_simulated_occurrences_${i}_PyRate.py lbuffan@162.38.181.170:~/cleaning_process/simulations/replicate_$i
done

