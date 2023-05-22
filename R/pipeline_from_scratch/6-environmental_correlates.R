################################################################################
################## Process environmental correlates for MBD ####################
################################################################################

## Continental fragmentation (from Zaffos et al. 2018) -------------------------------------------------------------------------
fragmentation <- read.csv("../../DATA/ENVIRONMENT_CORRELATES/continental_fragmentation/ContinuousTimeSeries.csv",
                          row.names = FALSE)
fragmentation$age <- seq(from = 0, to = 540, by = 1)
fragmentation_cnz <- fragmentation[1:67, c("age", "fragmentation.index")] #cenozoic only
write.csv(fragmentation_cnz,
          file = "../../DATA/ENVIRONMENT_CORRELATES/continental_fragmentation/fragmentation_cenozoic.csv",
          row.names = FALSE)
rm(list = ls())

## Palaeotemperature (assembled by Boschman and Condamine 2022 using Cenozoic data from Westerhold et al. 2020) ----------------
Temp <- read.table("../../DATA/ENVIRONMENT_CORRELATES/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                   sep = "\t",
                   header = TRUE)
Temp_Cnz <- Temp[which(Temp$Age <= 66), ]
write.csv(Temp_Cnz,
          file = "../../DATA/ENVIRONMENT_CORRELATES/palaeotemperature/Cenozoic_Temp.csv",
          row.names = FALSE)
rm(list = ls())

## Andean Uplift (from Boschman and Condamine 2022) -----------------------------------------------------------------------------
Uplift <- read.table("../../DATA/ENVIRONMENT_CORRELATES/andean_uplift/Andes_mean_elevations_no_basins_ALL.txt",
                     sep = " ",
                     header = TRUE)
Uplift_Cnz <- Uplift[which(Uplift$Age <= 66), ]
write.csv(Uplift_Cnz,
          file = "../../DATA/ENVIRONMENT_CORRELATES/andean_uplift/Andes_mean_elevations_no_basins_ALL_CNZ.csv",
          row.names = FALSE)
