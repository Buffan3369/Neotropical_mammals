#!/bin/bash

    ## FULL
#echo "python3 ~/PyRate/PyRate.py ../results/SALMA_kept/genus_level/1-Full/Full_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
#parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
#echo "python3 ~/PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/1-Full/Full_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
#parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## SINGLETON
        #SALMA kept
#echo "python3 ~/PyRate/PyRate.py ../results/SALMA_kept/genus_level/2-Singleton/Full_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
#parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
#echo "python3 ~/PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/2-Singleton/Full_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
#parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## SPATIAL SCALING
        #SALMA kept
echo "python3 ~/PyRate/PyRate.py ../results/SALMA_kept/genus_level/3-Spatially_scaled/spatially_scaled_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ~/PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/3-Spatially_scaled/spatially_scaled_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
