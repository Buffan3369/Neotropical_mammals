################################################################################
# Name: 13-MBD_andes_strat.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for MBD violin with stratified andean uplift.
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

## Loop for full-time panels ---------------------------------------------------
for(lat in c("HIGHLAT", "LOWLAT")){
  rid <- paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/andes_diff/", lat)
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
  ggsave(paste0("./figures/supp_figs/andes_geo_strat/", lat, "_MBD.pdf"),
         plot = MBD_viol,
         height = 150,
         width = 350,
         units = "mm")
}
