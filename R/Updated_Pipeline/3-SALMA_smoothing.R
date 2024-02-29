################################################################################
# Name: 3-SALMA_smoothing.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: 'Smooth' SALMAs => match boundaries of the occurrences 
#   associated to a SALMA with those of their corresponding sub-epoch
################################################################################

library(readxl)
library(tidyverse)
library(palaeoverse)

## Load data -------------------------------------------------------------------
SubEpochs <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
SubEpochs$bin <- 1:nrow(SubEpochs) #add 'bin' columns for `bin_time`
SALMA_EOT <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
species_list <- readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
species_list_ext <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
SPLs <- list(species_list, species_list_ext)
rm(species_list, species_list_ext)

## Bin SALMAs with the Sub-Epochs they most overlap with -----------------------
binning <- palaeoverse::bin_time(occdf = data.frame(max_ma = SALMA_EOT$max_ma,
                                                    min_ma = SALMA_EOT$min_ma),
                                 bins = SubEpochs,
                                 method = "majority")
SALMA_EOT_Sub_epoch <- sapply(X = binning$bin_assignment,
                              FUN = function(x){
                                return(SubEpochs$interval_name[which(SubEpochs$bin == x)])
                              })
SALMA_EOT <- SALMA_EOT %>% add_column(Sub_Epoch = SALMA_EOT_Sub_epoch,
                                      .after = "epoch")

## Function for stage name processing ------------------------------------------
split_stage <- function(stage, early=TRUE){
  hyphen_split <- strsplit(stage, split = "-")[[1]]
  if(early == TRUE){
    return(hyphen_split[1])
  }
  else{
    if(length(hyphen_split) > 1){
      return(hyphen_split[2]) 
    }
    else{
      return(NA)
    }
  }
}

## Function to get the age boundaries (min or max) of a stage given its name ---
get_ref <- function(stage, Which=c("min", "max")){
  #get the ref age
  hyp_split <- strsplit(stage, split = "-")[[1]]
  if(length(hyp_split) > 1){
    corr_early <- SALMA_EOT$Sub_Epoch[which(SALMA_EOT$interval_name == hyp_split[1])]
    corr_late <- SALMA_EOT$Sub_Epoch[which(SALMA_EOT$interval_name == hyp_split[2])]
    ref_max <- SubEpochs$max_ma[which(SubEpochs$interval_name == corr_early)]
    ref_min <- SubEpochs$min_ma[which(SubEpochs$interval_name == corr_late)]
  }
  else{
    corr <- SALMA_EOT$Sub_Epoch[which(SALMA_EOT$interval_name == stage)]
    ref_max <- SubEpochs$max_ma[which(SubEpochs$interval_name == corr)]
    ref_min <- SubEpochs$min_ma[which(SubEpochs$interval_name == corr)]
  }
  #return
  if(Which == "min"){
    return(ref_min)
  }
  else{
    return(ref_max)
  }
}

## Loop across the two datasets ------------------------------------------------
i <- 1
for(chosen_list in SPLs){
  if(i == 1){
    final_name <- "6-Fully_cleaned_EOT_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS"
  }
  else if(i == 2){
    final_name <- "8-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS"
  }
  ## Subset occ associated to a SALMA --------------------------------------------
  #(Re)create Early/Late stage column
  chosen_list <- chosen_list %>% add_column(Early_stage = sapply(X = chosen_list$stage,
                                                                 FUN = split_stage),
                                            Late_stage = sapply(X = chosen_list$stage,
                                                                FUN = split_stage,
                                                                early = FALSE),
                                            .after = "stage")
  #Split SALMA-associated occurrences
  spl_EOT <- chosen_list %>% filter(Early_stage %in% SALMA_EOT$interval_name)
  cat("A total of", nrow(spl_EOT), "occurrences (representing",
      round( (nrow(spl_EOT) / nrow(chosen_list)), digits = 2 )*100,
      "% of the total) are associated to a SALMA.\n")
  #Change age boundaries of SALMA-associated occurrences 
  spl_EOT$min_ma <- sapply(X = spl_EOT$stage, FUN = get_ref, Which = "min")
  spl_EOT$max_ma <- sapply(X = spl_EOT$stage, FUN = get_ref, Which = "max")
  
  ## Merge the two datasets (SALMA/not_SALMA) and save ---------------------------
  spl_not_EOT <- chosen_list %>% filter(Early_stage %in% SALMA_EOT$interval_name == FALSE)
  spl <- rbind.data.frame(spl_not_EOT, spl_EOT)
  spl <- data.frame(spl)
  spl <- spl %>% 
    select(-c(Early_stage, Late_stage)) %>% 
    arrange(order, family, genus, accepted_name, cc)
  spl$min_ma <- as.numeric(spl$min_ma) #for some reason, the "min_ma" column turned into a list...
  spl$min_ma[which(spl$genus == "tegotherium")] <- 47.8 #unbinned otherwise
  saveRDS(spl, paste0("./data_2023/SPECIES_LISTS/", final_name))
  i <- i + 1
}

