################################################################################
# Name: 2b-Redating_tropical_loc.R
# Author: Lucas Buffan
# Date: 2024-06-28
# Aim: Script for redating Tropical localities of Shapaja and Contamana to Early
#     Oligocene (extending their time boundaries)
################################################################################

library(tidyverse)

spl <- readRDS("./data_2023/SPECIES_LISTS/8-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS")

shap <- paste0("Shapaja (TAR-", c(73, 20, 21), ")")
balsa <-  paste0("Balsayacu (TAR-", c(55, "55bis", 77), ")")
janj <- paste0("Janjui (TAR-", c(46, 47, 56), ")")
cta <- paste0("Contamana (CTA-", c(29, 41, 47, 50, 51, 53, 60, 66, 73), ")")

all_loc <- c(shap, balsa, janj, cta)

# target indices of the occurrences we have to change localities of
idx <- which(spl$locality %in% all_loc)

# Set ages to late Eocene - Early Oligocene
spl$min_ma[idx] <- 27.82
spl$max_ma[idx] <- 37.71

saveRDS(spl, "9-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet-CTA-TAR-Olig.RDS")
