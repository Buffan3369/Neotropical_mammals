################################################################################
###################### Panel for the 10 simulation outputs #####################
################################################################################

library(ggpubr)
library(hash)

## Source accessory functions for plotting -------------------------------------
source("C:/Users/lucas/OneDrive/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("C:/Users/lucas/OneDrive/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")

## RTT panel -------------------------------------------------------------------
list_RTT <- list()
for(i in 0:9){
  dir <- paste0("../../PyRate_outputs/simulations/combined_logs/replicate_", i, "/RTT_plots.r")
  rtt <- extract_rtt(dir, ana = "RJMCMC")
  x_lab <- NULL
  y_lab <- NULL
  if(i %in% 5:9){
    x_lab <- "Time (Ma)"
  }
  if(i %in% c(0, 5)){
    y_lab <- "Rates (events/lineage/My)"
  }
  #Origination and Extinction rates
  sp_ex <- rtt_plot(data = rtt,
                    type = "SpEx",
                    x_breaks = c(23.03, 27.82, 33.9, 37.82, 41.2, 47.8, 56),
                    x_labels = c(23, 27.8, 33.9, 37.8, 41.2, 47.8, 56),
                    x_limits = c(min(max(rtt$time), 56), 23.03),
                    y_breaks = seq(from = 0, to = 1.4, by = 0.2),
                    y_labels = seq(from = 0, to = 1.4, by = 0.2),
                    y_limits = c(0, 1.5),
                    main = paste0("Replicate ",i),
                    x_lab = x_lab,
                    y_lab = y_lab) +
    geom_hline(yintercept = 0.17, linetype = "dashed") +
    geom_hline(yintercept = 0.1, linetype = "dashed")
  list_RTT[[i+1]] <- sp_ex
}
rtt_panel <- ggarrange(plotlist = list_RTT,
                       nrow = 2,
                       ncol = 5)
ggsave("./figures/simulations/rtt_panel.png",
       plot = rtt_panel,
       height = 400,
       width = 1000,
       units = "mm",
       dpi = 500)
