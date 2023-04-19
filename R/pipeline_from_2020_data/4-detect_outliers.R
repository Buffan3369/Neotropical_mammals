################################################################################
##################### Detecting absurd temporal assignations ###################
################################################################################
library(readxl)

source("./R/0-options.R")
occdf <- read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/DATA/species_list_without_duplicates.xlsx")
## GABI ------------------------------------------------------------------------
  # Match migrant max time with beginning of Pleistocene (can't be arrived before)
for(migrant in params$migrants){
  migrant_index <- which(occdf$Family == migrant)
  #correct Max time
  disruptors_max <- which(occdf$`Max age`[migrant_index] > 2.588)
  occdf$`Max age`[migrant_index[disruptors_max]] <- 2.588
  #correct Min time (in case becomes higher than Max time, set to 0.0117)
  disruptors_min <- which(occdf$`Min age`[migrant_index] >= 2.588)
  occdf$`Min age`[migrant_index[disruptors_min]] <- 0.0117
}

#write.csv(occdf, "E:/Internship_ISEM/Neotropical_Mammals/DATA/adjusted_GABI.csv", na="", row.names=FALSE)

## Prepare an intermediate cleaning PyRate input -------------------------------
marine_idx <- which((occdf$Order %in% c("Cetacea", "Sirenia")) | (occdf$Family %in% c("Otariidae", "Phocidae", "Odobenidae")))
occdf_terrestrial <- occdf[-marine_idx,] #remove marine occurrences

gen_level_status <- function(genus){
  rpz_status <- occdf_terrestrial$Status[which(occdf_terrestrial$Genus == genus)] #vector of the status of the genus representatives in our species list
  if("extant" %in% rpz_status){
    return("extant")
  }
  else if( ("extant" %in% rpz_status == FALSE) & ("extinct" %in% rpz_status) ){ #rpz_status = c("extinct", ....) or c("extinct", ..., NA, ...)
    return("extinct")
  }
  else{ #rpz_status = c(NA, ....) => means species-level occurrences we couldn't associate a status to, as genus extant but species unspecified, hence we don't know if extinct or extant
    return("extant")
  }
}

int_clean <- data.frame(Species = occdf_terrestrial$Genus,
                        Status = unlist(lapply(X = occdf_terrestrial$Genus,
                                               FUN = gen_level_status)),
                        MinT = occdf_terrestrial$`Min age`,
                        MaxT = occdf_terrestrial$`Max age`)
write.table(int_clean, 
            file = "./data_2023/PyRate/intermediate_cleaning_05_04.txt",
            row.names = FALSE,
            quote = FALSE,
            sep = "\t",
            na = "")
