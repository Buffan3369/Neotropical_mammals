################################################################################
# Name: 4-Figure2_BDCS.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 2, diversity and diversification per "order", 
#       with diversification rates estimated with RJMCMC.
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("ggpubr")
library("hash")
library("rphylopic")

## Figure 2 --------------------------------------------------------------------
paths <- c("./results_EXTENDED/SALMA_smoothed/genus_level/6-Order_level/Notoungulata/",
           "./results_EXTENDED/SALMA_smoothed/genus_level/6-Order_level/Other_SANUs/",
           "./results_EXTENDED/SALMA_smoothed/genus_level/6-Order_level/Rodentia/",
           "./results_EXTENDED/SALMA_smoothed/genus_level/6-Order_level/Xenarthra/",
           "./results_EXTENDED/SALMA_smoothed/genus_level/6-Order_level/Metatheria/")

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
delta <- 0.3
for(pth in paths){
  rtt_file <- list.files(paste0(pth, "BDCS/combined_logs/"), pattern = "_RTT.r") #character of length 1
  rtt_tbl <- extract_rtt(path = paste0(pth, "BDCS/combined_logs/", rtt_file), ana = "BDS")
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
  rtt_tbl$time[which(rtt_tbl$time == 49)] <- 47.8 + delta
  rtt_tbl$time[which(rtt_tbl$time == 48)] <- 47.8 - delta
  rtt_tbl$time[which(rtt_tbl$time == 39)] <- 37.71 + delta
  rtt_tbl$time[which(rtt_tbl$time == 38)] <- 37.71 - delta
  rtt_tbl$time[which(rtt_tbl$time == 35)] <- 33.9 + delta
  rtt_tbl$time[which(rtt_tbl$time == 34)] <- 33.9 - delta
  rtt_tbl$time[which(rtt_tbl$time == 29)] <- 27.8 + delta
  rtt_tbl$time[which(rtt_tbl$time == 28)] <- 27.8 - delta
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
      annotate(geom = "segment", x = 47, xend = 50, y = 0.5, yend = 0.5, colour = "#08519c", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 0.5, label = "Origination rate", size = 5) +
      annotate(geom = "segment", x = 47, xend = 50, y = 0.45, yend = 0.45, colour = "#a50f15", linewidth = 1) +
      annotate(geom = "text", x = 41.5, y = 0.45, label = "Extinction rate ", size = 5) +
      annotate(geom = "text", x = 31.5, y = 0.5, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = 0.35, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = 0.35, label = "MECO"), angle = 90, colour = "bisque4")
  }
  plot_list[[i+j]] <- rtt_plt
  #add blank element to plot list
  j <- j+1
  plot_list[[i+j]] <- NULL
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
                      y_breaks = seq(-0.5, 0.5, 0.1),
                      y_limits = c(-0.55, 0.55),
                      restrict_thr = 0.55,
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
      annotate(geom = "segment", x = 47, xend = 50, y = 0.4, yend = 0.4, colour = "#504A4B", linewidth = 1) +
      annotate(geom = "text", x = 40.5, y = 0.4, label = "Net diversification\n rate", size = 5) +
      annotate(geom = "text", x = 31.5, y = 0.5, label = "EOT", size = 7, colour = "red") +
      geom_text(aes(x = 51.5, y = -0.45, label = "EECO"), angle = 90, colour = "bisque4") +
      geom_text(aes(x = 41.25, y = -0.45, label = "MECO"), angle = 90, colour = "bisque4")
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
  ltt <- list.files(paste0(pth, "LTT/"), pattern = "_ltt.txt")
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

ggsave("./figures/Figure_2/Figure2_extended.png",
       plot = fig2,
       height = 500,
       width = 600,
       units = "mm",
       dpi = 300)

ggsave("./figures/Figure_2/Figure2_extended.pdf",
       plot = fig2,
       height = 500,
       width = 600,
       units = "mm")

