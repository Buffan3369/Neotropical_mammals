#!/bin/bash

for order in full SANU Xenarthra Metatheria Rodentia
do
	sshpass -p eRooch_eap4i scp -r ${order}_EOT_species_PyRate.py lbuffan@162.38.181.170:~/cleaning_process/cleaning_21-06/SPECIES_LEVEL/entire/${order}
done

#singleton (only full for now)
sshpass -p eRooch_eap4i scp -r full_EOT_species_PyRate.py lbuffan@162.38.181.170:~/cleaning_process/cleaning_21-06/SPECIES_LEVEL/entire/full_singleton