#!/bin/bash

for order in full SANU Xenarthra Metatheria Rodentia
do
	sshpass -p eRooch_eap4i scp -r ${order}_spatially_scaled_EOT_species_PyRate.py lbuffan@162.38.181.170:~/cleaning_process/cleaning_21-06/SPECIES_LEVEL/spatially_scaled/${order}
done

