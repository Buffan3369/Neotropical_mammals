################################################################################
# Name: load_gts.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Load geological timescales used in the four main figures.
################################################################################

library(tidyverse)
library(readxl)
library(deeptime)

# GEOSCALES
# First geoscale (epochs)
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale (sub-epochs)
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
# Third geoscale (SALMA)
gsc3 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
gsc3 <- gsc3 %>% 
  rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name") %>%
  mutate(min_age = sapply(min_age, as.numeric), max_age = sapply(max_age, as.numeric))
# Restrict time range to plotting area
gsc1_bis <- gsc1 %>% filter(max_age > 23.03 & min_age < 56)
gsc1_bis$max_age[nrow(gsc1_bis)] <- 52
gsc1_bis$min_age[1] <- 24
gsc2_bis <- gsc2 %>% filter(max_age > 23.03 & min_age < 56)
gsc2_bis$max_age[nrow(gsc2_bis)] <- 52
gsc2_bis$min_age[1] <- 24
gsc3_bis <- gsc3 %>% filter(max_age > 24 & min_age < 52)
gsc3_bis$min_age[1] <- 24