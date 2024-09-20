################################################################################
# Name: 4-Figure2_RJMCMC.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 2, diversity and diversification per "order", 
#       with diversification rates estimated with RJMCMC.
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
source("./R/useful/load_gts.R") # load geological timescales

library("readxl")
library("ggpubr")
library("hash")
library("rphylopic")

## Figure 2 --------------------------------------------------------------------
paths <- c("./results/SALMA_smoothed/genus_level/6-Order_level/Notoungulata/",
           "./results/SALMA_smoothed/genus_level/6-Order_level/Other_SANUs/",
           "./results/SALMA_smoothed/genus_level/6-Order_level/Rodentia/",
           "./results/SALMA_smoothed/genus_level/6-Order_level/Xenarthra/",
           "./results/SALMA_smoothed/genus_level/6-Order_level/Metatheria/")
sil <- hash("Notoungulata" = "Trigonostylops",
            "Other_SANUs" = "Protheosodon",
            "Rodentia" = "Spalacopus cyanus",
            "Xenarthra" = "Propalaehoplophorus australis",
            "Metatheria" = "Marmosa")
  # dummy dataset for silhouette plot
df <- data.frame(x = seq(1,10,10),
                 y = rnorm(n = 10, mean = 10))
  # geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
plot_list <- list()
i <- 0
j <- 0
for(pth in paths){
  rtt_tbl <- extract_rtt(path = paste0(pth, "combined_logs/RTT_plots.r"), ana = "RJMCMC")
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
  if(i >= 17){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
    xlim <- NULL
    display_gts <- TRUE
  }
  
  # Fix rodent issue
  p_split <- strsplit(pth, split = "/")[[1]]
  if(p_split[length(p_split)] == "Rodentia"){
    rtt_tbl <- rtt_tbl[-nrow(rtt_tbl), ]
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
                      xlim = xlim,
                      plot.border = FALSE,
                      x.axis = x.axis,
                      display_EECO_MECO = TRUE,
                      display_gts = display_gts,
                      several_gts = TRUE,                     
                      geoscale = gsc1_bis,
                      geoscale2 = gsc2_bis,
                      geoscale_height = unit(1, "line"),
                      abbr = list(TRUE, FALSE)) +
    #additional customs
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8)  # EOT line
  #add labels in the first line  
  if(i == 1){
    rtt_plt <- rtt_plt +
      annotate(geom = "segment", x = 46, xend = 48.5, y = 1, yend = 1, colour = "#08519c", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 1, label = "Origination rate", size = 5) +
      annotate(geom = "segment", x = 46, xend = 48.5, y = 0.9, yend = 0.9, colour = "#a50f15", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 0.9, label = "Extinction rate ", size = 5) +
      annotate(geom = "text", x = 31.5, y = 1.05, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = 0.5, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 0.5, label = "MECO"), angle = 90, colour = "bisque4")
  }
  plot_list[[i+j]] <- rtt_plt
  #add blank element to plot list
  j <- j+1
  plot_list[[i+j]] <- NULL
  # net rate plot ---------------------
  i <- i+1
  if(i >= 17){
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
                      xlim = xlim,
                      plot.border = FALSE,
                      x.axis = x.axis,
                      display_EECO_MECO = TRUE,
                      display_gts = display_gts,
                      several_gts = TRUE,                     
                      geoscale = gsc1_bis,
                      geoscale2 = gsc2_bis,
                      geoscale_height = unit(1, "line"),
                      abbr = list(TRUE, FALSE)) +
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8)  # EOT line
  #add labels in the first line  
  if(i == 2){
    net_plt <- net_plt +
      annotate(geom = "segment", x = 46, xend = 48.5, y = 0.9, yend = 0.9, colour = "#504A4B", linewidth = 1) +
      annotate(geom = "text", x = 40.5, y = 0.81, label = "Net diversification\n rate", size = 5) +
      annotate(geom = "text", x = 31.5, y = 1, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = -0.9, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = -0.9, label = "MECO"), angle = 90, colour = "bisque4")
    
  }
  plot_list[[i+j]] <- net_plt
  #add blank element to plot list
  j <- j+1
  plot_list[[i+j]] <- NULL
  # LTT plot --------------------------
  i <- i+1
  if(i >= 17){
    x_lab <- "Time (Ma)"
    x.axis <- TRUE
    xlim <- NULL
    display_gts <- TRUE
  }
  ltt_tbl <- extract_ltt(paste0(pth, "LTT/per_replicate/"))
  ltt_tbl <- ltt_tbl %>% filter(Age > 24 & Age < 52)
  # plotting adjustments
  ltt_tbl$Age[1] <- 24
  ltt_tbl$Age[nrow(ltt_tbl)] <- 52
  
  if(p_split[length(p_split)] == "Rodentia"){
    ltt_tbl <- ltt_tbl[-nrow(ltt_tbl), ]
  }
  
  # plot
  ltt.plot <- ltt_plot(ltt_tbl,
                       stage_x_breaks = FALSE,
                       manual_x_breaks = seq(25, 50, 5),
                       axes.labelsize=15,
                       ticks.labelsize = 12,
                       x_lab = x_lab,
                       y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                       y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 20)),
                       xlim = xlim,
                       avg_col = "#006d2c",
                       ribbon_col = "#74c476",
                       plot.border = FALSE,
                       x.axis = x.axis,
                       display_EECO_MECO = TRUE,
                       display_gts = display_gts,
                       several_gts = TRUE,                     
                       geoscale = gsc1_bis,
                       geoscale2 = gsc2_bis,
                       geoscale_height = unit(1, "line"),
                       geoscale_labelsize = 4,
                       abbr = list(TRUE, FALSE)) +
    annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
    geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8)  # EOT line
  #add labels in the first line  
  if(i == 3){
    ltt.plot <- ltt.plot +
      annotate(geom = "segment", x = 45, xend = 47.5, y = 55, yend = 55, colour = "#006d2c", linewidth = 1) +
      annotate(geom = "text", x = 42, y = 55, label = "Diversity", size = 5) +
      annotate(geom = "text", x = 31.5, y = 57, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = 5, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 5, label = "MECO"), angle = 90, colour = "bisque4")
    
  }
  plot_list[[i+j]] <- ltt.plot
  #add blank element to plot list
  j <- j+1
  plot_list[[i+j]] <- NULL
  # Silhouette plot
  i <- i+1
  group <- strsplit(pth, split = "/")[[1]]
  group <- group[length(group)]
  corr_silhouette <- as.character(values(sil[group]))
  sil_plot <- ggplot(df) +
    add_phylopic(x = 5, y = 5, name = corr_silhouette, ysize = 0.8) +
    annotate(geom = "text", x = 5, y = 4.1, label = group, size = 8) +
    xlim(4.5,5.5) +
    ylim(4,6) +
    theme(panel.background = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          panel.border = element_blank())
  plot_list[[i+j]] <- sil_plot
}

fig2 <- ggarrange(plotlist = plot_list, nrow = 5, ncol = 7, 
                  heights = c(1, 1, 1, 1, 1.25),
                  widths = c(1, 0.05, 1, 0.05, 1, 0, 0.5),
                  labels = c("(A)", NA, "(B)", NA, "(C)", NA, NA,
                             "(D)",  NA, "(E)", NA, "(F)", NA, NA,
                             "(G)",  NA, "(H)",  NA, "(I)", NA, NA,
                             "(J)",  NA, "(K)",  NA, "(L)", NA, NA,
                             "(M)",  NA, "(N)",  NA, "(O)", NA, NA),
                  hjust = -0.4, 
                  font.label = list(size = 18))


ggsave("./figures/supp_figs/RTT_LTT/RTT_LTT_five_groups_RJMCMC.pdf",
       plot = fig2,
       height = 500,
       width = 600,
       units = "mm")

