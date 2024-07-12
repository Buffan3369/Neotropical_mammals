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
  tste_file <- list.files(path = tste_dir, pattern = "se_est.txt")
  tste_full <- read.table(paste(tste_dir, tste_file, sep = "/"),
                         header = TRUE)
  # Eoc_Olig
  write.table.lucas(x = tste_full %>% filter(ts <= 56 & te >= 23), #sorting just based on one column, but enough
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full/Full_Eocene_Oligocene_", salma, "_se_est.txt"))
  # post_EECO
  write.table.lucas(x = tste_full %>% filter(ts <= 56 & te >= 34),
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full/post_EECO/Full_post_EECO_", salma, "_se_est.txt"))
  # Oligocene Only
  write.table.lucas(x = tste_full %>% filter(ts <= 34 & te >= 23),
                    file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/1-Full/Oligocene_only/Full_Oligocene_only_", salma, "_se_est.txt"))
  for(odr in keys(tax_dict)){
    tste_dir <- paste0("./results_EXTENDED/", salma, "/genus_level/6-Order_level/", odr, "/LTT")
    tste_file <- list.files(path = tste_dir, pattern = "_level.txt")[1]
    tste_odr <- read.table(paste(tste_dir, tste_file, sep = "/"),
                           header = TRUE)
    # Eoc_Olig
    write.table.lucas(x = tste_odr %>% filter(ts <= 56 & te >= 23),
                      file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/6-Order_level/", odr, "/", odr, "_Eocene_Oligocene_", salma, "_se_est.txt"))
    # post_EECO
    write.table.lucas(x = tste_odr %>% filter(ts <= 56 & te >= 34),
                      file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/6-Order_level/", odr, "/post_EECO/", odr, "_post_EECO_", salma, "_se_est.txt"))
    # Oligocene Only
    write.table.lucas(x = tste_odr %>% filter(ts <= 34 & te >= 23),
                      file = paste0("./results_EXTENDED/MBD/", salma, "/genus_level/6-Order_level/", odr, "/Oligocene_only/", odr, "_Oligocene_only_", salma, "_se_est.txt"))
    
    
  }
}
