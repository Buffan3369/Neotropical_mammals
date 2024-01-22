#!/bin/bash

####--------------------------------------------#
# Run diversification analyses at the genus level
####--------------------------------------------#

    ## FULL
        #SALMA kept
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/1-Full/Full_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ../PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/1-Full/Full_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## SINGLETON
        #SALMA kept
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/2-Singleton/Full_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ../PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/2-Singleton/Full_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## SPATIAL SCALING
        #SALMA kept
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/3-Spatially_scaled/spatially_scaled_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
echo "python3 ../PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/3-Spatially_scaled/spatially_scaled_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -singleton 1 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## TROPICS
        #SALMA kept
#Extra-tropical
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/4-Tropical_Extratropical/Extratropical/Extratropical_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}
#Tropical
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/4-Tropical_Extratropical/Tropical/Tropical_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}
        #SALMA smoothed
#Extra-tropical
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/4-Tropical_Extratropical/Extratropical/Extratropical_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}
#Tropical
echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/4-Tropical_Extratropical/Tropical/Tropical_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 50000000 -s 50000" > tmp_script.sh
/usr/local/bin/parallel -j 20 bash tmp_script.sh ::: {1..20}

    ## DIET
        #SALMA kept
for diet in carnivore herbivore omnivore insectivore
do
    echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/5-Ecomorphotype/${diet}/${diet}_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 20000000 -s 20000" > tmp_script.sh
    /usr/local/bin/parallel -j 10 bash tmp_script.sh ::: {1..10}
done
        #SALMA smoothed
for diet in carnivore herbivore omnivore insectivore
do
    echo "python3 ../PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/5-Ecomorphotype/${diet}/${diet}_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 20000000 -s 20000" > tmp_script.sh
    /usr/local/bin/parallel -j 10 bash tmp_script.sh ::: {1..10}
done

    ## ORDER
        #SALMA kept
for odr in Notoungulata Other_SANUs Xenarthra Metatheria Rodentia
do
    echo "python3 ../PyRate/PyRate.py ../results/SALMA_kept/genus_level/6-Order/${odr}/${odr}_EOT_gen_occ_SALMA_kept_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 20000000 -s 20000" > tmp_script.sh
    /usr/local/bin/parallel -j 10 bash tmp_script.sh ::: {1..10}
done
        #SALMA smoothed
for diet in carnivore herbivore omnivore insectivore
do
    echo "python3 ../PyRate/PyRate.py ../results/SALMA_smoothed/genus_level/6-Order/${odr}/${odr}_EOT_gen_occ_SALMA_smoothed_PyRate.py -qShift ../EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -edgeShift 55.8 23.23 -mG -j \$1 -n 20000000 -s 20000" > tmp_script.sh
    /usr/local/bin/parallel -j 10 bash tmp_script.sh ::: {1..10}
done








