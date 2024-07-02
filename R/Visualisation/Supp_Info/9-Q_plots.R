################################################################################
# Name: 9-Q_plots.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Plot Q rates.
################################################################################

  ## Utilities
library(tidyverse)
library(ggpubr)
library(readxl)
source("../../CorsaiR/R/2-plotting_facilities.R")
  ## Load first Geoscale
# first GTS
gsc1 <- deeptime::epochs
# weird GTS modification for plotting
gsc1 <- gsc1[5:6,]


### 1) Full q plots ------------------------------------------------------------
  ## Loop across SALMAs
ltt_input <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/LTT/Full_EOT_gen_occ_SALMA_smoothed_10_Grj_KEEP_se_est_ltt.txt",
                        header = TRUE)
ltt_input <- ltt_input %>% 
  rename(Age = "time") %>%
  filter(Age <= 56 & Age >= 23.03)

list_plots <- list()
i <- -1
for(salma in c("kept", "smoothed")){
  i <- i + 2
  kew <- read.table(paste0("./results_EXTENDED/SALMA_", salma, "/genus_level/1-Full/MH_sampler/Q_SHIFTS/Parsed_Q_rates.csv"),
                    sep = "\t", header = TRUE)
  kew <- kew %>%
    filter(Age <= 56 & Age >= 23.03)
  # second GTS
  if(salma == "kept"){
    gsc2 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
    gsc2 <- gsc2 %>% 
      rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name") %>%
      mutate(min_age = sapply(min_age, as.numeric), max_age = sapply(max_age, as.numeric))
    ylab <- "Preservation rate (occ/genus/My)"
  }
  else{
    gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
    gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
    gsc2 <- gsc2[12:16,]
    ylab <- NULL
  }
  # Proper plot  
  q.plt <- q_plot(kew, 
                  ltt_input = ltt_input,
                  y_breaks = seq(0, 1.8, 0.2),
                  y_limits = c(0, 2),
                  y_lab = ylab,
                  stage_x_breaks = FALSE,
                  manual_x_breaks = seq(25, 50, 5),
                  geoscale = gsc1,
                  axes.labelsize = 12,
                  ticks.labelsize = 9,
                  several_gts = TRUE,
                  geoscale2 = gsc2,
                  geoscale_height = unit(1, "line"),
                  abbr = list(TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + #EOT
    annotate(geom = "text", x = 31.5, y = 1.9, label = "EOT", size = 5, colour = "red")
  list_plots[[i]] <- q.plt
}

q_panel <- ggarrange(plotlist = list_plots,
                     nrow = 1,
                     widths = c(1, 0.05, 1),
                     labels = c("(A)", NA, "(B)"),
                     hjust = 0,
                     font.label = list(size = 10))

ggsave("./figures/supp_figs/q_rates/Full_genus_q_panel.pdf",
       plot = q_panel,
       height = 120,
       width = 240,
       units = "mm")

ggsave("./figures/supp_figs/q_rates/Full_genus_q_panel.png",
       plot = q_panel,
       height = 120,
       width = 240,
       units = "mm",
       dpi = 600)

### 2) Q_plots across latitude -------------------------------------------------
rm(kew, q_panel, q.plt, list_plots)
list_plots <- list()
i <- -1
for(loc in c("Extratropical", "Tropical")){
  for(salma in c("kept", "smoothed")){
    i <- i + 2
    kew <- read.table(paste0("./results_EXTENDED/SALMA_", salma, 
                             "/genus_level/4-Tropical_Extratropical/RJMCMC/", loc, "/Q_SHIFTS/Parsed_Q_rates.txt"),
                      sep = "\t", header = TRUE)
    kew <- kew %>%
      filter(Age <= 56 & Age > 23.03)
    # buffer potential q increase at the Oligocene-Miocene Boundary (not our interest here)
    kew[nrow(kew)+1,] <- kew[nrow(kew),]
    kew$Age[nrow(kew)] <- 23.03
    gts <- FALSE
    xlab <- NULL
    x.axis <- FALSE
    x_lim <- c(54.5, 24.5)
    # second GTS
    if(salma == "kept"){
      gsc2 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
      gsc2 <- gsc2 %>% 
        rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name") %>%
        mutate(min_age = sapply(min_age, as.numeric), max_age = sapply(max_age, as.numeric))
      ylab <- "Preservation rate (occ/genus/My)"
    }
    else{
      gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
      gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
      gsc2 <- gsc2[12:16,]
      ylab <- NULL
    }
    if(loc == "Tropical"){
      ymax = 1.2
    }
    else{
      ymax = 1.7
    }
    if(i > 3){
      gts <- TRUE
      xlab <- "Time (Ma)"
      x.axis <- TRUE
    }
    # Proper plot  
    q.plt <- q_plot(kew, 
                    ltt_input = ltt_input,
                    x_lim = x_lim,
                    y_breaks = seq(0, (ymax-0.1), 0.2),
                    y_limits = c(0, ymax),
                    x.axis = x.axis,
                    x_lab = xlab,
                    y_lab = ylab,
                    stage_x_breaks = FALSE,
                    manual_x_breaks = seq(25, 50, 5),
                    geoscale = gsc1,
                    axes.labelsize = 10,
                    ticks.labelsize = 8,
                    display_gts = gts,
                    several_gts = TRUE,
                    geoscale2 = gsc2,
                    geoscale_height = unit(1, "line"),
                    abbr = list(TRUE, FALSE)) +
      # Temporal bands
      annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
      annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
      annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
      geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + #EOT
      annotate(geom = "text", x = 32, y = ymax-0.05, label = "EOT", size = 4, colour = "red")
    list_plots[[i]] <- q.plt
  }
}

q_panel <- ggarrange(plotlist = list_plots,
                     ncol = 4,
                     nrow = 2,
                     widths = c(1, 0.05, 1, 0.05),
                     heights = c(1, 1.15),
                     labels = c("(A)", NA, "(B)", NA, "(C)", NA, "(D)", NA),
                     hjust = 0,
                     font.label = list(size = 10))
ggsave("./figures/supp_figs/q_rates/Trop_etrop_genus_q_panel.pdf",
       plot = q_panel,
       height = 170,
       width = 250,
       units = "mm")
