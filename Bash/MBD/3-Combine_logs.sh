#!/bin/bash

for trt in 6-Order_level/Notoungulata/post_EECO 6-Order_level/Notoungulata/Oligocene_only 6-Order_level/Xenarthra/post_EECO 6-Order_level/Xenarthra/Oligocene_only
#1-Full/early_phase 1-Full/late_phase 1-Full/post_EECO \
#5-Ecomorphotype/carnivore 5-Ecomorphotype/omnivore 5-Ecomorphotype/insectivore \
#1-Full 1-Full/Eocene_only 1-Full/Oligocene_only \
#4-Tropical_Extratropical/Tropical 4-Tropical_Extratropical/Tropical/Eocene_only 4-Tropical_Extratropical/Tropical/Oligocene_only \
#4-Tropical_Extratropical/Extratropical 4-Tropical_Extratropical/Extratropical/Eocene_only 4-Tropical_Extratropical/Extratropical/Oligocene_only \
#4-Tropical_Extratropical/Extratropical/post_EECO 4-Tropical_Extratropical/Tropical/post_EECO \
#5-Ecomorphotype/herbivore  5-Ecomorphotype/herbivore/post_EECO  5-Ecomorphotype/herbivore/Oligocene \
#6-Order_level/Metatheria 6-Order_level/Rodentia 6-Order_level/Other_SANUs \
do
	python ~/PyRate/PyRate.py -combLog "$PWD"/../../results/MBD/$trt -tag _KEEP -b 10
done
