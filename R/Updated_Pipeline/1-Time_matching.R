################################################################################
# Name: 1-Time_matching.R
# Author: Lucas Buffan
# Date: 2023-12-11
# Aim: Script for occurrence preprocessing and time matching to their
# corresponding stage
################################################################################

library(dplyr)
library(palaeoverse)
source("./R/useful/1b_Matching_functions.R")

## A bit of preprocessing ------------------------------------------------------
raw <- read.csv("./data_2023/SPECIES_LISTS/1-Raw_Cnz_SA_Mammals.csv", na.strings = "")
L1 <- nrow(raw)
  #exclude marine taxa
raw <- raw %>% filter(!((order %in% c("Cetacea", "Sirenia")) | 
                          (family %in% c("Phocidae", "Otariidae"))))
message(paste0("Discarded ", (L1-nrow(raw)), " marine occurrences."))
  #exclude occurrences with age range >= 20My
range <- sapply(X = 1:nrow(raw), FUN = function(x){return((raw$max_ma[x]-raw$min_ma[x]))})
raw <- raw[-which(range >= 20),]
  #assign a period and an epoch to the occurrences
cnz_periods <- time_bins(interval = "Cenozoic", rank = "period")
cnz_epochs <- time_bins(interval = "Cenozoic", rank = "epoch")
binning_period <- bin_time(occdf = data.frame(max_ma = raw$max_ma,
                                              min_ma = raw$min_ma),
                           bins = cnz_periods,
                           method = "majority")
binning_epochs <- bin_time(occdf = data.frame(max_ma = raw$max_ma,
                                              min_ma = raw$min_ma),
                           bins = cnz_epochs,
                           method = "majority")
raw$period <- sapply(X = binning_period$bin_assignment,
                     FUN = function(x){return(cnz_periods$interval_name[which(cnz_periods$bin == x)])})
raw$epoch <- sapply(X = binning_epochs$bin_assignment,
                     FUN = function(x){return(cnz_epochs$interval_name[which(cnz_epochs$bin == x)])})
raw$stage <- NA

## Matching with Tarquini et al. (2022) ----------------------------------------
tarq <- read.csv("../../Tarquini_etal_2022_SI/Full_table_Tarquini_etal_2022.csv")
  #Separate species names with an underscore (to fit with Tarq)
raw$accepted_name <- sapply(X = raw$accepted_name,
                            FUN = underscore)
  #Add "locality" and "formation" columns to our dataset
raw[, c("locality", "formation")] <- NA
  #Add publication year
raw$pub_year <- sapply(X = raw$primary_reference, FUN = process_ref)
    #Proper matching
ctr <- 0
for(i in 1:nrow(tarq)){
  in_our_ds <- which((raw$accepted_name == tarq$Taxon_name[i]) & #same name
                       (raw$cc == tarq$Co[i]) & #same country
                       (raw$state == tarq$State[i]) & #same state
                       (raw$pub_year == process_ref(tarq$Reference[i]))) #same reference year
  if(length(in_our_ds) > 0){
    raw[in_our_ds, c("min_ma", "max_ma", "locality", "formation", "stage")] <- tarq[i, c("MinAge", "MaxAge", "Locality", "Formation..mb.", "Age")]
    ctr <- ctr + 1
  }
}
message(paste0("Found ", ctr, " occurrences in common with Tarquini et al. (2022) published data."))

## Match the rest with boundaries of the given early/late intervals ------------
unmatched <- which(is.na(raw$stage)) #if the `stage` column hasn't been filled, the row hasn't been matched. We therefore look for columns with similar features that have been matched
#add early-late age to stage column, for those who are not in Tarquini's ds
for(remaining in unmatched){ #not in Tarquini, according to our criteria
  raw$locality[remaining] <- raw$county[remaining]
  if(is.na(raw$late_interval[remaining]) == FALSE){
    raw$stage[remaining] <- paste(raw$early_interval[remaining],
                                  raw$late_interval[remaining],
                                  sep = "-")
  }
  else{
    raw$stage[remaining] <- raw$early_interval[remaining]
  }
}
  #stage adjustment
raw$stage[which(raw$stage == "Recent")] <- "Holocene"
raw$stage[which(raw$stage == "Quaternary")] <- "Pleistocene-Holocene"
raw$stage[which(raw$stage %in% c("Late Pleistocene-Holocene", "Late Pleistocene - Holocene"))] <- "Late Pleistocene-Late Holocene"
raw$stage[which(raw$stage == "Pliocene-Middle Pleistocene")] <- "Early Pliocene-Middle Pleistocene"
raw$stage[which(raw$stage == "middle Pliocene")] <- "Middle Pliocene"
raw$stage[which(raw$stage == "Montehermosoan")] <- "Montehermosan"
raw$stage[which(raw$stage == "Chapadmalalan")] <- "Chapadmalan"
raw$stage[which(raw$stage == "Chapadmalalan-Ensenadan")] <- "Chapadmalan-Ensenadan"
raw$stage[which(raw$stage == "lower “Huayquerian”")] <- "Huayquerian"
raw$stage[which(raw$stage == "upper “Huayquerian”")] <- "Huayquerian"
raw$stage[which(raw$stage == "Divisaderan")] <- "Middle Eocene"
raw$stage[which(raw$stage == "Casamayoran")] <- "Middle Eocene"
raw$stage[which(raw$stage == "Ypresian - Lutetian")] <- "Ypresian-Lutetian"
raw$stage[which(raw$stage == "Ensenadan - Lujanian")] <- "Ensenadan-Lujanian"
raw$stage[which(raw$stage == "Danian - Selandian")] <- "Danian-Selandian"
raw$stage[which(raw$stage == "Casamayoran")] <- "Riochan-Barrancan"
raw$stage[which(raw$stage == "Casamayoran-Mustersan")] <- "Riochan-Mustersan"
raw$stage[which(raw$stage == "Tinguirirican - Deseadan")] <- "Tinguirirican-Deseadan"
raw$stage[which(raw$stage %in% c("Montehermosan - Chapadmalalan", "Montehermosan-Chapadmalalan"))] <- "Montehermosan-Chapadmalan"
raw$stage[which(raw$stage == "Middle - Late Miocene")] <- "Middle Miocene-Late Miocene"
raw$stage[which(raw$stage == "Late Pleistocene-Holocene")] <- "Late Pleistocene-Holocene"
raw$stage[which(raw$stage == "Huayquerian - Chapadmalalan")] <- "Huayquerian-Chapadmalan"
raw$stage[which(raw$stage == "Late Pleistocene - Early Holocene")] <- "Late Pleistocene-Early Holocene"
raw$stage[which(raw$stage == "Middle Pleistocene - Late Holocene")] <- "Middle Pleistocene-Late Holocene"
raw$stage[which(raw$stage == "Late Miocene-Early Pliocene")] <- "Late Miocene-Early Pliocene"
raw$stage[which(raw$stage == "Riochan-Mustersan")] <- "Riochican-Mustersan"
raw$stage[which(raw$stage == "Ensenadan -  Lujanian")] <- "Ensenadan-Lujanian"
raw$stage[which(raw$stage == "Priabonian - Rupelian")] <- "Priabonian-Rupelian"
raw$stage[which(raw$stage == "Bonaerian - Ensenadan")] <- "Bonaerian-Ensenadan"
raw$stage[which(raw$stage == "Bonaerian - Lujanian")] <- "Bonaerian-Lujanian"
raw$stage[which(raw$stage %in% c("Barran", "Vorohuean", "Sanandresian", "Vorohuean - Sanandresian"))] <- "Marplatan"
  #time bins
SALMA <- read_xlsx('./data_2023/time_bins/SALMA.xlsx')
sub_epochs <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
ICC <- time_bins("Cenozoic")
  #hybrid time bins dataset
bins <- rbind.data.frame(SALMA[, c("interval_name", "min_ma", "max_ma")],
                         ICC[, c("interval_name", "min_ma", "max_ma")],
                         sub_epochs)
bins <- bins %>% add_row(interval_name = c("Holocene", "Pleistocene", "Pliocene", "Miocene", "Oligocene"),
                         min_ma = c(0, 0.0117, 2.58, 5.33, 23.03),
                         max_ma = c(0.0117, 2.58, 5.33, 23.03, 33.9))
  #match
for(idx in unmatched){
  stage <- raw$stage[idx]
  hyph_spl <- strsplit(stage, split = "-")[[1]]
  if(length(hyph_spl) > 1){ #necessarily equal to two, "Int1-Int2" with Int1 older than Int2
    #get ref age boundaries
    ref_min <- bins$min_ma[which(bins$interval_name == hyph_spl[2])]
    ref_max <- bins$max_ma[which(bins$interval_name == hyph_spl[1])]
  }
  else{
    ref_min <- bins$min_ma[which(bins$interval_name == stage)]
    ref_max <- bins$max_ma[which(bins$interval_name == stage)]
  }
  #Check
  # if((length(ref_min) == 0) | (length(ref_max) == 0)){
  #   print(stage)
  #   next
  # }
  #assign age limits
  if(ref_max < raw$max_ma[idx]){
    raw$max_ma[idx] <- ref_max
  }
  if(ref_min > raw$min_ma[idx]){
    raw$min_ma[idx] <- ref_min
  }
}

## Save ------------------------------------------------------------------------
saveRDS(raw, "./data_2023/SPECIES_LISTS/2-Matched_Uncleaned_Cnz_SA_Mammals.RDS")
