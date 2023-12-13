################################################################################
# Name: 4-PyRate_Inputs.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: Generate PyRate inputs for EOT data.
################################################################################

## Accessory functions ---------------------------------------------------------
source("../../pyrate_utilities.R")
source("./R/Updated_Pipeline/4b-Spatial_subsampling.R")

## SALMA kept ------------------------------------------------------------------
occdf <- readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
