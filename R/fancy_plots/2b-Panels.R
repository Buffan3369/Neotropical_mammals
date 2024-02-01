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
SALMA <- read_xlsx("./data_2022/time_bins/SALMA_EOT.xlsx")
SALMA <- SALMA %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

## Stupid loop -----------------------------------------------------------------
plot_list <- list()
i <- 0
for(salma in c("SALMA_kept", "SALMA_smoothed")){
  if(salma == "SALMA_kept"){
    gsc2 <- SALMA
  }
  else{
    gsc2 <- read_xlsx("./data_2022/time_bins/EarlyMidLate_epochs.xlsx")
    gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
  }
  for(scl in c("genus_level", "species_level")){
    for(a in c("1-Full", "2-Singleton", "2-Spatially_scaled")){
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
      # net rate plot
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
      ltt_tbl <- ltt_tbl %>% filter(Age > 22.02 & Age < 56)
      ltt.plot <- ltt_plot(ltt_tbl, 
                           y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                           y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 20)),
                           several_gts = TRUE,
                           geoscale2 = gsc2,
                           abbr = list(TRUE, FALSE))
      i <- i+1
      plot_list[[i]] <- ltt.plot
      # Q-rates plot
      q <- read.table(paste0("./results/", salma, "/", scl, "/", a, "/Q_SHIFTS/Parsed_Q_rates.csv"), header = TRUE)
      q <- q %>% filter(Age > 22.02 & Age < 56)
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
                  labels = c("(A)", rep(NA, 2), "(B)", rep(NA, 2), "(C)",
                             rep(NA, 2), "(D)", rep(NA, 2), "(E)", rep(NA, 2),  "(F)", rep(NA, 2)),
                  font.label = list(size = 20))
ggsave("./figures/Sensitivity_analyses/Mustersan_28.2_25/kept_panel.png",
       plot = kept,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)
smoothed <- ggarrange(plotlist = plot_list[25:48], nrow = 6, ncol = 4, 
                      labels = c("(A)", rep(NA, 2), "(B)", rep(NA, 2), "(C)",
                                 rep(NA, 2), "(D)", rep(NA, 2), "(E)", rep(NA, 2),  "(F)", rep(NA, 2)),
                      font.label = list(size = 20))
ggsave("./figures/Sensitivity_analyses/Mustersan_28.2_25/smoothed_panel.png",
       plot = smoothed,
       height = 700,
       width = 1000,
       units = "mm",
       dpi = 200)


## Figure 1 --------------------------------------------------------------------
paths <- c("./results/SALMA_smoothed/genus_level/1-Full/",
           "./results/SALMA_smoothed/species_level/1-Full/",
           "./results/SALMA_smoothed/genus_level/4-Tropical_Extratropical/Extratropical/",
           "./results/SALMA_smoothed/genus_level/4-Tropical_Extratropical/Tropical/")
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
plot_list1 <- list()
i <- 0
for(pth in paths){
  rtt_tbl <- extract_rtt(path = paste0(pth, "combined_logs/RTT_plots.r"), ana = "RJMCMC")
  # in case doesn't go far enough
  if(max(rtt_tbl$time) < 52){
    rtt_tbl$time[nrow(rtt_tbl)] <- 52
  }
  # restrict plotting window
  rtt_tbl <- rtt_tbl %>% filter(time > 24 & time <= 52)
  # adjustments for plotting window
  rtt_tbl$time[1] <- 24
  rtt_tbl$time[nrow(rtt_tbl)] <- 52
  # avoid repeating too many times x label
  x_lab <- NULL
  xlim <- c(52, 24)
  display_gts <- FALSE
  # gts stuff
  i <- i+1
  if(i >= 10){
    x_lab <- "Time (Ma)"
    xlim <- NULL
    display_gts <- TRUE
  }
  # diversification rates plot ---------
  rtt_plt <- rtt_plot(data = rtt_tbl,
                      type = "SpEx",
                      y_limits = c(0, 1.1),
                      x_lab = x_lab,
                      stage_x_breaks = FALSE,
                      manual_x_breaks = seq(25, 50, 5),
                      restrict_y = TRUE,
                      restrict_thr = 1.1,
                      display_gts = display_gts,
                      xlim = xlim,
                      several_gts = TRUE,
                      geoscale2 = gsc2,
                      abbr = list(TRUE, FALSE)) +
    #additional customs
    annotate(geom = "rect", xmin = 37.71, xmax = 47.8, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 27.8, xmax = 33.9, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8)
  plot_list1[[i]] <- rtt_plt
  # net rate plot ---------------------
  i <- i+1
  if(i >= 10){
    x_lab <- "Time (Ma)"
    xlim <- NULL
    display_gts <- TRUE
  }
  net_plt <- rtt_plot(data = rtt_tbl,
                      type = "net",
                      x_lab = x_lab,
                      y_breaks = seq(-1.2, 1.2, 0.3),
                      y_limits = c(-1.1, 1.1),
                      restrict_thr = 1.1,
                      stage_x_breaks = FALSE,
                      manual_x_breaks = seq(25, 50, 5),
                      display_gts = display_gts,
                      xlim = xlim,
                      several_gts = TRUE,
                      geoscale2 = gsc2,
                      abbr = list(TRUE, FALSE)) +
    annotate(geom = "rect", xmin = 37.71, xmax = 47.8, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 27.8, xmax = 33.9, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8)
  plot_list1[[i]] <- net_plt
  # LTT plot --------------------------
  i <- i+1
  if(i >= 10){
    x_lab <- "Time (Ma)"
    xlim <- NULL
    display_gts <- TRUE
  }
  ltt_tbl <- extract_ltt(paste0(pth, "LTT/per_replicate/"))
  ltt_tbl <- ltt_tbl %>% filter(Age > 24 & Age < 52)
  # plotting adjustments
  ltt_tbl$Age[1] <- 24
  ltt_tbl$Age[nrow(ltt_tbl)] <- 52
  # plot
  ltt.plot <- ltt_plot(ltt_tbl,
                       stage_x_breaks = FALSE,
                       manual_x_breaks = seq(25, 50, 5),
                       x_lab = x_lab,
                       y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                       y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 20)),
                       display_gts = display_gts,
                       xlim = xlim,
                       several_gts = TRUE,
                       geoscale2 = gsc2,
                       abbr = list(TRUE, FALSE)) +
    annotate(geom = "rect", xmin = 37.71, xmax = 47.8, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 27.8, xmax = 33.9, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8)
  plot_list1[[i]] <- ltt.plot
}

fig1 <- ggarrange(plotlist = plot_list1, nrow = 4, ncol = 3, heights = c(1,1,1,1.25),
                  labels = c("(A)", rep(NA, 2), "(B)", rep(NA, 2), "(C)",
                             rep(NA, 2), "(D)", rep(NA, 2)),
                  vjust = 1, 
                  font.label = list(size = 18))

ggsave("./figures/Figure_1/backbone.png",
       plot = fig1,
       height = 400,
       width = 700,
       units = "mm",
       dpi = 200)
