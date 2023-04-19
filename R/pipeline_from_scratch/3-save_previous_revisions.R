#################################################################################
## Pick up Laurent's cleaning info from Paleogene/Neogene Primates and Rodents ##
#################################################################################

## 1-Open the two datasets -----------------------------------------------------
#dataset revised by Laurent but temporally-unmatched
primates_cleaned <- read.table("../../../DATA/order_level/from_2020_2023_data_combination/Primates.txt",
                              sep = "\t",
                              header = TRUE, 
                              fill = TRUE, 
                              dec = ",")
#Temporally-matched rodent dataset
primates_matched <- read.table("../../../DATA/order_level/matched_order_level/Primates.txt",
                              sep = "\t",
                              header = TRUE, 
                              fill = TRUE, 
                              dec = ",")
## 2-Match their columns -------------------------------------------------------
primates_matched <- primates_matched[, c("order", "family", "genus", "accepted_name", "cc", "state", "locality",
                                         "formation", "stage", "min_ma", "max_ma", "collection_no", "authorizer", "primary_reference")]
primates_matched <- primates_matched[order(primates_matched$family, primates_matched$genus),]
