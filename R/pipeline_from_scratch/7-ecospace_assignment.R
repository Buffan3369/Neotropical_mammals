library(readxl)
library(dplyr)
library(hash)

spl <- read_xlsx("../../DATA/Cnz_Mammals_UpdatedList.xlsx")
spl <- spl[which(spl$epoch %in% c("Oligocene", "Eocene")), ]
marine_idx <- which((spl$order %in% c("Cetacea", "Sirenia")) |
(spl$family %in% c("Otariidae", "Phocidae", "Odobenidae")))
spl <- spl[-marine_idx, ]

pbdb_dat <- read.csv("C:/Users/lucas/Downloads/pbdb_data.csv")
# Simplify diet categories
diet_cat <- hash("carnivore, durophage" = "carnivore",
                 "carnivore, suspension feeder" = "carnivore",
                 "frugivore, folivore" = "herbivore",
                 "frugivore, herbivore" = "herbivore",
                 "frugivore, omnivore" = "omnivore")
for(cat in keys(diet_cat)){
  idx <- which(pbdb_dat$diet == cat)
  pbdb_dat$diet[idx] <- values(diet_cat[cat])[[1]]
}

dat2 <- pbdb_dat[, c("genus", "diet")]
dat2 <- unique(dat2)
#length(unique(pbdb_dat$genus)) == nrow(dat2) : each genus associated to a single diet

assign_diet <- function(genus){
  if(genus %in% dat2$genus){
    idx <- which(dat2$genus == genus)
    return(dat2$diet[idx])
  }
  else{
    return(NA)
  }
}
spl$diet <- unlist(lapply(X = spl$genus, FUN = assign_diet))
#modifications done after one-by-one checking of the remaining unassigned occurrences
spl$diet[which( (is.na(spl$diet)) & (spl$order %in% c("Notoungulata", "Astrapotheria")))] <- "herbivore"
spl$diet[which( (is.na(spl$diet)) & (spl$order == "Sparassodonta"))] <- "carnivore"
spl$diet[which( (is.na(spl$diet)) & (spl$order == "Rodentia"))] <- "herbivore"
spl$diet[which( (is.na(spl$diet)) & (spl$order == "Cingulata"))] <- "omnivore"
spl$diet[which( (is.na(spl$diet)) & (spl$family %in% c("Argyrolagidae",
                                                       "Polydolopidae",
                                                       "Prepidolopidae",
                                                       "Palaeothentidae")))] <- "omnivore"
spl$diet[which(spl$genus == "cf. Perulestes")] <- "insectivore"
spl$diet[which(spl$genus == "Patagonia")] <- "herbivore"

#View(spl[which(is.na(spl$diet)),])   ====>   OKAY !!

write.table(spl, "../../DATA/ecomorphotypes/species_list_ecomorphotypes.txt", na = " ", sep = ";", row.names = FALSE)
