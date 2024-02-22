################################################################################
# Name: 5-Figure3.R
# Author: Lucas Buffan
# Aim: Script for figure 3 (multiple LTT plot).
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("hash")
library("tidyverse")
library("ggpubr")

## Generate plotting dataframe -------------------------------------------------
dir <- "./results/SALMA_smoothed/genus_level/5-Ecomorphotype/"
plt_dataframe <- data.frame(Age = NA,
                            Diversity = NA,
                            min_Diversity = NA,
                            max_Diversity = NA,
                            Diet = NA)

for(ecm in c("carnivore", "herbivore", "omnivore", "insectivore")){
  ltt_tbl <- extract_ltt(paste0(dir, "/", ecm, "/LTT/per_replicate/"))
  ltt_tbl <- ltt_tbl %>%
    filter(Age > 24 & Age < 52) %>%
    add_column(Diet = ecm)
  plt_dataframe <- rbind.data.frame(plt_dataframe, ltt_tbl)
}
plt_dataframe <- plt_dataframe[-c(1),] #remove initialising row

## Actual plot -----------------------------------------------------------------
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")


ggplot(data = plt_dataframe, aes(x = Age, y = Diversity, colour = Diet)) +
  scale_x_reverse(breaks = seq(25, 50, 5), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0,(round(max(plt_dataframe$Diversity), -1) + 10),20),
                     limits = c(0,(round(max(plt_dataframe$Diversity), -1) + 20)),
                     expand = c(0, 0)) +
  # Time interval bands
  annotate(geom = "rect", xmin = 37.71, xmax = 47.8, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 27.8, xmax = 33.9, colour = "grey95", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  # Climate optima bands
  annotate(geom = "rect", xmin = 51, xmax = Inf, ymin = -Inf, ymax = Inf, fill = "bisque") +
  annotate(geom = "rect", xmin = 41, xmax = 41.5, ymin = -Inf, ymax = Inf, fill = "bisque") +
  # Lines
  geom_line(aes(x = Age, y = Diversity, color = Diet), linewidth = 1) +
  # Line colours
  scale_colour_manual(values = c("#de2d26", "#31a354", "#756bb1", "#2b8cbe")) +
  # Ribbons
  geom_ribbon(aes(x = Age, ymin = min_Diversity, ymax = max_Diversity, fill = Diet),
              alpha = 0.5, colour = NA) +
  # Ribbon colours
  scale_fill_manual(values = c("#de2d26", "#31a354", "#756bb1", "#2b8cbe")) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31.5, y = 85, label = "EOT", size = 7, colour = "red") +
  # Theme
  theme(axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        axis.text = element_text(size = 12),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.25)) +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, "epochs"),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1, "line"),
            size = 4,
            clip = "off")

