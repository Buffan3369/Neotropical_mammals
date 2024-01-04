#!/bin/bash

####----------------------------------------------#
# Run diversification analyses at the species level
####----------------------------------------------#

    ## FULL
        #SALMA kept
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/1-Full/Full_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ~/PyRate/PyRate.py ./SALMA_smoothed/species_level/1-Full/Full_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## SINGLETON
        #SALMA kept
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/2-Singleton/Full_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ~/PyRate/PyRate.py ./SALMA_smoothed/species_level/2-Singleton/Full_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## SPATIAL SCALING
        #SALMA kept
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/3-Spatially_scaled/spatially_scaled_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ~/PyRate/PyRate.py ./SALMA_smoothed/species_level/3-Spatially_scaled/spatially_scaled_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## TROPICS
        #SALMA kept
#Extra-tropical
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/4-Tropical/Extratropical_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
#Tropical
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/4-Tropical/Tropical_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
#Extra-tropical
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/4-Tropical/Extratropical_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}
#Tropical
echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/4-Tropical/Tropical_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## DIET
        #SALMA kept
for diet in carnivore herbivore omnivore insectivore
do
    echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/5-Ecomorphotype/${diet}/${diet}_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
    parallel -j 10 bash tmp_script.sh ::: {1..10}
done
        #SALMA smoothed
for diet in carnivore herbivore omnivore insectivore
do
    echo "python3 ~/PyRate/PyRate.py ./SALMA_smoothed/species_level/5-Ecomorphotype/${diet}/${diet}_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
    parallel -j 10 bash tmp_script.sh ::: {1..10}
done

    ## ORDER
        #SALMA kept
for odr in Notoungulata Other_SANUs Xenarthra Metatheria Rodentia
do
    echo "python3 ~/PyRate/PyRate.py ./SALMA_kept/species_level/6-Order/${odr}/${odr}_EOT_sp_occ_SALMA_kept_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
    parallel -j 10 bash tmp_script.sh ::: {1..10}
done
        #SALMA smoothed
for diet in carnivore herbivore omnivore insectivore
do
    echo "python3 ~/PyRate/PyRate.py ./SALMA_smoothed/species_level/6-Order/${odr}/${odr}_EOT_sp_occ_SALMA_smoothed_PyRate.py -qShift ./Q_rate_shifts/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
    parallel -j 10 bash tmp_script.sh ::: {1..10}
done








