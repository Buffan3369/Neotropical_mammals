################################################################################
# Name: 3bis-RTT_BDCS_panel.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for rates through time panel inferred with BDCS (4 treatments:
#     SALMA_kept/smoothed and rate shifts per epochs/5My bins)
################################################################################

## Load accessory functions and packages ---------------------------------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("ggpubr")

## Specify geoscales -----------------------------------------------------------
  # Sub-epochs
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
  # SALMAs
gsc3 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
gsc3 <- gsc3 %>% 
  rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name") %>%
  mutate(min_age = sapply(min_age, as.numeric), max_age = sapply(max_age, as.numeric))

## Loop across the 4 treatments ------------------------------------------------
paths <- c("./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/BDS/",
           "./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/BDS_5M/",
           "./results_EXTENDED/SALMA_kept/genus_level/1-Full/BDS/",
           "./results_EXTENDED/SALMA_kept/genus_level/1-Full/BDS_5M/")
list_plots <- list()
i <- 1
for(pth in paths){
  # specify second geoscale 
  spl <- strsplit(pth, split = "/")[[1]]
  if(spl[3] == "SALMA_smoothed"){
    geoscale2 <- gsc2
  }
  else if(spl[3] == "SALMA_kept"){
    geoscale2 <- gsc3
  }
  # specify bins used for constrained rate shifts
  if(i %% 2 == 0){
    bins <- "5M"
  }
  else{
    bins <- "epochs"
  }
  # open rtt table
  rtt_tbl <- extract_rtt(path = paste0(
    pth, "combined_logs/", 
    list.files(paste0(pth, "combined_logs/"), pattern = '_RTT.r')
  ),
  ana = "BDS")
  # restrict plotting window
  rtt_tbl <- rtt_tbl %>% filter(time > 24 & time <= 52)
  # adjustments for plotting window
  rtt_tbl$time[1] <- 24
  rtt_tbl$time[nrow(rtt_tbl)] <- 52
  # plotting aesthetics
  x_lab <- "Time (Ma)"
  x.axis <- TRUE
  xlim <- NULL
  display_gts <- TRUE
  # plot
  rtt_plt <- rtt_plot(data = rtt_tbl,
                      type = "SpEx",
                      y_limits = c(0, 0.45),
                      x_lab = x_lab,
                      stage_x_breaks = FALSE,
                      manual_x_breaks = seq(25, 50, 5),
                      main = paste0(spl[3], "_", bins),
                      axes.labelsize=15,
                      ticks.labelsize = 12,
                      restrict_y = TRUE,
                      restrict_thr = 0.45,
                      ori_col="#08519c",
                      ext_col="#a50f15",
                      display_gts = display_gts,
                      xlim = xlim,
                      plot.border = FALSE,
                      x.axis = x.axis,
                      display_EECO_MECO = TRUE,
                      several_gts = TRUE,
                      geoscale2 = geoscale2,
                      geoscale_height = unit(1, "line"),
                      abbr = list(TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    # EOT line
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) # EOT
  
  ## Add to plot list
  list_plots[[i]] <- rtt_plt
  i <- i+1
}

## Assemble and save -----------------------------------------------------------
tot <-  ggarrange(plotlist = list_plots, nrow = 2, ncol = 2)
ggsave("./figures/supp_figs/rtt_BDCS.pdf", height = 300, width = 350, units = "mm")
