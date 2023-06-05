################################################################################
################## Process environmental correlates for MBD ####################
################################################################################

## Function to select the closest 'age_vect' element to the integer 'int_age' --------------------------------------------------
select_closer <- function(int_age, age_vect, d = 0){
  corr <- which(unlist(lapply(X = age_vect, FUN = round, digits = d)) == int_age)
  diff <- lapply(X = age_vect[corr], FUN = function(x){return(abs(x-int_age))})
  return(corr[which.min(diff)])
}

## Continental fragmentation (from Zaffos et al. 2018) -------------------------------------------------------------------------
fragmentation <- read.csv("../../DATA/ENVIRONMENT_CORRELATES/continental_fragmentation/ContinuousTimeSeries.csv")
fragmentation$Age <- seq(from = 0, to = 540, by = 1)
fragmentation_cnz <- fragmentation[1:67, c("Age", "fragmentation.index")] #cenozoic only
#Linear interpolation and save a dataset of the covariate with a 100ky time step
interpol_frag <- approx(x = fragmentation_cnz$Age[1:2], y = fragmentation_cnz$fragmentation.index[1:2], n=3)$y
for(i in 2:66){
  interpol_frag <- c(interpol_frag,
                     approx(x = fragmentation_cnz$Age[i:(i+1)], y = fragmentation_cnz$fragmentation.index[i:(i+1)], n=3)$y[-c(1)])
}
# par(mfrow = c(1,2))
# plot(x = fragmentation_cnz$Age, y = fragmentation_cnz$fragmentation.index)
# title("Original data")
# plot(x = seq(from = 0, to = 66, by = 0.1), y = interpol_frag)
# title("Interpolated data")
write.table(data.frame(Age = seq(from = 0, to = 66, by = 0.5),
                       fragmentation.index = interpol_frag),
          file = "./data_2023/predictors_MBD/1-fragmentation_cenozoic_500ky_step.txt",
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
interpol_av_el <- approx(x = average_elevation$Age[1:2], y = average_elevation$Altitude[1:2], n=3)$y
for(i in 2:66){
  interpol_av_el <- c(interpol_av_el,
                      approx(x = average_elevation$Age[i:(i+1)], y = average_elevation$Altitude[i:(i+1)], n=3)$y[-c(1)])
}
# par(mfrow = c(1,2))
# plot(x = average_elevation$Age, y = average_elevation$Altitude)
# title("Original data")
# plot(x = seq(from = 0, to = 66, by = 0.1), y = interpol_av_el)
# title("Interpolated data")
write.table(data.frame(Age = seq(from = 0, to = 66, by = 0.5),
                       Altitude = interpol_av_el),
            file = "./data_2023/predictors_MBD/2-Andes_mean_elevations_no_basins_500ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)


## Palaeotemperature (assembled by Boschman and Condamine 2022 using Cenozoic data from Westerhold et al. 2020) ----------------
Temp <- read.table("../../DATA/ENVIRONMENT_CORRELATES/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                   sep = "\t",
                   header = TRUE)
Temp_Cnz <- Temp[which(Temp$Age <= 66), ]
#Write and save a dataset of the covariate with a 500ky time step
selected_indices <- unlist(lapply(X = seq(from = 0, to = 66, by = 0.5), FUN = select_closer, age_vect = Temp_Cnz$Age, d = 1))
Temp_Cnz <- Temp_Cnz[selected_indices, ]
Temp_Cnz$Age <- unlist(lapply(X = Temp_Cnz$Age, FUN = round, digits = 1))
write.table(Temp_Cnz[selected_indices,],
            file = "./data_2023/predictors_MBD/3-Cenozoic_Temp_500ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

## Delta 13 C (from Westerhold et al. 2020) ------------------------------------------------------------------------------------
full_data <- read.table("../../DATA/ENVIRONMENT_CORRELATES/atmospheric_carbon_d13C/Westerhold-etal_2020/datasets/TableS33.tab",
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
selected_indices <- unlist(lapply(X = seq(0, 66, 0.5), FUN = select_closer, age_vect = full_data$Tuned.time..Ma., d = 1))
d13_C <- data.frame(Age = seq(0, 66, 0.5),
                    d13C_atmospheric = full_data$Foram.benth.δ13C....PDB...VPDB.CorrAdjusted.[selected_indices])
write.table(x = d13_C,
            file = "./data_2023/predictors_MBD/4-Atmospheric_delta13_C_500ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

## Organic d13C from Falkowski et al. (2005) and Katz et al. (2005) -------------------------------------------------------------
d13C_org <- read.table("../../DATA/ENVIRONMENT_CORRELATES/organic_carbon/organic_carbon.txt",
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
write.table(x = interpolated[selected_indices,],
            file = "./data_2023/predictors_MBD/5-organic_carbon_500ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

## Global sea level (from Miller et al. 2020) -----------------------------------------------------------------------------------
sea_lvl <- read.table("../../DATA/ENVIRONMENT_CORRELATES/sea_level/Miller_2020_sea_level_data.txt",
                      sep = "\t",
                      header = TRUE)
sea_lvl$age_calkaBP <- unlist(lapply(X = sea_lvl$age_calkaBP, FUN = function(x){x/1000}))
selected_indices <- unlist(lapply(X = seq(from = 0, to = 66, by = 0.5), FUN = select_closer, age_vect = sea_lvl$age_calkaBP, d=1))
#there are some intervals with lacks => interpolate
ages <- unlist(lapply(X = sea_lvl$age_calkaBP[selected_indices], FUN = round, digits = 1))
sel_sea_lvl <- sea_lvl$sealevel[selected_indices]

to_add <- seq(0,66,0.5)[which(seq(0,66,0.5) %in% ages == FALSE)]
for(pos in rev(to_add)){
  n_add <- 1
  n_add_left <- 0
  n_add_right <- 0
  bf <- pos + 0.5
  af <- pos - 0.5
  if(bf %in% ages == FALSE){
    bf <- bf + 0.5
    n_add_right <- 1
    while(bf %in% ages == FALSE){
      bf <- bf + 0.5
      n_add_right <- n_add_right + 1
    }
    n_add <- n_add + n_add_right
  }
  if(af %in% ages == FALSE){
    af <- af - 0.5
    n_add_left <- 1
    while(af %in% ages == FALSE){
    af <- af - 0.5
      n_add_left <- n_add_left + 1
    }
    n_add <- n_add + n_add_left
  }
  
  interpol <- approx(x = ages[which(ages == af):which(ages == bf)],
                     sel_sea_lvl[which(ages == af):which(ages == bf)],
                     n = n_add+2)$y
  if((n_add_left == 0) & (n_add_right != 0)){
    sel_sea_lvl <- append(sel_sea_lvl, values = to_add[(length(to_add)-1)], after = which(ages == af))
  }
  else {
    sel_sea_lvl <- append(sel_sea_lvl, values = to_add[2], after = which(ages == bf))
  }
}

#plot(x = seq(from = 0, to = 66, by = .5), y = sel_sea_lvl)

write.table(x = data.frame(Age = seq(from = 0, to = 66, by = .5),
                           Sea_level = sel_sea_lvl),
            file = "./data_2023/predictors_MBD/6-sea_level_500ky_step.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)

## Diversity estimates at the order level --------------------------------------
for(order in c("Astrapotheria", "Carnivora", "Didelphimorphia", "Litopterna", "Notoungulata",
               "Paucituberculata", "Polydolopimorphia", "Pyrotheria", "Rodentia", "Sparassodonta")){
  order_div <- read.table(paste0("../../DATA/ENVIRONMENT_CORRELATES/estimated_diversities/", order, "_diversity_ltt.txt"),
                        header = TRUE)[, 1:2]
  #Remove -Inf estimates
  order_div$diversity[which(order_div$diversity == -Inf)] <- 0
  #Define timescale (100ky time step)
  minT <- min(order_div$time)
  maxT <- max(order_div$time)
  round_seq <- seq(from = round(minT, digits = 1),
                   to = round(maxT, digits = 1),
                   by = 0.5)
  #sample diversity estimates inside this timescale
  selected_indices <- unlist(lapply(X = round_seq, FUN = select_closer, age_vect = order_div$time, d = 1))
  order_div <- order_div[selected_indices, ]
  order_div$time <- unlist(lapply(X = order_div$time,
                                FUN = round,
                                digits = 1))
  #Create dataset with interpolated times
  interpolated <- data.frame(Age = NA, Diversity = NA)
  for(t in round_seq){
    if(t %in% order_div$time){
      ind <- which(order_div$time == t)
      interpolated <- rbind(interpolated, 
                            c(t, order_div$diversity[ind]))
    }
    else{
      interpolated <- rbind(interpolated,
                            c(t, NA))
    }
  }
  interpolated <- interpolated[-c(1),]
  row.names(interpolated) <- 1:nrow(interpolated)
  #Fill the gaps
  i = 1
  while(i < nrow(interpolated)-1){
    if(is.na(interpolated$Diversity[i])){ #i is the first na postition
      D = 0
      while(is.na(interpolated$Diversity[i+D])){
        D = D+1
      }
      interpolated$Diversity[i:(i+D-1)] <- approx(x = c(interpolated$Age[(i-1)], interpolated$Age[(i+D)]),
                                                  y = c(interpolated$Diversity[(i-1)], interpolated$Diversity[(i+D)]),
                                                  n = D)$y
      i = i+D
    }
    else{
      i = i+1
    }
  }
  #Rescale between 0 and 1
  maxD <- max(interpolated$Diversity)
  interpolated$Diversity <- interpolated$Diversity / maxD
  #Save
  write.table(x = interpolated,
              file = paste0("./data_2023/predictors_MBD/", order, "_diversity_ltt_500ky_step.txt"),
              sep = "\t",
              quote = FALSE,
              row.names = FALSE)
}
