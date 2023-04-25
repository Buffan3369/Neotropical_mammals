#################################################################################
################## Accessory functions for `big_matching.R` #####################
#################################################################################

## Substitute separator in our accepted names (from " " to "_") ------------------------------------
underscore <- function(name){
  split <- strsplit(name, split = " ")
  return(paste0(split[[1]][1], "_", split[[1]][2]))
}
## Is the taxon name doubtful ? ----------------------------------------------------------------------
no_dub <- function(name){
  spl <- strsplit(name, split = "_")[[1]]
  if("(nomen" %in% spl){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
}
## Process a reference (returns the publication year) ----------------------------------------------
process_ref <- function(reference){
  #split according to dots to pick up the year (first numeric)
  dot_split <- strsplit(reference, split = "[.]")
  dot_split_num <- lapply(dot_split, as.numeric)[[1]]
  year_index <- which(is.na(dot_split_num) == FALSE)[1]
  year <- dot_split_num[year_index]
  return(year)
}
## Remove white space(s) before/after interval names in "Int1 - Int2"-like cases --------------------
no_blank <- function(str){
  spl <- strsplit(str, split = "")[[1]]
  to_drop <- c()
  if(spl[1] == " "){
    i <- 1
    while(spl[i] == " "){ #in case several successive spaces
      to_drop <- c(to_drop, i)
      i <- i+1
    }
  }
  if(spl[nchar(str)] == " "){ #same
    i <- nchar(str)
    to_drop <- c(i)
    while(spl[i] == " "){
      to_drop <- c(to_drop, i)
      i <- i-1
    }
  }
  cleaned_str <- "" 
  for(i in (1:nchar(str))[!((1:nchar(str)) %in% to_drop)]){
    cleaned_str <- paste0(cleaned_str, spl[i])
  }
  return(cleaned_str)
}
## Proper Matching function -------------------------------------------------------------------------
get_ref <- function(int){ #pick the reference boundaries from a stage
  if(int %in% gts_stage_bins$interval_name){
    # print("gts_stage_bins")
    ref_min <- gts_stage_bins$min[which(gts_stage_bins$interval_name == int)]
    ref_max <- gts_stage_bins$max[which(gts_stage_bins$interval_name == int)]
    return(list(ref_max, ref_min))
  }
  else if(int %in% gts_early_late$interval_name){
    #print("gts_early_late")
    ref_min <- gts_early_late$min[which(gts_early_late$interval_name == int)]
    ref_max <- gts_early_late$max[which(gts_early_late$interval_name == int)]
    return(list(ref_max, ref_min))
  }
  else if(int %in% gts_epoch_bins$interval_name){
    #print("gts_epoch_bins")
    ref_min <- gts_epoch_bins$min[which(gts_epoch_bins$interval_name == int)]
    ref_max <- gts_epoch_bins$max[which(gts_epoch_bins$interval_name == int)]
    return(list(ref_max, ref_min))
  }
  else if(int %in% salma_bins$interval_name){
    #print("salma_bins")
    ref_min <- salma_bins$min[which(salma_bins$interval_name == int)]
    ref_max <- salma_bins$max[which(salma_bins$interval_name == int)]
    return(list(ref_max, ref_min))
  }
  else{
    warning(paste0("Unknown interval: ", int))
    return(list(NA, NA))
  }
}
matching <- function(i, match_ds, combined_stages=FALSE){
  #Occurrence between two stages?
  if(combined_stages == TRUE){ # Int1-Int2, where Int1 older than Int2
    int <- strsplit(match_ds$stage[i], split = "-")[[1]]
    int1 <- no_blank(int[1])
    int2 <- no_blank(int[2])
    ref_min <- get_ref(int2)[[2]]
    if((length(strsplit(int2, split = " ")[[1]]) == 2) & (int1 %in% c("Early", "Middle", "Late"))){ #e.g. "Middle-Late Paleocene": int1 = "Middle", int2 = "Late Paleocene" => strsplit(int2, split = " ")) = ["Late", "Paleocene"]
      epoch <- strsplit(int2, split = " ")[[1]][2]
      ref_max <- get_ref(paste(int1, epoch, sep = " "))[[1]]
    }
    else{ #either e.g. "Late Pleistocene-Late Holocene" or "Pleistocene-Holocene"
      ref_max <- get_ref(int1)[[1]]
    }
  }
  else{
    ref_min <- get_ref(match_ds$stage[i])[[2]]
    ref_max <- get_ref(match_ds$stage[i])[[1]]
  }
  #Fix the case where NAs are returned (unknown interval)
  if(is.na(ref_min)){
    ref_min <- as.numeric(match_ds$min_ma[i])
  }
  if(is.na(ref_max)){
    ref_max <- as.numeric(match_ds$max_ma[i])
  }
  #Compare current boundaries to reference
  new_min <- as.numeric(match_ds$min_ma[i])
  new_max <- as.numeric(match_ds$max_ma[i])
  if(new_min < ref_min){
    new_min <- ref_min
  }
  if(new_max > ref_max){
    new_max <- ref_max
  }
  if(new_min >= new_max){
    new_min <- ref_min
    new_max <- ref_max
  }
  return(list(new_min, new_max))
}

