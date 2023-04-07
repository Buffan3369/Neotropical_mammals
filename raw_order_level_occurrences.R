###### Order-level split from raw dataset ######
library(readxl)
library(hash)
raw_2023 <- read.csv("./data_2023/Neotropical_Mammals_raw_2023.csv") 
#remove occurrences out of time coverage
too_old <- which(raw_2023$min_ma >= 66)
raw_2023 <- raw_2023[-too_old, ]
#remove genera introduced by or extinct because of humans
raw_2023 <- raw_2023[-which(raw_2023$genus %in% c("Lepus", "Neomonachus", "Mus", "Sus")),]
#correct typos
dict_typo_corr <- hash(keys = c("Epieuryceros", "Bolomys", "Pithiculites", "Glossotheridium", "Plesioxotodon", "Hippidium"), #in raw dataset
                       values = c("Epieurycerus", "Necromys", "Pitheculites", "Glossotherium", "Plesiotoxodon", "Hippidion")) #corrected names
for(key in keys(dict_typo_corr)){
  raw_2023$genus[which(raw_2023$genus == key)] <- dict_typo_corr[[key]]
}
#remove unuseful columns
cols_to_drop <- c("occurrence_no","record_type","reid_no","flags","identified_name","identified_rank","identified_no","difference",
                  "accepted_no","reference_no","phylum","class","latlng_basis","latlng_precision","geogscale","geogcomments",
                  "enterer","modifier")
raw_2023 <- raw_2023[, !(names(raw_2023) %in% cols_to_drop)]
#write and save order-level lists
for(order in unique(raw_2023$order)){
  tmp_order <- raw_2023[which(raw_2023$order == order), ]
  #save order-level table
  write.table(x = tmp_order,
              file = paste0("E:/Internship_ISEM/Neotropical_Mammals/DATA/raw_order_level/", order, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              dec = ",")
}