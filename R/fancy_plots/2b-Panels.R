################################################################################
# Name: 2b_panels.R
# Author: Lucas Buffan
# Aim: Display linear panels to be able to display as many as we can in one page
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("ggpubr")
SALMA <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
SALMA <- SALMA %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

## Stupid loop -----------------------------------------------------------------
plot_list <- list()
i <- 0
for(salma in c("SALMA_kept", "SALMA_smoothed")){
  if(salma == "SALMA_kept"){
    gsc2 <- SALMA
  }
  else{
    gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
    gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
  }
  for(scl in c("genus_level", "species_level")){
    for(a in c("1-Full", "2-Singleton", "3-Spatially_scaled")){
      rtt_tbl <- extract_rtt(path = paste0("./results/", salma, "/", scl, "/", a, "/combined_logs/RTT_plots.r"), ana = "RJMCMC")
      # origination rate plot
      rtt_plt <- rtt_plot(data = rtt_tbl,
                          type = "SpEx",
                          y_limits = c(0, 1),
                          y_lab = "Rate",
                          restrict_thr = 1,
                          several_gts = TRUE,
                          geoscale2 = gsc2,
                          abbr = list(TRUE, FALSE))
      i <- i+1
      plot_list[[i]] <- rtt_plt
      # extinction rate plot
      ext_plt <- rtt_plot(data = rtt_tbl,
                          type = "net",
                          y_limits = c(-1, 1),
                          restrict_thr = 1,
                          several_gts = TRUE,
                          geoscale2 = gsc2,
                          abbr = list(TRUE, FALSE))
      i <- i+1
      plot_list[[i]] <- ext_plt
      # LTT plot
      ltt_tbl <- extract_ltt( paste0("./results/", salma, "/", scl, "/", a, "/LTT/per_replicate/"))
      ltt_tbl <- ltt_tbl %>% filter(Age > 23.03 & Age < 56)
      ltt.plot <- ltt_plot(ltt_tbl, 
                           y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),30), 
                           y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 20)),
                           several_gts = TRUE,
                           geoscale2 = gsc2,
                           abbr = list(TRUE, FALSE))
      i <- i+1
      plot_list[[i]] <- ltt.plot
      # Q-rates plot
      q <- read.table(paste0("./results/", salma, "/", scl, "/", a, "/Q_SHIFTS/Parsed_Q_rates.csv"), header = TRUE)
      q <- q %>% filter(Age > 23.03 & Age < 56)
      Q_plot<-q_plot(q, 
                     ltt_tbl,
                     several_gts = TRUE,
                     geoscale2 = gsc2,
                     abbr = list(TRUE, FALSE))
      i <- i+1
      plot_list[[i]] <- Q_plot
    }
  }
}

## Partition and save ----------------------------------------------------------
kept <- ggarrange(plotlist = plot_list[1:24], nrow = 6, ncol = 4, 
                  labels = c("(A)", rep(NA, 3), "(B)", rep(NA, 3), "(C)",
                             rep(NA, 3), "(D)", rep(NA, 3), "(E)", rep(NA, 3),  "(F)", rep(NA, 3)),
                  font.label = list(size = 20))
ggsave("./figures/Sensitivity_analyses/Mustersan_38.2_35/kept_panel.png",
       plot = kept,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)
smoothed <- ggarrange(plotlist = plot_list[25:48], nrow = 6, ncol = 4, 
                      labels = c("(A)", rep(NA, 3), "(B)", rep(NA, 3), "(C)",
                                 rep(NA, 3), "(D)", rep(NA, 3), "(E)", rep(NA, 3),  "(F)", rep(NA, 3)),
                      font.label = list(size = 20))
ggsave("./figures/Sensitivity_analyses/Mustersan_38.2_35/smoothed_panel.png",
       plot = smoothed,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)
