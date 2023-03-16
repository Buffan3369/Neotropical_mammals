# Homogenise taxonomic assignations in our dataset -----------------------------
library(readxl)
raw_taxo <- readxl::read_xlsx("./data_2023/raw_taxo.xlsx")
#Family
for(genus in unique(raw_taxo$Genus)){
  occ_indices <- which(raw_taxo$Genus == genus)
  fam_names <- unique(raw_taxo$Family[occ_indices])
  if((NA %in% fam_names) & (length(fam_names) == 2)){
    if(length(fam_names) == 2){
      raw_taxo$Family[occ_indices] <- fam_names[which(is.na(fam_names) == FALSE)]
    }
  }
}
#Order
for(genus in unique(raw_taxo$Genus)){
  occ_indices <- which(raw_taxo$Genus == genus)
  ord_names <- unique(raw_taxo$Order[occ_indices])
  if((NA %in% ord_names) & (length(ord_names) == 2)){
      raw_taxo$Order[occ_indices] <- ord_names[which(is.na(ord_names) == FALSE)]
  }
}
#Save
write.csv(raw_taxo, "./data_2023/homogenised_taxo.csv")