################################################################################
############################### Teporal binning ################################
################################################################################
library(palaeoverse)
library(tibble)
library(readxl)

## Generate time bins covering the whole Cenozoic + Cretaceous by Epoch -----
Cnz_Mz <- palaeoverse::time_bins(interval = c("Cenozoic","Mesozoic"),
                                       rank = "epoch")

data <- readxl::read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/species_list.xlsx")
age_range <- data.frame(max_ma = unlist(lapply(X = data$`Max age`, FUN = as.numeric)),
                        min_ma = unlist(lapply(X = data$`Min age`, FUN = as.numeric)))
binning <- bin_time(occdf = age_range,
                    bins = Cnz_Mz,
                    method = "majority")
write.csv(binning, "E:/Internship_ISEM/Neotropical_Mammals/binning.csv")




time_insconsistency <- function(x){
  if(data$`Min age` > data$`Max age`){
    return(x)
  }
}













## Temporal binning of our occurrences -----------------------------------------
data_2023 <- read.csv("./data_2023/Neotropical_Mammals_COMBINED.csv")
binning <- bin_time(occdf = data.frame(max_ma = data_2023$Max.age,
                                       min_ma = data_2023$Min.age),
                    bins = Cnz_Mz,
                    method = "majority")
data_2023$Epoch <- unlist(lapply(X = binning$bin_assignment,
                                 FUN = function(x){return(Cnz_Mz$interval_name[which(Cnz_Mz$bin == x)])}))
data_2023 <- data_2023 %>% add_column(Pct_age_range_in_Epoch = binning$overlap_percentage, .after = "Epoch")

## Save ------------------------------------------------------------------------
write.csv(x = data_2023, file = "./data_2023/Neotropical_Mammals_COMBINED_BINNED.csv")