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

saveRDS(spl, "./data_2023/SPECIES_LISTS/9-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet-CTA-TAR-Olig.RDS")

## Prepare Pyrate input --------------------------------------------------------
source("~/PyRate/pyrate_utilities.r")
source("./R/useful/helper_functions.R")
# Write and save occdf
gen_lvl <- spl %>%
  select(genus, gen_lvl_status, min_ma, max_ma) %>%
  rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
write.table.lucas(x = gen_lvl,
                  file = "./data_2023/PyRate/EXTENDED/SALMA_smoothed/genus_level/1-Full/Full_extended_TAR_CTA_redated.txt")
# Extract ages
extract.ages("./data_2023/PyRate/EXTENDED/SALMA_smoothed/genus_level/1-Full/Full_extended_TAR_CTA_redated.txt",
             replicates = 20)
