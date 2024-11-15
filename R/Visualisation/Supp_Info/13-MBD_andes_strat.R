################################################################################
# Name: 13-MBD_andes_strat.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for MBD violin with stratified andean uplift.wc
################################################################################

library(hash)

## Source MBD accessory function -----------------------------------------------
source("./R/useful/4b-MBD_accessory.R")

## Define covariable names -----------------------------------------------------
covar_idx <- hash("0" = "Self-diversity",
                  "1" = "Plant Diversity",
                  "2" = "Andes Elevation",
                  "3" = "Global Temperature",
                  "4" = "Sea Level",
                  "5" = "Habitat Openness",
                  "6" = "Forest Density")

## Set strip labels for plots --------------------------------------------------
rate.labs <- c("Extinction rate", "Origination rate")
names(rate.labs) <- c("Extinction", "Origination")

############################ DEFAULT PARTITIONING ##############################
for(lat in c("HIGHLAT", "LOWLAT")){
  PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA)
  SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA)
  for(trt in c("post_EECO", "Oligocene_only")){
    int <- ifelse(trt == "post_EECO", "Eocene", "Oligocene")
    rid <- paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff/", lat, "/", trt)
    tmp <- out_table_MBD(rid, interval = int)
    plot_df <-tmp[[1]]
    signif_df <- tmp[[2]]
    # Extend the big berthas
    PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
    SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
  }
  PLOT_DF <- PLOT_DF[-c(1),]
  SIGNIF_DF <- SIGNIF_DF[-c(1),]
  #change Eocene Oligocene order
  PLOT_DF$interval <- factor(PLOT_DF$interval, levels = c("Oligocene", "Eocene"))
  SIGNIF_DF$interval <- factor(SIGNIF_DF$interval, levels = c("Oligocene", "Eocene"))
  #plot
  MBD_viol <- MBD.plot(PLOT_DF = PLOT_DF,
                       SIGNIF_DF = SIGNIF_DF,
                       x_breaks = 0:6,
                       x_labels = c(values(covar_idx)),
                       rate.labs = rate.labs,
                       int.labs = c("Oligocene", "Eocene"),
                       vjust.star.ori = 0.4,
                       vjust.star.ext = 0.4)
  ggsave(paste0("./figures/supp_figs/andes_geo_strat/", lat, "_time_stratified_MBD_default.pdf"),
         plot = MBD_viol,
         height = 200,
         width = 350,
         units = "mm")
}

########################## ALTERNATIVE PARTITIONINGS ###########################
## Loop for full-time panels ---------------------------------------------------
for(tal in c("HIGHLAT_conservative", "LOWLAT_conservative", "HIGHLAT_stringent", "LOWLAT_stringent")){
  spl <- strsplit(tal, split = "_")[[1]]
  lat <- spl[1]
  
  rid <- paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_", spl[2], "/", lat)
  tmp <- out_table_MBD(rid, interval = NA)
  plot_df <- tmp[[1]]
  signif_df <- tmp[[2]]
  #plot
  MBD_viol <- MBD.plot(PLOT_DF = plot_df,
                       SIGNIF_DF = signif_df,
                       x_breaks = 0:6,
                       x_labels = c(values(covar_idx)),
                       rate.labs = rate.labs,
                       vjust.star.ori = 0.4,
                       vjust.star.ext = 0.4,
                       time_facetting = FALSE)
  ggsave(paste0("./figures/supp_figs/andes_geo_strat/", tal, "_MBD.pdf"),
         plot = MBD_viol,
         height = 150,
         width = 350,
         units = "mm")
}

## Loop for time-stratified panels ---------------------------------------------------
for(tal in c("HIGHLAT_conservative", "LOWLAT_conservative", "HIGHLAT_stringent", "LOWLAT_stringent")){
    PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA)
    SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA)
    spl <- strsplit(tal, split = "_")[[1]]
    lat <- spl[1]
    
    for(trt in c("post_EECO", "Oligocene_only")){
      int <- ifelse(trt == "post_EECO", "Eocene", "Oligocene")
      rid <- paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff_", spl[2], "/", lat, "/", trt)
      tmp <- out_table_MBD(rid, interval = int)
      plot_df <-tmp[[1]]
      signif_df <- tmp[[2]]
      # Extend the big berthas
      PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
      SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
    }
    PLOT_DF <- PLOT_DF[-c(1),]
    SIGNIF_DF <- SIGNIF_DF[-c(1),]
    #change Eocene Oligocene order
    PLOT_DF$interval <- factor(PLOT_DF$interval, levels = c("Oligocene", "Eocene"))
    SIGNIF_DF$interval <- factor(SIGNIF_DF$interval, levels = c("Oligocene", "Eocene"))
    #plot
    MBD_viol <- MBD.plot(PLOT_DF = PLOT_DF,
                         SIGNIF_DF = SIGNIF_DF,
                         x_breaks = 0:6,
                         x_labels = c(values(covar_idx)),
                         rate.labs = rate.labs,
                         int.labs = c("Oligocene", "Eocene"),
                         vjust.star.ori = 0.4,
                         vjust.star.ext = 0.4)
    ggsave(paste0("./figures/supp_figs/andes_geo_strat/", tal, "_time_stratified_MBD.pdf"),
           plot = MBD_viol,
           height = 200,
           width = 350,
           units = "mm")
}
