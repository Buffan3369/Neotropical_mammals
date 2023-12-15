################################################################################
# Name: 5-PPModelTest_treatment.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: Says which is the best between stage-level and SALMA-level TPPs for each
#   of the 4 inputs
################################################################################

library(dplyr)

for(salma in c("SALMA_kept", "SALMA_smoothed")){
  for(lvl in c("species_level", "genus_level")){
    #SALMA TPP
    recap_SALMA <- read.csv("./results/SALMA_kept/genus_level/PPmodeltest/SALMA/tab_2.tsb", sep = ";", stringsAsFactors = TRUE)
    mean_AICc_TPP_salma <- mean(recap_SALMA$TPP, na.rm = TRUE)
    #stages TPP
    recap_stages <- read.csv("./results/SALMA_kept/genus_level/PPmodeltest/stages/tab_1.tsb", sep = ";", stringsAsFactors = TRUE)
    mean_AICc_TPP_stages <- mean(recap_stages$TPP, na.rm = TRUE)
    if(mean_AICc_TPP_salma > mean_AICc_TPP_stages){
      Winner <- "stages"
    }
    else{
      Winner <- "SALMA"
    }
    cat("Retained TPP for", salma, "at the", lvl, ":", Winner)
  }
}

