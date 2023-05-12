#################################################################################
################ Sub-Epoch binning of the already processed data ################
#################################################################################

library(readxl)
library(tibble)
library(palaeoverse)

## Load and custom species list ------------------------------------------------
spl <- data.frame(read_xlsx("../../DATA/order_level/matched_order_level/Full_species_list_former_SALMA.xlsx"))
  #re-create "period" column
period_bins <- time_bins(interval = "Cenozoic", rank = "period")
binning <- palaeoverse::bin_time(occdf = data.frame(max_ma = spl$max_ma,
                                                    min_ma = spl$min_ma),
                                 bins = period_bins,
                                 method = "majority")
Per <- unlist(lapply(X = binning$bin_assignment,
                     FUN = function(x){
                     return(period_bins$interval_name[which(period_bins$bin == x)])}))
spl <- spl %>% add_column(Period = Per,
                          .before = "stage")
  #re-create "epoch" column
epoch_bins <- time_bins(interval = "Cenozoic", rank = "epoch")
binning <- palaeoverse::bin_time(occdf = data.frame(max_ma = spl$max_ma,
                                                    min_ma = spl$min_ma),
                                 bins = epoch_bins,
                                 method = "majority")
Ep <- unlist(lapply(X = binning$bin_assignment,
                     FUN = function(x){
                       return(epoch_bins$interval_name[which(epoch_bins$bin == x)])}))
spl <- spl %>% add_column(Epoch = Ep,
                          .before = "stage")
rm(binning, period_bins, epoch_bins, Ep, Per)
  #Add extant genera not in our dataset
extant_mammals <- read.csv("./data_2023/extant_mammals.csv")
extant_mammals$Genus[which(extant_mammals$Genus == "PudÃº")] <- "Pudu"
absent <- extant_mammals$Genus[which(extant_mammals$Genus %in% unique(spl$genus) == FALSE)]
absent <- absent[!(absent == "Oreonax")]

for(genus in absent){
  corr_order <- extant_mammals$Order[which(extant_mammals$Genus == genus)]
  corr_family <- extant_mammals$Family[which(extant_mammals$Genus == genus)]
  spl <- spl %>% add_row(order = corr_order,
                         family = corr_family,
                         genus = genus,
                         gen_lvl_status = "extant",
                         Period = "Quaternary",
                         Epoch = "Holocene",
                         stage = "Meghalayan",
                         min_ma = 0,
                         max_ma = 0.0042,
                         primary_reference = "https://en.wikipedia.org/wiki/List_of_mammals_of_South_America")
}
rm(extant_mammals, absent, corr_family, corr_order, genus)

## Remove Xenarthrans ----------------------------------------------------------
spl <- spl[-which(spl$order %in% c("Pilosa", "Cingulata")), ]

## Bin SALMA stages at the sub-epoch level -------------------------------------
Sub_Epochs_bins <- data.frame(read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx"))
SALMA <- read_xlsx("./data_2023/time_bins/SALMA.xlsx")
  #Collapse Holocene and Pleistocene 
Sub_Epochs_bins[1,] <- c("Holocene", 0, 0.0117)
Sub_Epochs_bins[2,] <- c("Pleistocene", 0.0117, 2.58)
Sub_Epochs_bins <- Sub_Epochs_bins[-c(3:6), ]
row.names(Sub_Epochs_bins) <- 1:nrow(Sub_Epochs_bins)
  #fix weird issue
Sub_Epochs_bins$min_ma <- unlist(lapply(X = Sub_Epochs_bins$min_ma, FUN = as.numeric))
Sub_Epochs_bins$max_ma <- unlist(lapply(X = Sub_Epochs_bins$max_ma, FUN = as.numeric))
  #bin
Sub_Epochs_bins$bin <- 1:nrow(Sub_Epochs_bins)
binning <- palaeoverse::bin_time(occdf = data.frame(max_ma = SALMA$max_ma,
                                                    min_ma = SALMA$min_ma),
                                 bins = Sub_Epochs_bins,
                                 method = "majority")
SALMA_Sub_epoch <- unlist(lapply(X = binning$bin_assignment,
                                 FUN = function(x){
                                   return(Sub_Epochs_bins$interval_name[which(Sub_Epochs_bins$bin == x)])
                                 }))
SALMA <- SALMA %>% add_column(Sub_Epoch = SALMA_Sub_epoch,
                              .after = "epoch")
  #slight modifications (as the compromise found by the "majority" method is not necessarily the best one)
SALMA$Sub_Epoch[which(SALMA$interval_name == "Marplatan")] <- "Late Pliocene"

## Bin ICC stages at the sub-epoch level ---------------------------------------
ICC_stages <- palaeoverse::time_bins(interval = "Cenozoic", rank = "stage")[, c("interval_name", "min_ma", "max_ma")]
ICC_stages[1,] <- c("Holocene", 0, 0.0117)
ICC_stages[2,] <- c("Pleistocene", 0.0117, 2.58)
ICC_stages <- ICC_stages[-c(3:7), ]
row.names(ICC_stages) <- 1:nrow(ICC_stages)
  #fix weird issue
ICC_stages$min_ma <- unlist(lapply(X = ICC_stages$min_ma, FUN = as.numeric))
ICC_stages$max_ma <- unlist(lapply(X = ICC_stages$max_ma, FUN = as.numeric))
  #bin
binning <- palaeoverse::bin_time(occdf = data.frame(max_ma = ICC_stages$max_ma,
                                                    min_ma = ICC_stages$min_ma),
                                 bins = Sub_Epochs_bins,
                                 method = "majority")
ICC_stages_Sub_epoch <- unlist(lapply(X = binning$bin_assignment,
                                 FUN = function(x){
                                   return(Sub_Epochs_bins$interval_name[which(Sub_Epochs_bins$bin == x)])
                                 }))
ICC_stages <- ICC_stages %>% add_column(Sub_Epoch = ICC_stages_Sub_epoch,
                              .before = "interval_name")
rm(binning, ICC_stages_Sub_epoch, SALMA_Sub_epoch)

## Transform species list data -------------------------------------------------
  #Enlarge Pleistocene and Holocene
enlarge_pleist_hol <- function(stage){
  if(stage %in% c("Late Pleistocene", "Middle Pleistocene", "Early Pleistocene", "Upper Pleistocene", "Chibanian", "Calabrian", "Gelasian")){
    return("Pleistocene")
  }
  else if(stage %in% c("Late Holocene", "Middle Holocene", "Early Holocene", "Greenlandian", "Northgrippan", "Meghalayan")){
    return("Holocene")
  }
  else{
    return(stage)
  }
}
spl$stage <- unlist(lapply(X = spl$stage, FUN = enlarge_pleist_hol))

to_sub_epoch <- function(stage){
  hyphen_split <- strsplit(stage, split = "-")[[1]]
  if(length(hyphen_split) > 1){ #combined intervals (e.g. "Priabonian-Rupelian")
    return(stage) #wide enough, we just return the combined stage (normally already matched previously in `2-big_matching.R`)
  }
  else{
    if(stage %in% Sub_Epochs_bins$interval_name){
      return(stage) #already at the sub-epoch level
    }
    else if(stage %in% SALMA$epoch){ #i.e "Pliocene", "Miocene", "Oligocene", ...
      return(stage) #wide enough, we just return the combined stage (normally already matched previously in `2-big_matching.R`) 
    }
    else if(stage %in% SALMA$interval_name){
      return(SALMA$Sub_Epoch[which(SALMA$interval_name == stage)])
    }
    else if(stage %in% ICC_stages$interval_name){
      return(ICC_stages$Sub_Epoch[which(ICC_stages$interval_name == stage)])
    }
    else{
      warning(paste0("Unknown stage: ", stage))
      return(stage)
    }
  }
}

spl <- spl %>% add_column(Sub_epoch = unlist(lapply(X = spl$stage, FUN = to_sub_epoch)),
                          .before = "stage")

## Time matching at the sub-epoch level ----------------------------------------
matching <- function(sub_epoch){
  idx <- which(Sub_Epochs_bins$interval_name == sub_epoch)
  return(list(Sub_Epochs_bins$min_ma[idx],
              Sub_Epochs_bins$max_ma[idx]))
}
for(sub_epoch in Sub_Epochs_bins$interval_name){
  MinMax <- matching(sub_epoch = sub_epoch)
  idx_ep <- which(spl$Sub_epoch == sub_epoch)
  spl$min_ma[idx_ep] <- MinMax[[1]]
  spl$max_ma[idx_ep] <- MinMax[[2]]
}

## Save ------------------------------------------------------------------------
write.table(x = spl,
            file = "../../DATA/order_level/Sub_Epoch_Binning/full_list_SUBEPOCH_without_Xenarthra.txt",
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE,
            dec = ",")
