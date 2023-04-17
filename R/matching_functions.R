## Substitute separator in our accepted names (from " " to "_") ----------------
underscore <- function(name){
  split <- strsplit(name, split = " ")
  return(paste0(split[[1]][1], "_", split[[1]][2]))
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
## Remove white space(s) before/after interval names in "Int1 - Int2"-like cases ----------
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
## Proper Matching function ----------------------------------------------------
matching <- function(i, time_ds, match_ds){
  #Occurrence between two stages?
  if(length(strsplit(match_ds$stage[i], split = "-")[[1]]) == 2){ # Int1-Int2, where Int1 older than Int2
    int <- strsplit(match_ds$stage[i], split = "-")[[1]]
    int1 <- no_blank(int[1])
    int2 <- no_blank(int[2])
    ref_min <- time_ds[which(time_ds$interval_name == int2), "min_ma"]
    if((length(strsplit(int2, split = " ")[[1]]) == 2) & (length(strsplit(int1, split = " ")[[1]]) == 1)){ #e.g. "Middle-Late Paleocene": int1 = "Middle", int2 = "Late Paleocene" => strsplit(int2, split = " ")) = ["Late", "Paleocene"]
      epoch <- strsplit(int2, split = " ")[[1]][2]
      ref_max <- time_ds[which(time_ds$interval_name == paste(int1, epoch, sep = " ")), "max_ma"]
    }
    else{ #either e.g. "Late Pleistocene-Late Holocene" or "Pleistocene-Holocene"
      ref_max <- time_ds[which(time_ds$interval_name == int1), "max_ma"]
    }
  }
  else{
    ref_min <- time_ds[which(time_ds$interval_name == match_ds$stage[i]), "min_ma"]
    ref_max <- time_ds[which(time_ds$interval_name == match_ds$stage[i]), "max_ma"]
  }
  #compare current boundaries to reference
  new_min <- as.numeric(match_ds$min_ma[i])
  new_max <- as.numeric(match_ds$max_ma[i])
  if(new_min < ref_min){
    new_min <- ref_min
  }
  if(new_max > ref_max){
    new_max <- ref_max
  }
  if(new_min > new_max){
    new_min <- ref_min
    new_max <- ref_max
  }
  return(c(new_min, new_max))
}
