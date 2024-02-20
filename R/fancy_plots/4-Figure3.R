################################################################################
# Name: 3b-Figure2.R
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
                            Diet = NA,
                            line_col = NA,
                            rib_col = NA)

line_col_dict <- hash("carnivore" = "#99000d",
                      "herbivore" = "#016c59",
                      "omnivore" = "#543005",
                      "insectivore" = "#4a1486")

rib_col_dict <- hash("carnivore" = "#fb6a4a",
                      "herbivore" = "#67a9cf",
                      "omnivore" = "#dfc27d",
                      "insectivore" = "#f768a1")


for(ecm in c("carnivore", "herbivore", "omnivore", "insectivore")){
  ltt_tbl <- extract_ltt(paste0(dir, "/", ecm, "/LTT/per_replicate/"))
  ltt_tbl <- ltt_tbl %>% add_column(Diet = rep(ecm, nrow(ltt_tbl)),
                                    line_col = rep(as.character(values(line_col_dict[ecm]))),
                                    rib_col = rep(as.character(values(rib_col_dict[ecm]))))
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
  geom_ribbon(aes(x = Age, ymin = min_Diversity, ymax = max_Diversity, fill = rib_col),
              alpha = 0.8) +
  geom_line(aes(x = Age, y = Diversity, color = line_col), linewidth = 1)
