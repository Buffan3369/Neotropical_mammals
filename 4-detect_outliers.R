################################################################################
##################### Detecting absurd temporal assignations ###################
################################################################################
library(readxl)

occdf <- read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/species_list.xlsx")
## Create and save PyRate raw genus-level input based on occdf -----------------
raw_input <- data.frame(Species = occdf$Genus,
                        Status = occdf$Status,
                        MinT = occdf$`Min age`,
                        MaxT = occdf$`Max age`)
write.table(raw_input, 
            file = "./data_2023/PyRate/raw_input_10138_occ.txt",
            row.names = FALSE,
            sep = "\t",
            na = "")

## GABI ------------------------------------------------------------------------
  # List of the migrant families from North America that arrived with GABI
migrants <- c("Equidae",
              "Rhinocerotidae",
              "Tapiridae",
              "Camelidae",
              "Tayassuidae",
              "Gomphoteriidae",
              "Elephantidae",
              "Mammutidae",
              "Mephitidae",
              "Mustelidae",
              "Canidae",
              "Felidae",
              "Procyonidae",
              "Ursidae",
              "Sciuridae",
              "Leporidae")
  # Match their max time with beginning of Pleistocene (can't be arrived before)
for(migrant in migrants){
  migrant_index <- which(occdf$Family == migrant)
  disruptors <- migrant_index[which(occdf$`Max age`[migrant_index] > 2.58)]
  occdf$`Max age`[disruptors] <- 2.58
}

## "Too" large taxa persistence ------------------------------------------------
occ_range <- function(x, thr){
  range <- occdf$`Max age`[x] - occdf$`Min age`[x]
  if(range >= thr){return(x)}
}
  # 10 Myr threshold
too_large <- unlist(lapply(X = 1:nrow(occdf),
                           FUN = occ_range,
                           thr = 10))
recent <- too_large[which(occdf$Epoch[too_large] %in% c("Miocene", "Pliocene", "Pleistocene", "Holocene"))]

