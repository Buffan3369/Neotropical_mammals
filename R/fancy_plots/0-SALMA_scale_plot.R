################################################################################
# Name: 0-SALMA_scale_plot.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Quick script for SALMA plotting
################################################################################

library(ggplot2)
library(dplyr)
library(deeptime)

## Load timescales -------------------------------------------------------------
SubEpochs <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
SubEpochs <- SubEpochs %>% 
  rename(name="interval_name", min_age="min_ma", max_age="max_ma")
SALMA_EOT <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
SALMA_EOT <- SALMA_EOT %>%
  rename(name="interval_name", min_age="min_ma", max_age="max_ma")

## Plot and save ---------------------------------------------------------------
p <- ggplot() +
  geom_point(aes(y = runif(1000, 23.03, 56)), x = runif(1000, 0, 1)) +
  scale_y_reverse(breaks = c(23.03, 27.82, 33.9, 37.71, 47.8, 56), limits = c(23, 56.03)) +
  coord_geo(dat = list("epochs", SubEpochs, SALMA_EOT), 
            pos = as.list(rep("left", 3)), 
            rot = list(90, 90, 0),
            size = list(10, 8, 4),
            abbrv = list(FALSE, TRUE, FALSE)) +
  theme_classic()

ggsave("./figures/Fig_S1_SALMA_scale/SALMA_scale.pdf", plot = p, width = 10, height = 30)
