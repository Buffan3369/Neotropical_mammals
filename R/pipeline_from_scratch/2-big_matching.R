#################################################################################
#################### Proper stage binning of the raw data #######################
#################################################################################

library(readxl)
library(palaeoverse)
library(stringr)

#Time bins for matching
gts_stage_bins <- palaeoverse::time_bins(interval = "Cenozoic", rank = "stage") #GTS stages
gts_early_late <- data.frame(read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")) #GTS with Early/Mid/Late epochs
gts_epoch_bins <- palaeoverse::time_bins(interval = "Cenozoic", rank = "epoch") #GTS epochs
salma_bins <- data.frame(read_xlsx("./data_2023/time_bins/SALMA.xlsx")) #SALMA

#Accessory functions
source("./R/pipeline_from_scratch/2b-matching_functions.R")

#Matching loop for all orders
for(file in list.files("../../DATA/raw/order_level/")){
  order <- stringr::str_remove(file, pattern = ".xlsx")
  print(order)
  ## 1 Matching with Tarquini's expertise (for all but Primates) ----------------------------------------
  #raw data
  raw <- read_xlsx(paste0("../../DATA/raw/order_level/", file))
  #create locality and formation columns
  raw$locality <- NA
  raw$formation <- NA
  raw$stage <- NA
  #change name separator in raw dataset for matching with Tarquini
  sp_rank <- which(raw$accepted_rank == "species")
  raw$accepted_name[sp_rank] <- unlist(lapply(X = raw$accepted_name[sp_rank], FUN = underscore))
  #All but Primates (not in Tarquini's data)
  if((order %in% c("Primates", "Cetacea", "Others")) == FALSE){
    #Tarquini et al. 2022 dataset
    tarq <- read_xlsx(paste0("../../Tarquini_etal_2022_SI/Order_level/", file))
    #loop
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
  }
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
  #drop unuseful columns
  raw <- raw[, !(colnames(raw) %in% c("county", "early_interval", "late_interval", "created", "modified"))]
  #Period adjustment
  raw$stage[which(raw$stage == "Recent")] <- "Holocene"
  raw$stage[which(raw$stage == "Quaternary")] <- "Pleistocene-Holocene"
  raw$stage[which(raw$stage %in% c("Late Pleistocene-Holocene", "Late Pleistocene - Holocene"))] <- "Late Pleistocene-Late Holocene"
  raw$stage[which(raw$stage == "Pliocene-Middle Pleistocene")] <- "Early Pliocene-Middle Pleistocene"
  raw$stage[which(raw$stage == "lower “Huayquerian”")] <- "Huayquerian"
  raw$stage[which(raw$stage == "upper “Huayquerian”")] <- "Huayquerian"
  raw$stage[which(raw$stage == "Divisaderan")] <- "Middle Eocene"
  raw$stage[which(raw$stage == "Casamayoran")] <- "Middle Eocene"
  raw$stage[which(raw$stage %in% c("Barran", "Vorohuean", "Sanandresian", "Vorohuean - Sanandresian"))] <- "Marplatan"
  ## 2 Matching with GTS and SALMA scales ---------------------------------------------------------------
  #Big matching
  for(i in 1:nrow(raw)){
    #print(i)
    hyphen_split <- strsplit(raw$stage[i], split = "-")[[1]] #split according to hyphen, otherwise mixed intervals (e.g. "Danian-Selandian") won't be recognised
    if(length(hyphen_split) == 1){ #single stage specified
      new_MinMax <- matching(i, match_ds = raw, combined_stages = FALSE)
    }
    else if(length(hyphen_split) == 2){ #combined stages
      new_MinMax <- matching(i, match_ds = raw, combined_stages = TRUE)
    }
    raw$min_ma[i] <- new_MinMax[[1]]
    raw$max_ma[i] <- new_MinMax[[2]]
  }
  #Backtracing La Venta and Salla age boundaries (based on Mora-Rojas et al. 2023)
  for(idx in which(raw$state %in% c("Huila", "La Paz"))){
    MinMax <- VentaSalla(idx, match_ds = raw)
    raw$min_ma[idx] <- MinMax[[1]]
    raw$max_ma[idx] <- MinMax[[2]]
  }
  ## 3-Reorganising columns ----------------------------------------------------------------------------
  #reorder columns
  raw$status <- NA
  raw <- raw[, c("order", "family", "genus", "accepted_name", "status", "cc", "state", "locality",
                 "formation", "stage", "min_ma", "max_ma", "collection_no", "authorizer", "primary_reference")]
  #adjust families
  raw$family[which(raw$family == "NO_FAMILY_SPECIFIED")] <- NA
  ref_taxo <- read.table(paste0("../../DATA/order_level/from_2020_2023_data_combination/", order, ".txt"), header = TRUE, dec = ",", sep = "\t", quote = "", fill = TRUE)
  for(genus in unique(raw$genus)){
    if(genus %in% ref_taxo$Genus){
      raw$family[which(raw$genus == genus)] <- unique(ref_taxo$Family[which(ref_taxo$Genus == genus)])[1] #[1] to simplify
    }
  }
  #adjust status
  for(name in unique(raw$accepted_name)){
    spl <- strsplit(name, split = "_")[[1]]
    gen <- spl[1]
    sp <- spl[2]
    st <- unique(ref_taxo$Status[which((ref_taxo$Genus == gen) & (ref_taxo$Species == sp))])
    if(length(st) > 0){
      raw$status[which(raw$accepted_name == name)] <- st
    }
  }
  #sort based on several columns
  raw <- raw[order(raw$order, raw$family, raw$accepted_name, raw$cc, raw$locality), ]
  #all occurrence with time range above 20My are removed
  over_thr <- which((raw$max_ma - raw$min_ma) > 20)
  if(length(over_thr) > 0){
    raw <- raw[-over_thr, ]
  }
  #save
  write.table(x = raw,
              file = paste0("../../DATA/order_level/matched_order_level/", order, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              dec = ",")
}

