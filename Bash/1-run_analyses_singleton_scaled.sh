#!/bin/bash

####--------------------------------------------#
# Run sensitivity analyses
####--------------------------------------------#

## Genus level ----------------------------------
for s in SALMA_smoothed SALMA_kept
do
    # singleton
    echo "python3 ../../PyRate/PyRate.py ../results_EXTENDED_RJMCMC/$s/genus_level/2-Singleton/*_PyRate.py -qShift ../../Extended_EO_stages.txt -singleton 1 -pL 1.1 0 -pM 1.1 0 -pP 2 0 -mG -j \$1 -n 50000000 -s 50000" > tmp_script3.sh
    /usr/local/bin/parallel -j 20 bash tmp_script3.sh ::: {1..20}
    # spatially scaled
    echo "python3 ../../PyRate/PyRate.py ../results_EXTENDED_RJMCMC/$s/genus_level/3-Spatially_scaled/*_PyRate.py -qShift ../../Extended_EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -mG -j \$1 -n 50000000 -s 50000" > tmp_script3.sh
    /usr/local/bin/parallel -j 20 bash tmp_script3.sh ::: {1..20}
done


## Species level --------------------------------
for s in SALMA_smoothed SALMA_kept
do
    # singleton
    echo "python3 ../../PyRate/PyRate.py ../results_EXTENDED_RJMCMC/$s/species_level/2-Singleton/*_PyRate.py -qShift ../../Extended_EO_stages.txt -singleton 1 -pL 1.1 0 -pM 1.1 0 -pP 2 0 -mG -j \$1 -n 100000000 -s 50000" > tmp_script3.sh
    /usr/local/bin/parallel -j 20 bash tmp_script3.sh ::: {1..20}
    # spatially scaled
    echo "python3 ../../PyRate/PyRate.py ../results_EXTENDED_RJMCMC/$s/species_level/3-Spatially_scaled/*_PyRate.py -qShift ../../Extended_EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -mG -j \$1 -n 100000000 -s 50000" > tmp_script3.sh
    /usr/local/bin/parallel -j 20 bash tmp_script3.sh ::: {1..20}
done


