################################################################################
# Title: 7-Process_envt_correlates.R
# Author: Lucas Buffan
# Date: 2024-03-28
# Aim: Process environmental correlates for MBD.
################################################################################

library(tidyverse)
library(readxl)
source("./R/useful/helper_functions.R")

## Plant diversity (from Jaramillo et al. (2006)) --------------------------------------------------------------------
plant_raw <- read.table("./data_2023/MBD/raw_environment_correlates/Cnz_Plant_diversity_Jaramillo_2006.txt", header = TRUE)
selected_indices <- sapply(X = seq(from = 23, to = 56, by = 0.5),
                           FUN = select_closer,
                           age_vect = plant_raw$Age)
plant_processed <- data.frame(Age = seq(from = 23, to = 56, by = 0.5),
                              Plant_diversity = plant_raw$Div[selected_indices])
### Verification ###
# par(mfrow = c(1,2))
# plot(x = plant_processed$Age, plant_processed$Plant_diversity, xlim = c(15, 90))
# plot(x = plant_raw$Age, y = plant_raw$Div)

# Full dataset
write.table.lucas(x = plant_processed,
                  file = "./data_2023/MBD/processed_predictors_full/1-Plant_Diversity_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = plant_processed %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/1-Plant_Diversity_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = plant_processed %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/1-Plant_Diversity_Oligocene_only_500ky_step.txt")


## Andean Uplift (from Boschman (2021)) -----------------------------------------------------------------------------
Uplift <- read.table("./data_2023/MBD/raw_environment_correlates/andean_uplift/Andes_mean_elevations_no_basins_ALL.txt",
                     sep = " ",
                     header = TRUE)
#Write and save a dataset of the covariate with a 100ky time step
average_elevation <- data.frame(Age = 0:66,
                                Altitude = sapply(X = 0:66, FUN = function(x){return(mean(Uplift$Altitude[which(Uplift$Age == x)]))}))
interpol_av_el <- approx(x = average_elevation$Age[1:2], y = average_elevation$Altitude[1:2], n=3)$y
for(i in 2:66){
  interpol_av_el <- c(interpol_av_el,
                      approx(x = average_elevation$Age[i:(i+1)], y = average_elevation$Altitude[i:(i+1)], n=3)$y[-c(1)])
}
### Verification ###
# par(mfrow = c(1,2))
# plot(x = average_elevation$Age, y = average_elevation$Altitude)
# title("Original data")
# plot(x = seq(from = 0, to = 66, by = 0.5), y = interpol_av_el)
# title("Interpolated data")
Andes <- data.frame(Age = seq(from = 0, to = 66, by = 0.5),
                    Altitude = interpol_av_el)
# Full dataset
write.table.lucas(Andes %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/2-Andes_mean_elevations_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = Andes %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/2-Andes_mean_elevations_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = Andes %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/2-Andes_mean_elevations_Oligocene_only_500ky_step.txt")



## Palaeotemperature (assembled by Boschman and Condamine 2022 using Cenozoic data from Westerhold et al. 2020) ----------------
Temp_Cnz <- read.table("./data_2023/MBD/raw_environment_correlates/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                   sep = "\t",
                   header = TRUE)
Temp_Cnz <- Temp_Cnz[which(Temp_Cnz$Age <= 66), ]
#Write and save a dataset of the covariate with a 500ky time step
selected_indices <- sapply(X = seq(from = 0, to = 66, by = 0.5), FUN = select_closer, age_vect = Temp_Cnz$Age)
Temp_Cnz1 <- Temp_Cnz[selected_indices, ]
Temp_Cnz1$Age <- sapply(X = Temp_Cnz1$Age, FUN = round, digits = 1)
### Verification ###
# par(mfrow = c(1,2))
# plot(x = Temp_Cnz$Age, y = Temp_Cnz$Temperature)
# title("Original data")
# plot(x = Temp_Cnz1$Age, y = Temp_Cnz1$Temperature)
# title("Subsampled data")

# Full dataset
write.table.lucas(Temp_Cnz1 %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/3-Temperature_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = Temp_Cnz1 %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/3-Temperature_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = Temp_Cnz1 %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/3-Temperature_Oligocene_only_500ky_step.txt")


## Global sea level (from Miller et al. 2020) -----------------------------------------------------------------------------------
sea_lvl <- read.table("./data_2023/MBD/raw_environment_correlates/sea_level/Miller_2020_sea_level_data.txt",
                      sep = "\t",
                      header = TRUE)
sea_lvl <- sea_lvl %>% 
  mutate(age_calkaBP = sapply(X = sea_lvl$age_calkaBP, FUN = function(x){x/1000})) %>% 
  rename(age_MaBP = "age_calkaBP")
selected_indices <- sapply(X = seq(from = 0, to = 66, by = 0.5), FUN = select_closer, age_vect = sea_lvl$age_MaBP)
#there are some intervals with lacks
ages <- sapply(X = sea_lvl$age_MaBP[selected_indices], FUN = round, digits = 1)
sel_sea_lvl <- sea_lvl$sealevel[selected_indices]
udc <- ages[which(ages %in% seq(0,66,0.5) == FALSE)]
to_add <- seq(0,66,0.5)[which(seq(0,66,0.5) %in% ages == FALSE)]
# replace udc by to_add
ages[which(ages %in% udc)] <- to_add
# dataframe
slvl <- data.frame(Age = ages,
                        Sea_level = sel_sea_lvl)
### Verification ###
# par(mfrow = c(1,2))
# plot(x = sea_lvl$age_MaBP, y = sea_lvl$sealevel)
# title("Original data")
# plot(x = slvl$Age, y = slvl$Sea_level)
# title("Scaled data")

# Full dataset
write.table.lucas(x = slvl %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/4-sea_level_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = slvl %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/4-sea_level_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = slvl %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/4-sea_level_Oligocene_only_500ky_step.txt")


## Temporal patterns on the relative abundance of open habitats in Patagonia (Solórzano et Nuñez 2021 from Strömberg et al. 2013) ------------
p_open <- read_xlsx("./data_2023/MBD/raw_environment_correlates/vegetation_openness.xlsx")
interpol_op <- approx(x = p_open$Age[1:2], y = p_open$P_open[1:2], n=3)$y
for(i in 2:49){
  interpol_op <- c(interpol_op,
                   approx(x = p_open$Age[i:(i+1)], y = p_open$P_open[i:(i+1)], n=3)$y[-c(1)])
}
p_op_int <- data.frame(Age = seq(0, 49, 0.5),
                       P_open = interpol_op)
# Full dataset
write.table.lucas(x = p_op_int %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/5-habitat_openness_Eoc_Olig_500ky.txt")
# post_EECO dataset
write.table.lucas(x = p_op_int %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/5-habitat_openness_post_EECO_500ky.txt")
# Oligocene dataset
write.table.lucas(x = p_op_int %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/5-habitat_openness_Oligocene_only_500ky.txt")

## Relative Leaf Area Index (Dunn et al. 2015) -----------------------------------------------------------------------
rLAI <- read_xlsx("./data_2023/MBD/raw_environment_correlates/rLAI.xlsx")
interpol_rlai <- approx(x = rLAI$Age[1:2], y = rLAI$rLAI[1:2], n=3)$y
for(i in 2:38){
  interpol_rlai <- c(interpol_rlai,
                     approx(x = rLAI$Age[i:(i+1)], y = rLAI$rLAI[i:(i+1)], n=3)$y[-c(1)])
}
rlai_int <- data.frame(Age = seq(11, 49, 0.5),
                       rLAI = interpol_rlai)
# Full dataset
write.table.lucas(x = rlai_int %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/6-rLAI_Eoc_Olig.txt")
# post_EECO dataset
write.table.lucas(x = rlai_int %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/6-rLAI_post_EECO.txt")
# Oligocene dataset
write.table.lucas(x = rlai_int %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/6-rLAI_Oligocene_only.txt")
