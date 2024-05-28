################################################################################
# Name: 4b-baseline_recap_figure.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for baseline plot for recap figure biodiv/drivers (fig.4b)
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

source("./R/useful/helper_functions.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")

## Geoscales -------------------------------------------------------------------
# First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
# weird modification for plotting
gsc1_bis <- gsc1
gsc1_bis$max_age[nrow(gsc1_bis)] <- 52
gsc1_bis$min_age[1] <- 24
gsc2_bis <- gsc2 %>% filter(max_age <= 56)
gsc2_bis$max_age[nrow(gsc2_bis)] <- 52
gsc2_bis$min_age[1] <- 24


## Load and plot temperature data ----------------------------------------------
Temp_Cnz <- read.table("./data_2023/MBD/raw_environment_correlates/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                       sep = "\t",
                       header = TRUE)
t_plot <- Temp_Cnz %>% 
  filter(Age < 52 & Age > 33.9) %>%
  ggplot(aes(x = Age, y = Temperature)) +
  geom_line(colour = "#045a8d") +
  labs(y = "Average temperature (°C)") +
  scale_x_reverse() +
  scale_y_continuous(breaks = seq(15, 30, 2.5)) +
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "#045a8d"),
        axis.text = element_text(colour = "#045a8d"),
        axis.title.y = element_text(colour = "#045a8d")) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0)

ggsave("./figures/Figure_4_new/temp_plot.pdf",
       plot = t_plot,
       height = 100,
       width = 150,
       units = "mm")

## LTT plot --------------------------------------------------------------------
ltt_path <- "./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/LTT/Full_EOT_gen_occ_SALMA_smoothed_10_Grj_KEEP_se_est_ltt.txt"
ltt_tbl <- read.table(ltt_path, header = TRUE)
ltt_tbl <- ltt_tbl %>%
  rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div) %>%
  filter(Age > 24 & Age < 52)
ltt_tbl$Age[1] <- 24
ltt_tbl$Age[nrow(ltt_tbl)] <- 52
#plot
ltt.plot <- ltt_plot(ltt_tbl,
                     stage_x_breaks = FALSE,
                     manual_x_breaks = seq(25, 50, 5),
                     axes.labelsize=15,
                     ticks.labelsize = 12,
                     x_lab = "Time (Ma)",
                     y_lab = "Diversity (nb. genera)",
                     y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                     y_limits = c(40,(round(max(ltt_tbl$Diversity), -1) + 12)),
                     display_gts = TRUE,
                     xlim = c(52, 24),
                     avg_col = "#006d2c",
                     ribbon_col = "#74c476",
                     plot.border = FALSE,
                     x.axis = TRUE,
                     display_EECO_MECO = TRUE,
                     several_gts = TRUE,
                     geoscale = gsc1_bis,
                     geoscale2 = gsc2_bis,
                     geoscale_height = unit(1, "line"),
                     geoscale_labelsize = 4,
                     abbr = list(TRUE, FALSE)) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0)

ggsave("./figures/Figure_4_new/LTT_plot.pdf",
       plot = ltt.plot,
       height = 150,
       width = 150,
       units = "mm")
