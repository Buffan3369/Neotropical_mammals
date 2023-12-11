################################################################################
# Name: 1b-Matching_functions.R
# Author: Lucas Buffan
# Date: 2023-12-11
# Aim: Accessory functions for 1-Download_and_match.R
# corresponding stage
################################################################################

## Substitute separator in our accepted names (from " " to "_") ----------------
underscore <- function(name){
  split <- strsplit(name, split = " ")[[1]]
  if(length(split) > 1){
    return(paste0(split[1], "_", split[2])) 
  }
  else{
    return(name)
  }
}

## Process a reference (returns the publication year) --------------------------
process_ref <- function(reference){
  #split according to dots to pick up the year (first numeric)
  dot_split <- strsplit(reference, split = "[.]")
  dot_split_num <- lapply(dot_split, as.numeric)[[1]]
  year_index <- which(is.na(dot_split_num) == FALSE)[1]
  year <- dot_split_num[year_index]
  return(year)
}