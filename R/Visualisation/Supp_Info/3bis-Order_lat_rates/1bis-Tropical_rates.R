################################################################################
# Name: 1bis-Tropical_rates.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for rate comparison plot between tropical and extratropical.
################################################################################

source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("tidyverse")
library("ggpubr")

gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

## Tropical rates --------------------------------------------------------------
dirs <- c("./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/BDCS/Tropical/combined_logs/combined_20_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/BDCS/Extratropical/combined_logs/combined_15_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/BDCS_5M/Tropical/combined_logs/combined_20_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/BDCS_5M/Extratropical/combined_logs/combined_15_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_kept/genus_level/4-Tropical_Extratropical/BDCS/Tropical/combined_logs/combined_20_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_kept/genus_level/4-Tropical_Extratropical/BDCS/Extratropical/combined_logs/combined_11_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_kept/genus_level/4-Tropical_Extratropical/BDCS_5M/Tropical/combined_logs/combined_20_marginal_rates_RTT.r",
          "./results_EXTENDED/SALMA_kept/genus_level/4-Tropical_Extratropical/BDCS_5M/Extratropical/combined_logs/combined_11_marginal_rates_RTT.r")

for(i in 0:3){
  spl <- strsplit(dirs[2*i+1], split = "/")[[1]]
  # which SALMA
  salma <- spl[3]
  # which BDS
  bds <- spl[6]
  # get data 
  rtt_trop <- extract_rtt(dirs[2*i+1],
                          ana = "BDS")
  rtt_etrop <- extract_rtt(dirs[2*i+2],
                           ana = "BDS")
  rtt_trop <- rtt_trop %>% add_column(type="tropical")
  rtt_etrop <- rtt_etrop %>% add_column(type="extratropical")
  
  sp_trop <- rtt_trop %>% 
    select(time, sp_rate, sp_maxHPD, sp_minHPD, type) %>% 
    rename(rate = "sp_rate", minHPD = "sp_minHPD", maxHPD = "sp_maxHPD") %>% 
    mutate(rate_type = "Origination")
  ex_trop <- rtt_trop %>% 
    select(time, ex_rate, ex_maxHPD, ex_minHPD, type) %>% 
    rename(rate = "ex_rate", minHPD = "ex_minHPD", maxHPD = "ex_maxHPD") %>% 
    mutate(rate_type = "Extinction")
  sp_etrop <- rtt_etrop %>% 
    select(time, sp_rate, sp_maxHPD, sp_minHPD, type) %>% 
    rename(rate = "sp_rate", minHPD = "sp_minHPD", maxHPD = "sp_maxHPD") %>% 
    mutate(rate_type = "Origination")
  ex_etrop <- rtt_etrop %>% 
    select(time, ex_rate, ex_maxHPD, ex_minHPD, type) %>% 
    rename(rate = "ex_rate", minHPD = "ex_minHPD", maxHPD = "ex_maxHPD") %>% 
    mutate(rate_type = "Extinction")
  rtt <- rbind.data.frame(sp_etrop, sp_trop, ex_etrop, ex_trop)
  rm(rtt_etrop, rtt_trop, sp_etrop, sp_trop, ex_etrop, ex_trop)
  rtt <- rtt %>% 
    filter(time <= 52 & time >= 24)
  # to represent origination first
  rtt$rate_type <- factor(rtt$rate_type, levels = c("Origination", "Extinction"))
  if(bds == "BDCS"){
    # match with time bins
    rtt$time[which(rtt$time == 47)] <- 47.8
    rtt$time[which(rtt$time == 37)] <- 37.71
    rtt$time[which(rtt$time == 33)] <- 33.9
    rtt$time[which(rtt$time == 27)] <- 27.8
  }
  # restrict extent for plotting
  for(col in colnames(rtt)[-which(colnames(rtt) %in% c("time", "type", "rate_type"))]){
    idx <- which(rtt[, col] > 1.3)
    if(length(idx) > 0){
      rtt[idx, col] <- 1.3
    }
    idx1 <- which(rtt[, col] < -1.3)
    if(length(idx1) > 0){
      rtt[idx1, col] <- -1.3
    }
  }
  # Plot
  oriext <- ggplot(data = rtt, aes(x = time, y = rate)) +
    scale_x_reverse(breaks = seq(25, 50, 5), expand = c(0, 0)) +
    scale_y_continuous(breaks = seq(0, 1.2, 0.2),
                       limits = c(0, 1.3),
                       expand = c(0, 0)) +
    labs(x = "Time (Ma)",
         y = "Rates (event/lineage/My)") +
    geom_step(aes(y = rate, colour = type)) +
    geom_stepribbon(aes(x = time, ymin = minHPD, ymax = maxHPD, fill = type), alpha = 0.1) +
    scale_colour_manual(values = c("#ae017e", "#31a354")) +
    scale_fill_manual(values = c("#ae017e", "#31a354")) +
    theme(axis.title.x = element_text(size = 18),
          axis.title.y = element_text(size = 18),
          axis.text = element_text(size = 15),
          legend.position = c(0.85, 0.9),
          legend.title = element_blank(),
          legend.box.background = element_rect(fill = "black", linewidth = 1),
          legend.key = element_rect(fill = "transparent"),
          strip.text.x = element_text(size = 18),
          strip.text.y = element_text(size = 18),
          strip.background = element_rect(colour = "black", fill = "bisque2"),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_geo(pos = list("bottom", "bottom"),
              dat = list(gsc2, "epochs"),
              abbrv = list(TRUE, FALSE),
              center_end_labels = TRUE,
              size = "auto",
              height = unit(1, "line"),
              clip = "off") +
    facet_wrap(.~rate_type)
  # Save
  if(i == 0){
    ggsave(paste0("./figures/Figure_1/Tropical_rates_", salma, "_", bds, ".pdf"),
           oriext,
           height = 170,
           width = 340,
           units = "mm")
    ggsave(paste0("./figures/Figure_1/Tropical_rates_", salma, "_", bds, ".png"),
           oriext,
           height = 170,
           width = 340,
           dpi = 400,
           units = "mm")
  }
  else{
    ggsave(paste0("./figures/supp_figs/Figure_S5_tropical_rates/Tropical_rates_", salma, "_", bds, ".pdf"),
           oriext,
           height = 170,
           width = 340,
           units = "mm")
    ggsave(paste0("./figures/supp_figs/Figure_S5_tropical_rates/Tropical_rates_", salma, "_", bds, ".png"),
           oriext,
           height = 170,
           width = 340,
           dpi = 400,
           units = "mm")
    
  } 
}
