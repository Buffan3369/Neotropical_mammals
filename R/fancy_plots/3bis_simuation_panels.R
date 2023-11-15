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
list_LTT <- list()
list_Q <- list()
for(i in 0:9){
  #Directories
  dir_rtt <- paste0("../../PyRate_outputs/simulations/combined_logs/replicate_", i, "/RTT_plots.r")
  dir_ltt <- paste0("../../PyRate_outputs/simulations/LTT/replicate_", i, "/per_replicate/")
  dir_q <- paste0("../../PyRate_outputs/simulations/Q_SHIFTS/replicate_", i, "/Parsed_Q_rates.csv")
  #Get data
  rtt <- extract_rtt(dir_rtt, ana = "RJMCMC")
  ltt <- extract_ltt(dir_ltt)
  Q <- read.table(dir_q, header = TRUE)
  #Plotting settings
  x_lab <- NULL
  y_lab_rtt <- NULL
  y_lab_ltt <- NULL
  y_lab_q <- NULL
  if(i %in% 5:9){
    x_lab <- "Time (Ma)"
  }
  if(i %in% c(0, 5)){
    y_lab_rtt <- "Rates (events/lineage/My)"
    y_lab_ltt <- "Diversity (Nb. lineages)"
    y_lab_q <- "Mean preservation rate (occ/lineage/My)"
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
                    y_lab = y_lab_rtt) +
    geom_hline(yintercept = 0.17, linetype = "dashed") +
    geom_hline(yintercept = 0.1, linetype = "dashed")
  list_RTT[[i+1]] <- sp_ex
  #Lineages through time
  ltt_plt <- ltt_plot(ltt_df = ltt,
                      x_breaks = c(23.03, 27.82, 33.9, 37.82, 41.2, 47.8, 56),
                      x_labels = c(23, 27.8, 33.9, 37.8, 41.2, 47.8, 56),
                      x_limits = c(min(max(ltt$Age), 56), 23.03),
                      y_breaks = seq(0,(round(max(ltt$Diversity), -1) + 10),5),
                      y_limits = c(0,(round(max(ltt$Diversity), -1) + 20)),
                      main = paste0("Replicate ",i),
                      x_lab = x_lab,
                      y_lab = y_lab_ltt)
  list_LTT[[i+1]] <- ltt_plt
  #Preservation rates
  Q_plot <- q_plot(data = Q, 
                   ltt_input = ltt, 
                   y_limits = c(0, 2.4),
                   x_breaks = c(23.03, 27.82, 33.9, 37.82, 41.2, 47.8, 56),
                   x_labels = c(23, 27.8, 33.9, 37.8, 41.2, 47.8, 56),
                   x_limits = c(min(max(ltt$Age), 56), 23.03),
                   x_lab = x_lab,
                   y_lab = y_lab_q)
  list_Q[[i+1]] <- Q_plot
}
#Do panels
rtt_panel <- ggarrange(plotlist = list_RTT,
                       nrow = 2,
                       ncol = 5)
ltt_panel <- ggarrange(plotlist = list_LTT,
                       nrow = 2,
                       ncol = 5)
Q_panel <- ggarrange(plotlist = list_Q,
                     nrow = 2,
                     ncol = 5)
#Save them
ggsave("./figures/simulations/rtt_panel.png",
       plot = rtt_panel,
       height = 400,
       width = 1000,
       units = "mm",
       dpi = 500)
ggsave("./figures/simulations/ltt_panel.png",
       plot = ltt_panel,
       height = 400,
       width = 1000,
       units = "mm",
       dpi = 500)
ggsave("./figures/simulations/Qrates_panel.png",
       plot = Q_panel,
       height = 400,
       width = 1000,
       units = "mm",
       dpi = 500)
