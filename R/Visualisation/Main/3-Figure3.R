################################################################################
# Name: 3-Figure_3.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for plots assembled in the Figure 3.
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
source("./R/useful/load_gts.R") # load geological timescales
library("readxl")
library("ggpubr")

## Figure 1 --------------------------------------------------------------------
# path to rtt files
rtt_paths <- c("./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/BDCS/Tropical/",
               "./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/BDCS/Extratropical/")
# path to ltt files
ltt_path <- c("./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/RJMCMC/Tropical/",
              "./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/RJMCMC/Extratropical/")
# deviation for BDS rates
delta <- 0.2
# plot list
plot_list1 <- list()
i <- 0
j <- 0
for(k in 1:2){
  rtt_file <- list.files(paste0(rtt_paths[k], "combined_logs/"), pattern = "_RTT.r") #character of length 1
  rtt_tbl <- extract_rtt(path = paste0(rtt_paths[k], "combined_logs/", rtt_file), ana = "BDS")
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
  # adjust age of shifts
  s <- 0 # just for extra-tropical
  if(k == 2){
    s <- 1
  }
  rtt_tbl$time[which(rtt_tbl$time == 49-s)] <- 47.8 + delta
  rtt_tbl$time[which(rtt_tbl$time == 48-s)] <- 47.8 - delta
  rtt_tbl$time[which(rtt_tbl$time == 39-s)] <- 37.71 + delta
  rtt_tbl$time[which(rtt_tbl$time == 38-s)] <- 37.71 - delta
  rtt_tbl$time[which(rtt_tbl$time == 35-s)] <- 33.9 + delta
  rtt_tbl$time[which(rtt_tbl$time == 34-s)] <- 33.9 - delta
  rtt_tbl$time[which(rtt_tbl$time == 29-s)] <- 27.8 + delta
  rtt_tbl$time[which(rtt_tbl$time == 28-s)] <- 27.8 - delta
  # gts stuff
  i <- i+1
  if(i >= 4){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
    xlim <- NULL
    display_gts <- TRUE
  }
  
  # diversification rates plot ---------
  rtt_plt <- rtt_plot(data = rtt_tbl,
                      type = "SpEx",
                      y_limits = c(0, 0.55),
                      x_lab = x_lab,
                      stage_x_breaks = FALSE,
                      manual_x_breaks = seq(25, 50, 5),
                      y_breaks = seq(0, 0.5, 0.1),
                      axes.labelsize=15,
                      ticks.labelsize = 12,
                      restrict_y = TRUE,
                      restrict_thr = 0.55,
                      ori_col="#08519c",
                      ext_col="#a50f15",
                      display_gts = display_gts,
                      xlim = xlim,
                      plot.border = FALSE,
                      x.axis = x.axis,
                      display_EECO_MECO = TRUE,
                      several_gts = TRUE,
                      geoscale = gsc1_bis,
                      geoscale2 = gsc2_bis,
                      geoscale3 = gsc3_bis,
                      geoscale_height = unit(.75, "line"),
                      abbr = list(TRUE, TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    # EOT line
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) # EOT
  #add labels in the first line
  if(i == 1){
    rtt_plt <- rtt_plt +
      annotate(geom = "text", x = 31.5, y = 0.52, label = "EOT", size = 7, colour = "red")
  }
  if(i == 4){
    rtt_plt <- rtt_plt +
      annotate(geom = "segment", x = 47, xend = 50, y = 0.5, yend = 0.5, colour = "#08519c", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 0.5, label = "Origination rate", size = 5) +
      annotate(geom = "segment", x = 47, xend = 50, y = 0.45, yend = 0.45, colour = "#a50f15", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 0.45, label = "Extinction rate ", size = 5) +
      geom_text(aes(x = 51.5, y = 0.35, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 0.35, label = "MECO"), angle = 90, colour = "bisque4")
  }
  plot_list1[[i+j]] <- rtt_plt
  #add blank element to plot list
  j <- j+1
  plot_list1[[i+j]] <- NULL
  # net rate plot ---------------------
  i <- i+1
  if(i >= 4){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
    xlim <- NULL
    display_gts <- TRUE
  }
  net_plt <- rtt_plot(data = rtt_tbl,
                      type = "net",
                      x_lab = x_lab,
                      y_breaks = seq(-0.2, 0.4, 0.1),
                      y_limits = c(-0.45, 0.45),
                      restrict_thr = 0.45,
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
                      geoscale = gsc1_bis,
                      geoscale2 = gsc2_bis,
                      geoscale3 = gsc3_bis,
                      geoscale_height = unit(.75, "line"),
                      abbr = list(TRUE, TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) # EOT
  #add labels in the first line
  if(i == 2){
    net_plt <- net_plt +
      annotate(geom = "text", x = 31.5, y = 0.4, label = "EOT", size = 7, colour = "red")
  }
  if(i == 5){
    net_plt <- net_plt +
      annotate(geom = "segment", x = 47, xend = 50, y = 0.35, yend = 0.35, colour = "#504A4B", linewidth = 1) +
      annotate(geom = "text", x = 40.5, y = 0.35, label = "Net diversification\n rate", size = 5) +
      geom_text(aes(x = 51.5, y = -0.325, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = -0.325, label = "MECO"), angle = 90, colour = "bisque4")
  }
  plot_list1[[i+j]] <- net_plt
  #add blank element to plot list
  j <- j+1
  plot_list1[[i+j]] <- NULL
  # LTT plot --------------------------
  i <- i+1
  lgth_break <- 10
  if(k == 2){
    lgth_break <- 20
  }
  if(i >= 4){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
    xlim <- NULL
    display_gts <- TRUE
  }
  ltt <- list.files(paste0(ltt_path[k], "LTT/"), pattern = "se_est_ltt.txt")
  ltt_tbl <- read.table(paste0(ltt_path[k], "LTT/", ltt), header = TRUE)
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
                       y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10), lgth_break), 
                       y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 22)),
                       display_gts = display_gts,
                       xlim = xlim,
                       avg_col = "#006d2c",
                       ribbon_col = "#74c476",
                       plot.border = FALSE,
                       x.axis = x.axis,
                       display_EECO_MECO = TRUE,
                       several_gts = TRUE,
                       geoscale = gsc1_bis,
                       geoscale2 = gsc2_bis,
                       geoscale3 = gsc3_bis,
                       geoscale_height = unit(.75, "line"),
                       abbr = list(TRUE, TRUE, FALSE)) +
    # Temporal bands
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) #EOT
  #add labels in the first line
  if(i == 3){
    ltt.plot <- ltt.plot +
      annotate(geom = "text", x = 31.5, y = 40, label = "EOT", size = 7, colour = "red")
  }
  if(i == 6){
    ltt.plot <- ltt.plot +
      annotate(geom = "segment", x = 42.5, xend = 45, y = 110, yend = 110, colour = "#006d2c", linewidth = 1) +
      annotate(geom = "text", x = 39.25, y = 110, label = "Diversity", size = 5) +
      geom_text(aes(x = 51.5, y = 18, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 18, label = "MECO"), angle = 90, colour = "bisque4")
    
  }
  plot_list1[[i+j]] <- ltt.plot
}

fig3 <- ggarrange(plotlist = plot_list1, nrow = 2, ncol = 5, 
                  heights = c(1, 1.25),
                  widths = c(1, 0.05, 1, 0.05, 1),
                  labels = c("(A)", NA, "(B)", NA, "(C)",
                             "(D)",  NA, "(E)", NA, "(F)"),
                  hjust = 0,
                  font.label = list(size = 18))

ggsave("./figures/Figure_3/RTT_LTT_trop_etrop.pdf",
       plot = fig3,
       height = 200,
       width = 400,
       units = "mm")



## Plot tropical LTT with Contamana and Shapaja's occurrences assigned a Priabonian-Rupelian age (to fit with Campbell et al. (2021))
  # get equivalences between indices and taxon names
source("./R/useful/helper_functions.R")
occdf <- readRDS("./data_2023/SPECIES_LISTS/9-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet-CTA-TAR-Olig.RDS")
trop <- unique(occdf$genus[which(occdf$loc == "T")])
trop <- sapply(trop, spc_to_udsc)

taxlist <- read.table("./data_2023/PyRate/EXTENDED/SALMA_smoothed/genus_level/1-Full/Full_extended_TAR_CTA_redated_TaxonList.txt",
                      header = TRUE)
corr_idx <- which(taxlist$Species %in% trop)
  # select tropical's TsTe
div_tot <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/1bis-Full_CTA_TAR_redated/LTT/Full_extended_TAR_CTA_redated_10_Grj_KEEP_se_est.txt",
                      header = TRUE)
div_trop <- div_tot[corr_idx,]
write.table.lucas(div_trop, "./results_EXTENDED/SALMA_smoothed/genus_level/1bis-Full_CTA_TAR_redated/trop_only/LTT/trop_ltt_redated.txt")

  ## bash: python ~/PyRate/PyRate.py -d ./LTT/trop_ltt_redated.txt -ltt 1

## Plot LTT
ltt_tbl_trop_redated <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/1bis-Full_CTA_TAR_redated/trop_only/LTT/trop_ltt_redated_ltt.txt", header = TRUE)
ltt_tbl_trop_redated <- ltt_tbl_trop_redated %>%
  rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div) %>%
  filter(Age > 24 & Age < 52)
# plotting adjustments
ltt_tbl_trop_redated$Age[1] <- 24
ltt_tbl_trop_redated$Age[nrow(ltt_tbl_trop_redated)] <- 52
# plot
ltt_plot_trop_redated <- ltt_plot(ltt_tbl_trop_redated,
                     stage_x_breaks = FALSE,
                     manual_x_breaks = seq(25, 50, 5),
                     axes.labelsize=15,
                     ticks.labelsize = 12,
                     x_lab = "Time (Ma)",
                     y_lab = NULL,
                     y_breaks = seq(0, 30, 10), 
                     y_limits = c(0, 35),
                     display_gts = TRUE,
                     xlim = xlim,
                     avg_col = "#006d2c",
                     ribbon_col = "#74c476",
                     plot.border = FALSE,
                     display_EECO_MECO = TRUE,
                     several_gts = TRUE,
                     geoscale = gsc1_bis,
                     geoscale2 = gsc2_bis,
                     geoscale3 = gsc3_bis,
                     geoscale_labelsize = 4,
                     geoscale_height = unit(.75, "line"),
                     abbr = list(TRUE, TRUE, FALSE),
                     main = "Considering Campbell et al. (2021)") +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + #EOT
  annotate(geom = "segment", x = 42.5, xend = 45, y = 110, yend = 110, colour = "#006d2c", linewidth = 1) +
  annotate(geom = "text", x = 39.25, y = 110, label = "Diversity", size = 5) +
  annotate(geom = "text", x = 31.5, y = 115, label = "EOT", size = 7, colour = "red") +
  geom_text(aes(x = 51.5, y = 18, label = "EECO"), angle = 90, colour = "bisque4") +
  geom_text(aes(x = 41.25, y = 18, label = "MECO"), angle = 90, colour = "bisque4")


## Tropical non-redated

ltt_tbl_trop <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/4-Tropical_Extratropical/RJMCMC/Tropical/LTT/Tropical_EOT_gen_occ_SALMA_smoothed_10_Grj_KEEP_se_est_ltt.txt", header = TRUE)
ltt_tbl_trop <- ltt_tbl_trop %>%
  rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div) %>%
  filter(Age > 24 & Age < 52)
# plotting adjustments
ltt_tbl_trop$Age[1] <- 24
ltt_tbl_trop$Age[nrow(ltt_tbl_trop)] <- 52
# plot
ltt_plot_trop <- ltt_plot(ltt_tbl_trop,
                          stage_x_breaks = FALSE,
                          manual_x_breaks = seq(25, 50, 5),
                          axes.labelsize=15,
                          ticks.labelsize = 12,
                          x_lab = "Time (Ma)",
                          y_breaks = seq(0, 30, 10), 
                          y_limits = c(0, 35),
                          display_gts = TRUE,
                          xlim = xlim,
                          avg_col = "#006d2c",
                          ribbon_col = "#74c476",
                          plot.border = FALSE,
                          display_EECO_MECO = TRUE,
                          several_gts = TRUE,
                          geoscale = gsc1_bis,
                          geoscale2 = gsc2_bis,
                          geoscale3 = gsc3_bis,
                          geoscale_height = unit(.75, "line"),
                          abbr = list(TRUE, TRUE, FALSE),
                          geoscale_labelsize = 4,
                          main = "Original ages") +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + #EOT
  annotate(geom = "segment", x = 42.5, xend = 45, y = 110, yend = 110, colour = "#006d2c", linewidth = 1) +
  annotate(geom = "text", x = 39.25, y = 110, label = "Diversity", size = 5) +
  annotate(geom = "text", x = 31.5, y = 115, label = "EOT", size = 7, colour = "red") +
  geom_text(aes(x = 51.5, y = 18, label = "EECO"), angle = 90, colour = "bisque4") +
  geom_text(aes(x = 41.25, y = 18, label = "MECO"), angle = 90, colour = "bisque4")

## Combine and save
p <- ggarrange(ltt_plot_trop, ltt_plot_trop_redated, ncol = 2, labels = c("(A)", "(B)"))
ggsave("./figures/supp_figs/CTA_TAR_redated/compared_LTTs.pdf", p, height = 200, width = 400, units = "mm")
