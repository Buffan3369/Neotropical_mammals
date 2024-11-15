################################################################################
# Name: 4-Figure4.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 4 (MBD results full Eocene post-EOT + Oligocene).
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
int.labs <- c("Eocene", "Oligocene")
names(int.labs) <- c("Eocene", "Oligocene")

## Full-time panels ---------------------------------------------------
int <- NA
rid <- "./results_EXTENDED/MBD/SALMA_smoothed/genus_level/1-Full_stringent_partitioning/"
tmp <- out_table_MBD(rid, interval = int)
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
ggsave(paste0("./figures/Main/Figure_4/Full_SALMA_smoothed_COMPLETE_stringent.pdf"),
       plot = MBD_viol,
       height = 150,
       width = 350,
       units = "mm")

## Loop for time-faceted panels ------------------------------------------------
PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA)
SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA)
for(trt in c("post_EECO", "Oligocene_only")){
  int <- ifelse(trt == "post_EECO", "Eocene", "Oligocene")
  rid <- paste0("./results_EXTENDED/MBD/SALMA_smoothed/genus_level/1-Full_stringent_partitioning/", trt)
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
ggsave(paste0("./figures/Main/Figure_4/Full_SALMA_smoothed_time_faceted_stringent.pdf"),
       plot = MBD_viol,
       height = 300,
       width = 400,
       units = "mm")
