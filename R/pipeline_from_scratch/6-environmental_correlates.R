################################################################################
################## Process environmental correlates for MBD ####################
################################################################################

library(dplyr)

## Continental fragmentation (from Zaffos et al. 2018) -------------------------------------------------------------------------
fragmentation <- read.csv("../../DATA/ENVIRONMENT_CORRELATES/continental_fragmentation/ContinuousTimeSeries.csv")
fragmentation$Age <- seq(from = 0, to = 540, by = 1)
fragmentation_cnz <- fragmentation[1:67, c("Age", "fragmentation.index")] #cenozoic only
#Linear interpolation and save a dataset of the covariate with a 100ky time step
interpol_frag <- approx(x = fragmentation_cnz$Age[1:2], y = fragmentation_cnz$fragmentation.index[1:2], n=11)$y
for(i in 2:66){
  interpol_frag <- c(interpol_frag,
                     approx(x = fragmentation_cnz$Age[i:(i+1)], y = fragmentation_cnz$fragmentation.index[i:(i+1)], n=11)$y[-c(1)])
}
# par(mfrow = c(1,2))
# plot(x = fragmentation_cnz$Age, y = fragmentation_cnz$fragmentation.index)
# title("Original data")
# plot(x = seq(from = 0, to = 66, by = 0.1), y = interpol_frag)
# title("Interpolated data")
write.table(data.frame(Age = seq(from = 0, to = 66, by = 0.1),
                       fragmentation.index = interpol_frag),
          file = "./data_2023/predictors_MBD/fragmentation_cenozoic_100ky_step.txt",
          row.names = FALSE,
          sep = "\t",
          quote = FALSE)
rm(list = ls())

## Andean Uplift (from Boschman and Condamine 2022) -----------------------------------------------------------------------------
Uplift <- read.table("../../DATA/ENVIRONMENT_CORRELATES/andean_uplift/Andes_mean_elevations_no_basins_ALL.txt",
                     sep = " ",
                     header = TRUE)
#Write and save a dataset of the covariate with a 100ky time step
average_elevation <- data.frame(Age = 0:66,
                                Altitude = unlist(lapply(X = 0:66, FUN = function(x){return(mean(Uplift$Altitude[which(Uplift$Age == x)]))})))
interpol_av_el <- approx(x = average_elevation$Age[1:2], y = average_elevation$Altitude[1:2], n=11)$y
for(i in 2:66){
  interpol_av_el <- c(interpol_av_el,
                      approx(x = average_elevation$Age[i:(i+1)], y = average_elevation$Altitude[i:(i+1)], n=11)$y[-c(1)])
}
# par(mfrow = c(1,2))
# plot(x = average_elevation$Age, y = average_elevation$Altitude)
# title("Original data")
# plot(x = seq(from = 0, to = 66, by = 0.1), y = interpol_av_el)
# title("Interpolated data")
write.table(data.frame(Age = seq(from = 0, to = 66, by = 0.1),
                       Altitude = interpol_av_el),
            file = "./data_2023/predictors_MBD/Andes_mean_elevations_no_basins_100ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)


## Palaeotemperature (assembled by Boschman and Condamine 2022 using Cenozoic data from Westerhold et al. 2020) ----------------
Temp <- read.table("../../DATA/ENVIRONMENT_CORRELATES/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                   sep = "\t",
                   header = TRUE)
Temp_Cnz <- Temp[which(Temp$Age <= 66), ]
#Write and save a dataset of the covariate with a 100ky time step
select_closer <- function(int_age, age_vect, d = 0){
  corr <- which(unlist(lapply(X = age_vect, FUN = round, digits = d)) == int_age)
  diff <- lapply(X = age_vect[corr], FUN = function(x){return(abs(x-int_age))})
  return(corr[which.min(diff)])
}
Temp_Cnz$Age <- Temp_Cnz$Age*10
selected_indices <- unlist(lapply(X = 0:660, FUN = select_closer, age_vect = Temp_Cnz$Age))
Temp_Cnz$Age <- unlist(lapply(X = Temp_Cnz$Age,
                              FUN = function(x){return(round(x/10, digits = 1))}))
write.table(Temp_Cnz[selected_indices,],
            file = "./data_2023/predictors_MBD/Cenozoic_Temp_100ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

## Delta 13 C (from Westerhold et al. 2020) ------------------------------------------------------------------------------------
full_data <- read.table("../../DATA/ENVIRONMENT_CORRELATES/d13C/Westerhold-etal_2020/datasets/TableS33.tab",
                        sep = "\t",
                        fill = TRUE,
                        header = TRUE)
#Visualise different corrections
# par(mfrow = c(2,2))
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...VPDB.)
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...VPDB.Corr.)
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...VPDB.CorrAdjusted.)
# plot(full_data$Tuned.time..Ma., full_data$Foram.benth.δ13C....PDB...smoothLoess10.)

#Write and save a dataset of the covariate with a 100ky time step
full_data$Tuned.time..Ma. <- full_data$Tuned.time..Ma.*10
selected_indices <- unlist(lapply(X = 0:660, FUN = select_closer, age_vect = full_data$Tuned.time..Ma.))
d13_C <- data.frame(Age = unlist(lapply(X = full_data$Tuned.time..Ma.[selected_indices],
                                        FUN = function(x){return(round(x/10, digits = 1))})),
                    d13C_corr_adj = full_data$Foram.benth.δ13C....PDB...VPDB.CorrAdjusted.[selected_indices])
write.table(x = d13_C,
            file = "./data_2023/predictors_MBD/delta13_C_100ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

## Global sea level (from Miller et al. 2020) -----------------------------------------------------------------------------------
sea_lvl <- read.table("../../DATA/ENVIRONMENT_CORRELATES/sea_level/Miller_2020_sea_level_data.txt",
                      sep = "\t",
                      header = TRUE)
sea_lvl$age_calkaBP <- unlist(lapply(X = sea_lvl$age_calkaBP, FUN = function(x){x/100}))
selected_indices <- unlist(lapply(X = seq(from = 0, to = 660, by = 1), FUN = select_closer, age_vect = sea_lvl$age_calkaBP))
#there are some intervals with lacks => interpolate
ages <- unlist(lapply(X = sea_lvl$age_calkaBP[selected_indices], FUN = round))
sel_sea_lvl <- sea_lvl$sealevel[selected_indices]

for(pos in seq(from = length(ages)-1, to = 1, by = -1)){
  if(ages[pos+1]-ages[pos] > 1){
#    print(pos)
    n_add <- ages[pos+1] - ages[pos] + 1
    to_add <- approx(x = ages[pos:(pos+1)], sel_sea_lvl[pos:(pos+1)], n = n_add)$y
    sel_sea_lvl <- append(sel_sea_lvl, values = to_add[2:(length(to_add)-1)], after = pos)
  }
}

plot(x = seq(from = 0, to = 66, by = .1), y = sel_sea_lvl)

write.table(x = sel_sea_lvl,
            file = "./data_2023/predictors_MBD/sea_level.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)
