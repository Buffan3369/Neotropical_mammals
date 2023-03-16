################################################################################
############################### Teporal binning ################################
################################################################################
library(palaeoverse)
library(tibble)
library(readxl)

## Generate time bins covering the whole Cenozoic + Cretaceous by Epoch --------
Cnz_Mz <- palaeoverse::time_bins(interval = c("Cenozoic","Mesozoic"),
                                       rank = "epoch")

## Load data and extract age range of each occurrence --------------------------
data_2023 <- read.csv("./data_2023/Neotropical_Mammals_COMBINED.csv")

## Check potential time inconsistencies (i.e. typos where max_ma < min_ma) -----
time_insconsistency <- function(x){
  if(data_2023$Min.age[x] > data_2023$Max.age[x]){
    return(x)
  }
}
incons <- unlist(lapply(X = 1:nrow(data_2023), FUN = time_insconsistency))
for(pos in incons){
  max <- data_2023$Max.age[pos]
  min <- data_2023$Min.age[pos]
  #invert max and min
  data_2023$Min.age[pos] <- max
  data_2023$Max.age[pos] <- min
}

## Temporal binning of our occurrences -----------------------------------------
binning <- bin_time(occdf = data.frame(max_ma = data_2023$Max.age,
                                       min_ma = data_2023$Min.age),
                    bins = Cnz_Mz,
                    method = "majority")
data_2023$Epoch <- unlist(lapply(X = binning$bin_assignment,
                                 FUN = function(x){return(Cnz_Mz$interval_name[which(Cnz_Mz$bin == x)])}))
data_2023 <- data_2023 %>% add_column(Pct_age_range_in_Epoch = binning$overlap_percentage, .after = "Epoch")

## Save ------------------------------------------------------------------------
write.csv(x = data_2023, 
          file = "./data_2023/Neotropical_Mammals_COMBINED_BINNED.csv", 
          row.names = FALSE,
          na = "")