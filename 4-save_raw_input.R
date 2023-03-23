################################################################################
####################### Raw input out of raw occurrences #######################
################################################################################
library(readxl)

occdf <- read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/species_list.xlsx")
## Create and save PyRate raw genus-level input based on occdf -----------------
 # Write a genus-level status column ("Status" column is at the species level)
gen_level_status <- function(genus){
  rpz_status <- occdf$Status[which(occdf$Genus == genus)] #vector of the status of the genus representatives in occdf
  if("extant" %in% rpz_status){
    return("extant")
  }
  else if( ("extant" %in% rpz_status == FALSE) & ("extinct" %in% rpz_status) ){ #rpz_status = c("extinct", ....) or c("extinct", ..., NA, ...)
    return("extinct")
  }
  else{ #rpz_status = c(NA, ....) => means species-level occurrences we couldn't associate a status to as genus extant but species unspecified, hence we don't know if extinct or extant
    return("extant")
  }
}
  #raw input (with minimal cleaning)
raw_input <- data.frame(Species = occdf$Genus,
                        Status = unlist(lapply(X = occdf$Genus,
                                               FUN = gen_level_status)),
                        MinT = occdf$`Min age`,
                        MaxT = occdf$`Max age`)
  #save
write.table(raw_input, 
            file = "./data_2023/PyRate/raw_input_9478_occ.txt",
            row.names = FALSE,
            quote = FALSE,
            sep = "\t",
            na = "")