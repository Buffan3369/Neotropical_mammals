################################################################################
####################### Panel for the simulation outputs #######################
################################################################################

library(ggpubr)
library(hash)

## Source accessory functions for plotting -------------------------------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
basal_dir <- "./results/SALMA_smoothed/genus_level/simulations"
## RTT panel -------------------------------------------------------------------
list_RTT <- list()
list_LTT <- list()
list_Q <- list()
for(i in 0:12){
  #Directories
  dir_rtt <- paste0(basal_dir, "/replicate_", i, "/combined_logs/RTT_plots.r")
  dir_ltt <- paste0(basal_dir, "/replicate_", i, "/LTT/per_replicate/")
  dir_q <- paste0(basal_dir, "/replicate_", i, "/Q_SHIFTS/Parsed_Q_rates.csv")
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
                    y_breaks = seq(from = 0, to = 1.4, by = 0.2),
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
                      y_breaks = seq(0,(round(max(ltt$Diversity), -1) + 10),5),
                      y_limits = c(0,(round(max(ltt$Diversity), -1) + 20)),
                      main = paste0("Replicate ",i),
                      x_lab = x_lab,
                      y_lab = y_lab_ltt)
  list_LTT[[i+1]] <- ltt_plt
  #Preservation rates
  Q_plot <- q_plot(q_df = Q, 
                   ltt_input = ltt, 
                   y_limits = c(0, 3.25),
                   y_breaks = seq(0, 3, 0.25),
                   x_lab = x_lab,
                   y_lab = y_lab_q)
  list_Q[[i+1]] <- Q_plot
}
#Do panels
rtt_panel <- ggarrange(plotlist = list_RTT,
                       nrow = 3,
                       ncol = 5)
ltt_panel <- ggarrange(plotlist = list_LTT,
                       nrow = 3,
                       ncol = 5)
Q_panel <- ggarrange(plotlist = list_Q,
                     nrow = 3,
                     ncol = 5)
#Save them
ggsave("./figures/simulations/100_replicates/rtt_panel.png",
       plot = rtt_panel,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)
ggsave("./figures/simulations/100_replicates/ltt_panel.png",
       plot = ltt_panel,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)
ggsave("./figures/simulations/100_replicates/Qrates_panel.png",
       plot = Q_panel,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)
 