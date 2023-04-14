## MATCHING TEST: XENUNGULATES

library(readxl)
library(palaeoverse)

## 1 Matching with Tarquini's expertise ----------------------------------------
  #raw data
xen <- read.table("../../DATA/raw_order_level/Xenungulata.txt", sep = "\t", header = TRUE, dec = ",", na.strings = "")
  #Tarquini et al. 2022 dataset
xen_tarq <- read_xlsx("../../DATA/raw_order_level/Xenungulata_Tarquini.xlsx")
  #substitute separator in our accepted names (from " " to "_")
underscore <- function(name){
  split <- strsplit(name, split = " ")
  return(paste0(split[[1]][1], "_", split[[1]][2]))
}
xen$accepted_name <- unlist(lapply(X = xen$accepted_name, FUN = underscore))
  #create locality and formation columns
xen$locality <- NA
xen$formation <- NA
xen$stage <- NA
  #function to process a reference
process_ref <- function(reference){
  #split according to dots to pick up the year (first numeric)
  dot_split <- strsplit(reference, split = "[.]")
  dot_split_num <- lapply(dot_split, as.numeric)[[1]]
  year_index <- which(is.na(dot_split_num) == FALSE)[1]
  year <- dot_split_num[year_index]
  return(year)
}
 #loop
for(i in 1:nrow(xen_tarq)){
  #target
  in_our_ds <- which((xen$accepted_name == xen_tarq$Taxon_name[i]) & 
                       (xen$cc == xen_tarq$Co[i]) & 
                       (xen$state == xen_tarq$State[i]) &
                       (unlist(lapply(xen$primary_reference, process_ref)) == process_ref(xen_tarq$Reference[i])))
  if(length(in_our_ds) > 0){
    #arbitrarily select one index among the possibly modifiable ones, in case more in tarq ds than ours
    index <- in_our_ds[which((is.na(xen$locality[in_our_ds])) &
                     (is.na(xen$formation[in_our_ds])) &
                     (is.na(xen$stage[in_our_ds])))[1]]
    #modify
    xen$locality[index] <- xen_tarq$Locality[i]
    xen$formation[index] <- xen_tarq$`Formation (mb)`[i]
    xen$stage[index] <- xen_tarq$Age[i]
    
    if(xen$min_ma[index] < xen_tarq$MinAge[i]){
      xen$min_ma[index] <- xen_tarq$MinAge[i]
    }
    if(xen$max_ma[index] > xen_tarq$MaxAge[i]){
      xen$max_ma[index] <- xen_tarq$MaxAge[i]
    }
    if(as.numeric(xen$min_ma[index]) > as.numeric(xen$max_ma[index])){
      xen$min_ma[index] <- xen_tarq$MinAge[i]
      xen$max_ma[index] <- xen_tarq$MaxAge[i]
    }
  }
}

#backtrace doublons by collection nb
unmatched <- which(is.na(xen$stage)) #if the `stage` column hasn't been filled, the row hasn't been matched. We therefore look for columns with similar featues that have been matched 
rescued <- c()
for(calimero in unmatched){
  dbl <- which((xen$accepted_name[-calimero] == xen$accepted_name[calimero]) & #name
                 (xen$cc[-calimero] == xen$cc[calimero]) & #country
                 (xen$state[-calimero] == xen$state[calimero]) & #state
                 (xen$primary_reference[-calimero] == xen$primary_reference[calimero]) & #ref
                 (xen$collection_no[-calimero] == xen$collection_no[calimero])) #collection number
  if(length(dbl) > 0){
    saver <- dbl[which(is.na(xen$stage[dbl]) == FALSE)][1]
    xen[calimero, c("min_ma", "max_ma", "locality", "formation", "stage")] <- xen[saver, c("min_ma", "max_ma", "locality", "formation", "stage")]
    rescued <- c(rescued, calimero)
  }
}
#add early-late age to stage column, for those who are not in Tarquini's ds
unmatched <- unmatched[!(unmatched %in% rescued)]
for(remaining in unmatched){
  xen$locality[remaining] <- xen$county[remaining]
  if(is.na(xen$late_interval[remaining]) == FALSE){
    xen$stage[remaining] <- paste(xen$early_interval[remaining],
                                  xen$late_interval[remaining],
                                  sep = "-")
  }
  else{
    xen$stage[remaining] <- xen$early_interval[remaining]
  }
}
#drop unuseful columns
xen <- xen[, !(colnames(xen) %in% c("county", "early_interval", "late_interval", "created", "modified"))]

## 2 Matching with GTS and SALMA scales -------------------------------------------------
#build time bins
gts_bins <- palaeoverse::time_bins(interval = "Cenozoic", rank = "stage") #GTS
gts_early_late <- read_xlsx("./data_2023/EarlyMidLate_epochs.xlsx") #GTS with Early/Mid/Late epochs
salma_bins <- read_xlsx("./data_2023/SALMA.xlsx") #SALMA
#matching
matching <- function(i, ds){
  #Occurrence between two stages?
  if(length(strsplit(xen$stage[i], split = "-")) == 2){ # Int1-Int2, where Int1 older than Int2
    int <- strsplit(xen$stage[i], split = "-")[[1]]
    ref_min <- ds[which(ds[, "interval_name"] == int[2]), "min_ma"]
    if(length(strsplit(int[2], split = " ")) == 2){ #e.g. "Middle-Late Paleocene": int = ["Middle", "Late Paleocene"] => strsplit(int[2], split = " ")) = ["Late", "Paleocene"]
      epoch <- strsplit(int[2], split = " ")[[1]][2]
      ref_max <- ds[which(ds[, "interval_name"] == paste(int[1], epoch, sep = " ")), "max_ma"]
    }
    else{
      ref_max <- ds[which(ds[, "interval_name"] == int[1]), "max_ma"]
    }
  }
  else{
    ref_min <- ds[which(ds[, "interval_name"] == xen$stage[i]), "min_ma"]
    ref_max <- ds[which(ds[, "interval_name"] == xen$stage[i]), "max_ma"]
  }
  #compare current boundaries to reference
  new_min <- as.numeric(xen$min_ma[i])
  new_max <- as.numeric(xen$max_ma[i])
  if(new_min < ref_min){
    new_min <- ref_min
  }
  if(new_max > ref_max){
    new_max <- ref_max
  }
  if(new_min > new_max){
    new_min <- ref_min
    new_max <- ref_max
  }
  return(c(new_min, new_max))
}

for(i in 1:nrow(xen)){
  print(i)
  if(xen$stage[i] %in% gts_bins$interval_name){
    print("gts_bins")
    new_MinMax <- matching(i, gts_bins)
  }
  else if(xen$stage[i] %in% gts_early_late$interval_name){
    print("gts_early_late")
    new_MinMax <- matching(i, gts_early_late)
  }
  else if(xen$stage[i] %in% salma_bins$interval_name){
    print("salma_bins")
    new_MinMax <- matching(i, salma_bins)
  }
  xen$min_ma[i] <- new_MinMax[1]
  xen$max_ma[i] <- new_MinMax[2]
}
