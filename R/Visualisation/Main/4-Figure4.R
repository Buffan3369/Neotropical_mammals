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
                "1" = "Plant_diversity",
                "2" = "Andes_elevation",
                "3" = "Temperature",
                "4" = "Atmospheric_carbon",
                "5" = "Organic_carbon",
                "6" = "Sea_level",
                "7" = "Habitat_openness",
                "8" = "rLAI")

# Set strip labels for plots ---------------------------------------------------
rate.labs <- c("Extinction rate", "Origination rate")
names(rate.labs) <- c("Extinction", "Origination")
int.labs <- c("Eocene", "Oligocene")
names(int.labs) <- c("Eocene", "Oligocene")

## BIG ASS LOOP for EOT-panels -------------------------------------------------
dirs <- c("1-Full/", "6-Order_level/")

for(salma in c("SALMA_smoothed")){
  for(dir in dirs){
    # full
    if(strsplit(dir, split = "-")[[1]][1] == "1"){
      # initialise large tables
      PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA)
      SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA)
      for(trt in c("post_EECO", "Oligocene_only")){
        int <- ifelse(trt == "post_EECO", "Eocene", "Oligocene")
        dir <- paste0("./results_EXTENDED/MBD/", salma, "/genus_level/", dir, trt)
        plot_df <- out_table_MBD(dir, interval = int)[[1]]
        signif_df <- out_table_MBD(dir, interval = int)[[2]]
        # Extend the big berthas
        PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
        SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
      }
      PLOT_DF <- PLOT_DF[-c(1),]
      SIGNIF_DF <- SIGNIF_DF[-c(1),]
      #plot
      MBD_viol <- MBD.plot(PLOT_DF = PLOT_DF,
                           SIGNIF_DF = SIGNIF_DF,
                           x_labels = c(values(covar_idx)),
                           rate.labs = rate.labs,
                           int.labs = c("Eocene", "Oligocene"))
      ggsave(paste0("./figures/Figure_4/Full_", salma, ".pdf"),
             plot = MBD_viol,
             height = 300,
             width = 400,
             units = "mm")
    }
    # loop across orders
    if(strsplit(dir, split = "-")[[1]][1] == "6"){
      # initialise large tables
      PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA)
      SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA)
      for(odr in c("Notoungulata")){
        for(trt in c("", "post_EECO/", "Oligocene_only/")){
        dir <- paste0("./results_EXTENDED/MBD/", salma, "/genus_level/", dir, odr, "/", trt)
        plot_df <- out_table_MBD(dir, interval = int)[[1]]
        signif_df <- out_table_MBD(dir, interval = int)[[2]]
        # Extend the big berthas
        PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
        SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
        # plot
        ggsave(paste0("./figures/Figure_4/", odr,"_", salma, ".pdf"),
               plot = MBD_viol,
               height = 300,
               width = 400,
               units = "mm")
        }
      }
    }
  }
}


