################################################################################
# Goal: Table recap
# Authors: Lucas Buffan
# Contact: Lucas.L.Buffan@gmail.com
# Description :
#   args[1] => table we want to recap
#   args[2] => taxonomic reference table
#   args[3] => path to where we want to store the recap table
################################################################################

library(dplyr)
library(readxl)

args <- commandArgs(trailingOnly=TRUE)

#tbl <- read.table(args[1], header = TRUE, sep = "\t")
tbl <- read.table("./data_2023/PyRate/cleaning_21-06/Eocene_Oligocene/Species_level/entire/full_EOT_species.txt", header = TRUE, sep = "\t")
ref_tax <- read_xlsx("../../DATA/Cnz_Mammals_UpdatedList.xlsx")
## Highlight different orders --------------------------------------------------
assign_odr <-function(sp){
  if(sp %in% ref_tax$accepted_name){
    return(unique(ref_tax$order[which(ref_tax$accepted_name == sp)]))
  }
  else{
    spl <- strsplit(sp, split = "_")[[1]]
    if(spl[1] %in% ref_tax$genus){
      return(unique(ref_tax$order[which(ref_tax$genus == spl[1])]))
    }
    else if(spl[2] %in% ref_tax$genus){
      return(unique(ref_tax$order[which(ref_tax$genus == spl[1])]))
    }
  }
}
all_odr <- unlist(lapply(X = tbl$Species,
                         FUN = assign_odr))
tbl$order <- all_odr
all_odr <- unique(all_odr)
all_odr <- all_odr[which(is.na(all_odr) == F)]
## Loop across them ------------------------------------------------------------
n_occ <- c()
n_singl <- c()
for(odr in all_odr){
  tmp <- tbl[which(tbl$order == odr),]
  n_occ <- c(n_occ, nrow(tmp))
  c_df <- tmp %>% count(Species)
  n_singl <- c(n_singl, length(which(c_df$n == 1)))
}
## Add "total" row -------------------------------------------------------------
count_df <- tbl %>% count(Species)
n_occ <- c(n_occ, nrow(count_df))
n_singl <- c(n_singl, length(which(count_df$n == 1)))
all_odr <- c(all_odr, "Total")
## Save ------------------------------------------------------------------------
final_df <- data.frame(Order = all_odr,
                       occ_nb = n_occ,
                       singl_nb = n_singl)
final_df$prop_singl <- unlist(lapply(X = 1:16,
                                     FUN = function(i){
                                       return(round(n_singl[i]/n_occ[i], digits = 2))
                                     }))
