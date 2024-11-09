################################################################################
# Name: 6-Split_TsTe_interval.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Split TsTe tables according to the three periods tested in the MBD model
#   i.e., Full Eocene-Oligocene, post-EECO, Oligocene.
################################################################################

library(tidyverse)

source("./R/useful/helper_functions.R")

for(salma in c("SALMA_smoothed", "SALMA_kept")){
  tste_dir <- paste0("./results_EXTENDED/", salma, "/genus_level/1-Full/MH_sampler/LTT/")
  tste_file <- list.files(path = tste_dir, pattern = "se_est.txt") # single file anyway
  tste_full <- read.table(paste(tste_dir, tste_file, sep = "/"),
                          header = TRUE)
  # Assessing mean ts/te per taxa
  mean_ts <- apply(X = tste_full[, seq(3, ncol(tste_full)-1), 2],
                   MARGIN = 1,
                   FUN = mean)
  mean_te <- apply(X = tste_full[, seq(4, ncol(tste_full), 2)],
                   MARGIN = 1,
                   FUN = mean)
  # Assessing bin midpoints
  mean_tste_df <- data.frame(ts = mean_ts, te = mean_te)
  mean_tste_df <- mean_tste_df %>% 
    mutate(mid = (ts+te)/2)
  
#### CONSERVATIVE SPLIT ####
  # Eoc_Olig
  subset_idx_eot <- which(mean_tste_df$mid <= 56 & mean_tste_df$mid >= 23.03)
  full_eot <- tste_full[subset_idx_eot, ]
  write.table.lucas(x = full_eot,
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full_conservative_partitioning/Full_Eocene_Oligocene_", salma, "_se_est.txt"))
  # Post EECO
  subset_idx_EECO <- which(mean_tste_df$mid <= 52 & mean_tste_df$mid >= 33.9)
  post_EECO <- tste_full[subset_idx_EECO,]
  write.table.lucas(x = post_EECO,
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full_conservative_partitioning/post_EECO/Full_post_EECO_", salma, "_se_est.txt"))
  # Oligocene only
  subset_idx_olig <- which(mean_tste_df$mid <= 33.9 & mean_tste_df$mid >= 23.03)
  olig <- tste_full[subset_idx_olig,]
  write.table.lucas(x = olig,
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full_conservative_partitioning/Oligocene_only/Full_Oligocene_only_", salma, "_se_est.txt"))

##### STRINGENT SPLIT #####
  subset_idx_eot <- which(mean_tste_df$ts <= 56 & mean_tste_df$te >= 23.03)
  full_eot <- tste_full[subset_idx_eot, ]
  write.table.lucas(x = full_eot,
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full_stringent_partitioning/Full_Eocene_Oligocene_", salma, "_se_est.txt"))
  # Post EECO
  subset_idx_EECO <- which(mean_tste_df$ts <= 52 & mean_tste_df$te >= 33.9)
  post_EECO <- tste_full[subset_idx_EECO,]
  write.table.lucas(x = post_EECO,
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full_stringent_partitioning/post_EECO/Full_post_EECO_", salma, "_se_est.txt"))
  # Oligocene only
  subset_idx_olig <- which(mean_tste_df$ts <= 33.9 & mean_tste_df$te >= 23.03)
  olig <- tste_full[subset_idx_olig,]
  write.table.lucas(x = olig,
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full_stringent_partitioning/Oligocene_only/Full_Oligocene_only_", salma, "_se_est.txt"))
  
  
    
  # for(odr in keys(tax_dict)){
  #   tste_dir <- paste0("./results_EXTENDED/", salma, "/genus_level/6-Order_level/", odr, "/LTT")
  #   tste_file <- list.files(path = tste_dir, pattern = "se_est.txt") # single file anyway
  #   tste_full <- read.table(paste(tste_dir, tste_file, sep = "/"),
  #                           header = TRUE)
  #   # Assessing bin midpoints
  #   mean_ts <- apply(X = tste_full[, seq(3, ncol(tste_full)-1), 2],
  #                    MARGIN = 1,
  #                    FUN = mean)
  #   mean_te <- apply(X = tste_full[, seq(4, ncol(tste_full), 2)],
  #                    MARGIN = 1,
  #                    FUN = mean)
  #   mean_tste_df <- data.frame(ts = mean_ts, te = mean_te)
  #   mean_tste_df <- mean_tste_df %>% 
  #     mutate(mid = (ts+te)/2)
  #   # Eoc_Olig
  #   subset_idx_eot <- which(mean_tste_df$mid <= 56 & mean_tste_df$mid >= 23.03)
  #   full_eot <- tste_full[subset_idx_eot, ]
  #   write.table.lucas(x = full_eot,
  #                     file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/6-Order_level/", odr, "/", odr, "_Eocene_Oligocene_", salma, "_se_est.txt"))
  #   # Post EECO
  #   subset_idx_EECO <- which(mean_tste_df$mid <= 52 & mean_tste_df$mid >= 33.9)
  #   post_EECO <- tste_full[subset_idx_EECO,]
  #   write.table.lucas(x = post_EECO,
  #                     file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/6-Order_level/", odr, "/post_EECO/", odr, "_post_EECO_", salma, "_se_est.txt"))
  #   # Oligocene only
  #   subset_idx_olig <- which(mean_tste_df$mid <= 33.9 & mean_tste_df$mid >= 23.03)
  #   olig <- tste_full[subset_idx_olig,]
  #   write.table.lucas(x = tste_full %>% filter(ts <= 34 & te >= 23),
  #                     file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/6-Order_level/", odr, "/Oligocene_only/", odr, "_Oligocene_only_", salma, "_se_est.txt"))
  # }
}

## Partitionning per latitude
corr_lat <- hash("Tropical"="LOWLAT", "Extratropical"="HIGHLAT")
for(lat in c("Tropical", "Extratropical")){
  tste_dir <- paste0("./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/RJMCMC/", lat, "/LTT/")
  tste_file <- list.files(path = tste_dir, pattern = "se_est.txt") # single file anyway
  tste_full <- read.table(paste(tste_dir, tste_file, sep = "/"),
                          header = TRUE)
  # Assessing bin midpoints
  mean_ts <- apply(X = tste_full[, seq(3, ncol(tste_full)-1), 2],
                   MARGIN = 1,
                   FUN = mean)
  mean_te <- apply(X = tste_full[, seq(4, ncol(tste_full), 2)],
                   MARGIN = 1,
                   FUN = mean)
  mean_tste_df <- data.frame(ts = mean_ts, te = mean_te)
  mean_tste_df <- mean_tste_df %>% 
    mutate(mid = (ts+te)/2)
  
#### CONSERVATIVE SPLIT ####
  # Eoc_Olig
  subset_idx_eot <- which(mean_tste_df$mid <= 56 & mean_tste_df$mid >= 23.03)
  full_eot <- tste_full[subset_idx_eot, ]
  write.table.lucas(x = full_eot,
                    file = paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_conservative/", 
                                  values(corr_lat[lat]), "/", values(corr_lat[lat]), "_Eocene_Oligocene_se_est.txt"))
  # post_EECO
  subset_idx_EECO <- which(mean_tste_df$mid <= 52 & mean_tste_df$mid >= 33.9)
  post_EECO <- tste_full[subset_idx_EECO,]
  write.table.lucas(x = post_EECO,
                    file = paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_conservative/", 
                                  values(corr_lat[lat]), "/post_EECO/", values(corr_lat[lat]), "_post_EECO_se_est.txt"))
  # Oligocene Only
  subset_idx_olig <- which(mean_tste_df$mid <= 33.9 & mean_tste_df$mid >= 23.03)
  olig <- tste_full[subset_idx_olig,]
  write.table.lucas(x = olig,
                    file = paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_conservative/", 
                                  values(corr_lat[lat]), "/Oligocene_only/", values(corr_lat[lat]), "_Oligocene_only_se_est.txt"))

#### STRINGENT SPLIT ####
  # Eoc_Olig
  subset_idx_eot <- which(mean_tste_df$ts <= 56 & mean_tste_df$te >= 23.03)
  full_eot <- tste_full[subset_idx_eot, ]
  write.table.lucas(x = full_eot,
                    file = paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_stringent/", 
                                  values(corr_lat[lat]), "/", values(corr_lat[lat]), "_Eocene_Oligocene_se_est.txt"))
  # post_EECO
  subset_idx_EECO <- which(mean_tste_df$ts <= 52 & mean_tste_df$te >= 33.9)
  post_EECO <- tste_full[subset_idx_EECO,]
  write.table.lucas(x = post_EECO,
                    file = paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_stringent/", 
                                  values(corr_lat[lat]), "/post_EECO/", values(corr_lat[lat]), "_post_EECO_se_est.txt"))
  # Oligocene Only
  subset_idx_olig <- which(mean_tste_df$ts <= 33.9 & mean_tste_df$te >= 23.03)
  olig <- tste_full[subset_idx_olig,]
  write.table.lucas(x = olig,
                    file = paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_stringent/", 
                                  values(corr_lat[lat]), "/Oligocene_only/", values(corr_lat[lat]), "_Oligocene_only_se_est.txt"))
  
}
