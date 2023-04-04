################################################################################
####################### Raw input out of raw occurrences #######################
################################################################################
library(readxl)

species_list <- read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/species_list.xlsx")
occdf <- read.csv("./data_2023/Neotropical_Mammals_raw_2023.csv")

## Create and save PyRate raw genus-level input based on occdf -----------------
 # Write a genus-level status column ("Status" column is at the species level)
gen_level_status <- function(genus){
  rpz_status <- species_list$Status[which(species_list$Genus == genus)] #vector of the status of the genus representatives in our species list (where we stored)
  if(length(rpz_status > 0)){ #if the genus is in the dataset where we stored the genus names
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
  else{ #for 291 occurrences, belonging to 102 genera absent from our species list
    min_ma_rpz <- occdf$min_ma[which(occdf$genus == genus)]
    if(min(min_ma_rpz) > 5){ #we consider the genus to be extinct if its last occurrence is older than 5Ma
      return("extinct")
    }
    else{
      return("extant")
    }
  }
}
  #raw input (with no cleaning at all)
raw_input <- data.frame(Species = occdf$genus,
                        Status = unlist(lapply(X = occdf$genus,
                                               FUN = gen_level_status)),
                        MinT = occdf$min_ma,
                        MaxT = occdf$max_ma)
  #save
write.table(raw_input, 
            file = "./data_2023/PyRate/raw_input_9750_occ.txt",
            row.names = FALSE,
            quote = FALSE,
            sep = "\t",
            na = "")
