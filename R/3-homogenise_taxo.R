################################################################################
######################## Homogenise taxo in our dataset ########################
################################################################################

library(readxl)

raw_taxo <- readxl::read_xlsx("./data_2023/raw_taxo.xlsx")
## Family ----------------------------------------------------------------------
for(genus in unique(raw_taxo$Genus)){
  occ_indices <- which(raw_taxo$Genus == genus)
  fam_names <- unique(raw_taxo$Family[occ_indices])
  if((NA %in% fam_names) & (length(fam_names) == 2)){
    if(length(fam_names) == 2){
      raw_taxo$Family[occ_indices] <- fam_names[which(is.na(fam_names) == FALSE)]
    }
  }
}
## Order -----------------------------------------------------------------------
for(genus in unique(raw_taxo$Genus)){
  occ_indices <- which(raw_taxo$Genus == genus)
  ord_names <- unique(raw_taxo$Order[occ_indices])
  if((NA %in% ord_names) & (length(ord_names) == 2)){
      raw_taxo$Order[occ_indices] <- ord_names[which(is.na(ord_names) == FALSE)]
  }
}
## Clean stringged NAs ---------------------------------------------------------
na_seek_destroy <- function(vect){
  vect[which(vect == "NA")] <- ""
  return(vect)
}
clean_taxo <- apply(X = raw_taxo,
                    MARGIN = 2,
                    FUN = na_seek_destroy)

## Save ------------------------------------------------------------------------
write.csv(clean_taxo, "./data_2023/homogenised_taxo.csv", row.names = FALSE, na = "")


## Split tables from the different orders --------------------------------------
setwd("E:/Internship_ISEM/Neotropical_Mammals/DATA")
species_list <- read_xlsx("species_list_without_duplicates.xlsx")
for(order in unique(species_list$Order)){
  tmp_order <- species_list[which(species_list$Order == order), ]
  write.table(x = tmp_order,
              file = paste0("order_level/", order, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              dec = ",")
}
