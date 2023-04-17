## TEMPORAL CORRECTIONS OF THE RAW DATA ##

library(readxl)
library(palaeoverse)
library(stringr)

#Time bins for matching
gts_stage_bins <- palaeoverse::time_bins(interval = "Cenozoic", rank = "stage") #GTS stages
gts_early_late <- data.frame(read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")) #GTS with Early/Mid/Late epochs
gts_epoch_bins <- palaeoverse::time_bins(interval = "Cenozoic", rank = "epoch") #GTS epochs
salma_bins <- data.frame(read_xlsx("./data_2023/time_bins/SALMA.xlsx")) #SALMA

#Accessory functions
source("./R/matching_functions.R")

#Matching loop for all orders
for(file in list.files("../../DATA/raw/order_level/")){
  order <- stringr::str_remove(file, pattern = ".xlsx")
  print(order)
  file <- list.files("../../DATA/raw/order_level/")[1]
  ## 1 Matching with Tarquini's expertise ----------------------------------------
  #raw data
  raw <- read_xlsx(paste0("../../DATA/raw/order_level/", file))
  #Tarquini et al. 2022 dataset
  tarq <- read_xlsx(paste0("../../Tarquini_etal_2022_SI/Order_level/", file))
  #change names in raw dataset for matching with Tarquini
  sp_rank <- which(raw$accepted_rank == "species")
  raw$accepted_name[sp_rank] <- unlist(lapply(X = raw$accepted_name[sp_rank], FUN = underscore))
  #create locality and formation columns
  raw$locality <- NA
  raw$formation <- NA
  raw$stage <- NA
  #Assigning occurrences in our ds to some in Tarquini's dataset
  for(i in 1:nrow(tarq)){
    #target
    in_our_ds <- which((raw$accepted_name == tarq$Taxon_name[i]) & 
                         (raw$cc == tarq$Co[i]) & 
                         (raw$state == tarq$State[i]) &
                         (unlist(lapply(raw$primary_reference, process_ref)) == process_ref(tarq$Reference[i])))
    if(length(in_our_ds) > 0){
      #arbitrarily select one index among the possibly modifiable ones, in case more in tarq ds than ours
      index <- in_our_ds[which((is.na(raw$locality[in_our_ds])) &
                                 (is.na(raw$formation[in_our_ds])) &
                                 (is.na(raw$stage[in_our_ds])))[1]]
      if(is.na(index) == FALSE){
        #modify
        raw$locality[index] <- tarq$Locality[i]
        raw$formation[index] <- tarq$`Formation (mb)`[i]
        raw$stage[index] <- tarq$Age[i]
        
        if(raw$min_ma[index] < tarq$MinAge[i]){
          raw$min_ma[index] <- tarq$MinAge[i]
        }
        if(raw$max_ma[index] > tarq$MaxAge[i]){
          raw$max_ma[index] <- tarq$MaxAge[i]
        }
        if(as.numeric(raw$min_ma[index]) > as.numeric(raw$max_ma[index])){
          raw$min_ma[index] <- tarq$MinAge[i]
          raw$max_ma[index] <- tarq$MaxAge[i]
        }
      }
    }
  }
  #add early-late age to stage column, for those who are not in Tarquini's ds
  unmatched <- which(is.na(raw$stage)) #if the `stage` column hasn't been filled, the row hasn't been matched. We therefore look for columns with similar features that have been matched 
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
  #drop unuseful columns
  raw <- raw[, !(colnames(raw) %in% c("county", "early_interval", "late_interval", "created", "modified"))]
  #Set to "Holocene" all rows with stage "Recent"
  raw$stage[which(raw$stage == "Recent")] <- "Holocene"
  raw$stage[which(raw$stage == "Quaternary")] <- "Pleistocene-Holocene"
  raw$stage[which(raw$stage == "Late Pleistocene-Holocene")] <- "Late Pleistocene-Late Holocene"
  raw$stage[which(raw$stage == "Pliocene-Middle Pleistocene")] <- "Early Pliocene-Middle Pleistocene"
  
  ## 2 Matching with GTS and SALMA scales -------------------------------------------------
  for(i in 1:nrow(raw)){
    #print(i)
    hyphen_split <- strsplit(raw$stage[i], split = "-")[[1]] #split according to hyphen, otherwise mixed intervals (e.g. "Danian-Selandian") won't be recognised
    if(no_blank(hyphen_split[length(hyphen_split)]) %in% gts_stage_bins$interval_name){
      # print("gts_stage_bins")
      new_MinMax <- matching(i, time_ds=gts_stage_bins, match_ds=raw)
    }
    else if(no_blank(hyphen_split[length(hyphen_split)]) %in% gts_early_late$interval_name){
      #print("gts_early_late")
      new_MinMax <- matching(i, time_ds=gts_early_late, match_ds=raw)
    }
    else if(no_blank(hyphen_split[length(hyphen_split)]) %in% gts_epoch_bins$interval_name){
      #print("gts_epoch_bins")
      new_MinMax <- matching(i, time_ds=gts_epoch_bins, match_ds=raw)
    }
    else if(no_blank(hyphen_split[length(hyphen_split)]) %in% salma_bins$interval_name){
      #print("salma_bins")
      new_MinMax <- matching(i, time_ds=salma_bins, match_ds=raw)
    }
    else{
      print(i)
      print(paste0("Unknown interval: ", raw$stage[i]))
      new_MinMax[1] <- raw$min_ma[i]
      new_MinMax[2] <- raw$max_ma[i]  
    }
    raw$min_ma[i] <- new_MinMax[1]
    raw$max_ma[i] <- new_MinMax[2]
  }
  write.table(x = raw,
              file = paste0("../../DATA/order_level/matched_order_level/", order, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              dec = ",")
}

