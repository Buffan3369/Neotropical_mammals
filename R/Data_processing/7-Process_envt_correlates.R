################################################################################
# Title: 7-Process_envt_correlates.R
# Author: Lucas Buffan
# Date: 2024-03-28
# Aim: Process environmental correlates for MBD.
################################################################################

library(tidyverse)
source("./R/useful/helper_functions.R")

## Function to select the closest 'age_vect' element to the integer 'int_age' --------------------------------------
select_closer <- function(int_age, age_vect){
  diff <- sapply(X = age_vect, FUN = function(x){return(abs(x-int_age))})
  return(which.min(diff))
}

## Temporal patterns on the relative abundance of open habitats in Patagonia (Solórzano et Nuñez 2021) --------------
p_open <- read_xlsx("./data_2023/MBD/vegetation_openness.xlsx")
interpol_op <- approx(x = p_open$Age[1:2], y = p_open$P_open[1:2], n=3)$y
for(i in 2:49){
  interpol_op <- c(interpol_op,
                   approx(x = p_open$Age[i:(i+1)], y = p_open$P_open[i:(i+1)], n=3)$y[-c(1)])
}
p_op_int <- data.frame(Age = seq(0, 49, 0.5),
                       P_open = interpol_op)
write.table.lucas(p_op_int,
                  "./data_2023/MBD/processed_predictors_EXTENDED/7-habitat_openness_Stromberg_Palazzesi_500ky.txt")

## Relative Leaf Area Index (Dunn et al. 2015) -----------------------------------------------------------------------
rLAI <- read_xlsx("./data_2023/MBD/rLAI.xlsx")
interpol_rlai <- approx(x = rLAI$Age[1:2], y = rLAI$rLAI[1:2], n=3)$y
for(i in 2:38){
  interpol_rlai <- c(interpol_rlai,
                     approx(x = rLAI$Age[i:(i+1)], y = rLAI$rLAI[i:(i+1)], n=3)$y[-c(1)])
}
rlai_int <- data.frame(Age = seq(11, 49, 0.5),
                       rLAI = interpol_rlai)
write.table.lucas(rlai_int,
                  "./data_2023/MBD/processed_predictors_EXTENDED/8-rLAI.txt")

## Plant diversity (from Jaramillo et al. (2006)) --------------------------------------------------------------------
plant_raw <- read.table("./data_2023/MBD/raw_environment_correlates/Cnz_Plant_diversity_Jaramillo_2006.txt", header = TRUE)
selected_indices <- sapply(X = seq(from = 15, to = 66, by = 0.5),
                           FUN = select_closer,
                           age_vect = plant_raw$Age)
plant_processed <- data.frame(Age = seq(from = 15, to = 66, by = 0.5),
                              Plant_diversity = plant_raw$Div[selected_indices])
### Verification ###
# par(mfrow = c(1,2))
# plot(x = plant_processed$Age, plant_processed$Plant_diversity, xlim = c(15, 90))
# plot(x = plant_raw$Age, y = plant_raw$Div)

write.table.lucas(x = plant_processed,
                  file = "./data_2023/MBD/processed_predictors_EXTENDED/1-Plant_Diversity_Palaeoc_Mioc_500ky_step.txt")

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
write.table.lucas(data.frame(Age = seq(from = 0, to = 66, by = 0.5),
                             Altitude = interpol_av_el),
                  file = "./data_2023/MBD/processed_predictors_EXTENDED/2-Andes_mean_elevations_no_basins_500ky_step.txt")


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
write.table.lucas(Temp_Cnz,
                  file = "./data_2023/MBD/processed_predictors_EXTENDED/3-Cenozoic_Temp_500ky_step.txt")

## Delta 13 C (from Westerhold et al. 2020) ------------------------------------------------------------------------------------
full_data <- read.table("./data_2023/MBD/raw_environment_correlates/atmospheric_carbon_d13C/Westerhold-etal_2020/datasets/TableS33.tab",
                        sep = "\t",
                        fill = TRUE,
                        header = TRUE)
#Visualise different corrections
# par(mfrow = c(2,2))
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...VPDB.)
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...VPDB.Corr.)
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...VPDB.CorrAdjusted.)
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...smoothLoess10.)

#Write and save a dataset of the covariate with a 500ky time step
selected_indices <- sapply(X = seq(0, 66, 0.5), FUN = select_closer, age_vect = full_data$Tuned.time..Ma.)
d13_C <- data.frame(Age = seq(0, 66, 0.5),
                    d13C_atmospheric = full_data$Foram.benth.δ13C....PDB...VPDB.CorrAdjusted.[selected_indices])
write.table.lucas(x = d13_C,
                  file = "./data_2023/MBD/processed_predictors_EXTENDED/4-Atmospheric_delta13_C_500ky_step.txt")

## Organic d13C from Falkowski et al. (2005) and Katz et al. (2005) -------------------------------------------------------------
d13C_org <- read.table("./data_2023/MBD/raw_environment_correlates/organic_carbon/organic_carbon.txt",
                       sep = "\t",
                       fill = TRUE,
                       header = TRUE)
d13C_org <- d13C_org[-which(d13C_org$Age > 66.15),]
#interpolate every 10ky
interpolated <- data.frame(Age = c(NA), C13organic = c(NA))
for(t in seq(from = 0, to = 66.15, by = 0.01)){
  if(t %in% d13C_org$Age){
    ind <- which(d13C_org$Age == t)
    interpolated <- rbind(interpolated, 
                          d13C_org[ind,])
  }
  else{
    interpolated <- rbind(interpolated,
                          c(t, NA))
  }
}
interpolated <- interpolated[-c(1),]
row.names(interpolated) <- 1:nrow(interpolated)

i = 1
while(i < nrow(interpolated-1)){
  if(is.na(interpolated$C13organic[i])){ #i is the first na postition
    D = 0
    while(is.na(interpolated$C13organic[i+D])){
      D = D+1
    }
    interpolated$C13organic[i:(i+D-1)] <- approx(x = c(interpolated$Age[(i-1)], interpolated$Age[(i+D)]),
                                                 y = c(interpolated$C13organic[(i-1)], interpolated$C13organic[(i+D)]),
                                                 n = D)$y
    i = i+D
  }
  else{
    i = i+1
  }
}
#now downscale at a 500ky resolution
selected_indices <- 100 * seq(from = 0, to = 66, by = 0.5) + 1
colnames(interpolated) <- c("Age", "d13C_organic")
final <- interpolated[selected_indices,]
### Verification ###
# par(mfrow = c(1,2))
# plot(x = d13C_org$Age, y = d13C_org$C13organic)
# title("Original data")
# plot(x = final$Age, y = final$d13C_organic)
# title("Scaled data")
write.table.lucas(x = final,
                  file = "./data_2023/MBD/processed_predictors_EXTENDED/5-organic_carbon_500ky_step.txt")

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

write.table.lucas(x = slvl,
                  file = "./data_2023/MBD/processed_predictors_EXTENDED/6-sea_level_500ky_step.txt")
