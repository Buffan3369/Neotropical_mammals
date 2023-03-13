################################################################################
############################### Teporal binning ################################
################################################################################
library(palaeoverse)
library(xlsx)
library(tibble)

## Generate time bins covering the whole Cenozoic + Cretaceous by Epoch -----
Cnz_Mz <- palaeoverse::time_bins(interval = c("Cenozoic","Mesozoic"),
                                       rank = "epoch")

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