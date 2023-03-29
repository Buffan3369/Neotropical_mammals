################################################################################
##################### Detecting absurd temporal assignations ###################
################################################################################
library(readxl)

source("./0-options.R")
occdf <- read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/species_list.xlsx")
## GABI ------------------------------------------------------------------------
  # Match migrant max time with beginning of Pleistocene (can't be arrived before)
for(migrant in params$migrants){
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

