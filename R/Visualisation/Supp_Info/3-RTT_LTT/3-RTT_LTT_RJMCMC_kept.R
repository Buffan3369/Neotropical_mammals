################################################################################
# Name: 3-Figure1_RJMCMC_kept.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 1 with diversification rates estimated with RJMCMC, 
#       SALMA kept.
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("ggpubr")

## Figure 1 --------------------------------------------------------------------
paths <- c("./results_EXTENDED/SALMA_kept/genus_level/1-Full/MH_sampler/",
           "./results_EXTENDED/SALMA_kept/species_level/1-Full/MH_sampler/",
           "./results_EXTENDED/SALMA_kept/genus_level/4-Tropical_Extratropical/RJMCMC/Extratropical/",
           "./results_EXTENDED/SALMA_kept/genus_level/4-Tropical_Extratropical/RJMCMC/Tropical/")
gsc2 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
gsc2 <- gsc2 %>% 
  rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name") %>%
  mutate(min_age = sapply(min_age, as.numeric), max_age = sapply(max_age, as.numeric))
plot_list1 <- list()
i <- 0
j <- 0
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
  x.axis <- FALSE
  xlim <- c(52, 24)
  display_gts <- FALSE
  # gts stuff
  i <- i+1
  if(i >= 10){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
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
                      axes.labelsize=15,
                      ticks.labelsize = 12,
                      restrict_y = TRUE,
                      restrict_thr = 1.1,
                      ori_col="#08519c",
                      ext_col="#a50f15",
                      display_gts = display_gts,
                      xlim = xlim,
                      plot.border = FALSE,
                      x.axis = x.axis,
                      display_EECO_MECO = TRUE,
                      several_gts = TRUE,
                      geoscale2 = gsc2,
                      geoscale_height = unit(1, "line"),
                      abbr = list(TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    # EOT line
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) # EOT
  #add labels in the first line  
  if(i == 1){
    rtt_plt <- rtt_plt +
      annotate(geom = "segment", x = 47, xend = 50, y = 1, yend = 1, colour = "#08519c", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 1, label = "Origination rate", size = 5) +
      annotate(geom = "segment", x = 47, xend = 50, y = 0.9, yend = 0.9, colour = "#a50f15", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 0.9, label = "Extinction rate ", size = 5) +
      annotate(geom = "text", x = 31.5, y = 1.05, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = 0.7, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 0.7, label = "MECO"), angle = 90, colour = "bisque4")
  }
  plot_list1[[i+j]] <- rtt_plt
  #add blank element to plot list
  j <- j+1
  plot_list1[[i+j]] <- NULL
  # net rate plot ---------------------
  i <- i+1
  if(i >= 10){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
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
                      axes.labelsize=15,
                      ticks.labelsize = 12,
                      net_col="#252525",
                      display_gts = display_gts,
                      xlim = xlim,
                      plot.border = FALSE,
                      x.axis = x.axis,
                      display_EECO_MECO = TRUE,
                      several_gts = TRUE,
                      geoscale2 = gsc2,
                      geoscale_height = unit(1, "line"),
                      abbr = list(TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) # EOT
  #add labels in the first line  
  if(i == 2){
    net_plt <- net_plt +
      annotate(geom = "segment", x = 47, xend = 50, y = 0.9, yend = 0.9, colour = "#504A4B", linewidth = 1) +
      annotate(geom = "text", x = 40.5, y = 0.81, label = "Net diversification\n rate", size = 5) +
      annotate(geom = "text", x = 31.5, y = 1, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = -0.9, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = -0.9, label = "MECO"), angle = 90, colour = "bisque4")
    
  }
  plot_list1[[i+j]] <- net_plt
  #add blank element to plot list
  j <- j+1
  plot_list1[[i+j]] <- NULL
  # LTT plot --------------------------
  i <- i+1
  if(i >= 10){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
    xlim <- NULL
    display_gts <- TRUE
  }
  ltt <- list.files(paste0(pth, "LTT/"), pattern = "se_est_ltt.txt")
  ltt_tbl <- read.table(paste0(pth, "LTT/", ltt), header = TRUE)
  ltt_tbl <- ltt_tbl %>%
    rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div) %>%
    filter(Age > 24 & Age < 52)
  # plotting adjustments
  ltt_tbl$Age[1] <- 24
  ltt_tbl$Age[nrow(ltt_tbl)] <- 52
  # plot
  ltt.plot <- ltt_plot(ltt_tbl,
                       stage_x_breaks = FALSE,
                       manual_x_breaks = seq(25, 50, 5),
                       axes.labelsize=15,
                       ticks.labelsize = 12,
                       x_lab = x_lab,
                       y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                       y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 20)),
                       display_gts = display_gts,
                       xlim = xlim,
                       avg_col = "#006d2c",
                       ribbon_col = "#74c476",
                       plot.border = FALSE,
                       x.axis = x.axis,
                       display_EECO_MECO = TRUE,
                       several_gts = TRUE,
                       geoscale2 = gsc2,
                       geoscale_height = unit(1, "line"),
                       geoscale_labelsize = 4,
                       abbr = list(TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) #EOT
  #add labels in the first line  
  if(i == 3){
    ltt.plot <- ltt.plot +
      annotate(geom = "segment", x = 42.5, xend = 45, y = 110, yend = 110, colour = "#006d2c", linewidth = 1) +
      annotate(geom = "text", x = 39.25, y = 110, label = "Diversity", size = 5) +
      annotate(geom = "text", x = 31.5, y = 115, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = 11, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 11, label = "MECO"), angle = 90, colour = "bisque4")
    
  }
  plot_list1[[i+j]] <- ltt.plot
}

fig1 <- ggarrange(plotlist = plot_list1, nrow = 4, ncol = 5, 
                  heights = c(1, 1, 1, 1.25),
                  widths = c(1, 0.05, 1, 0.05, 1),
                  labels = c("(A)", NA, "(B)", NA, "(C)",
                             "(D)",  NA, "(E)", NA, "(F)",
                             "(G)",  NA, "(H)",  NA, "(I)",
                             "(J)",  NA, "(K)",  NA, "(L)"),
                  hjust = -0.4, 
                  font.label = list(size = 18))

ggsave("./figures/supp_figs/RTT_LTT/RJMCMC_kept/backbone_rj_kept_genus.pdf",
       plot = fig1,
       height = 400,
       width = 400,
       units = "mm")

ggsave("./figures/supp_figs/RTT_LTT/RJMCMC_kept/backbone_rj_kept_genus.png",
       plot = fig1,
       height = 400,
       width = 400,
       dpi = 600,
       units = "mm")
