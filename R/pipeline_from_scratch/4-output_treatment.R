# Flag the files we want to keep for plotting with the "KEEP" key
#setwd("/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/20_04/")
library(readxl)

rename_file <- function(name, drop_idx){
  spl <- strsplit(x = name, split = "_")[[1]]
  if("KEEP" %in% spl){
    return(name)
  }
  else{
    spl_num <- lapply(spl, as.numeric)
    replicate_nb <- spl_num[which(is.na(spl_num) == FALSE)][[1]]
    if((replicate_nb %in% drop_idx) == FALSE){
      #insert "KEEP" flag right after "Grj"
      left <- spl[1:which(spl == "Grj")]
      right <- spl[!(spl %in% left)]
      spl <- c(left, "KEEP", right)
      final_name <- spl[1]
      for(i in 2:length(spl)){
        final_name <- paste(final_name, spl[i], sep = "_")
      }
      return(final_name)
    }
    else{
      return(name)
    }
  }
}

runs_to_exclude <- read_xlsx(file = "./data_2023/excluded_runs.xlsx")[, -c(1)] #rows represent replicate number

for(i in 1:length(colnames(runs_to_exclude))){
  #target selected clade
  key <- colnames(runs_to_exclude)[i]
  if(key %in% c("marsupials", "SANUs", "xenarthra")){
    dir <- "../../PyRate_outputs/20_04/infra_order/"
  }
  else if(key %in% c("Cetacea", "Sirenia", "full_marine", "unique_marine")){
    dir <- "../../PyRate_outputs/20_04/marine/"
    if(key == "full_marine"){
      key <- "full_list"
    }
    else if(key == "unique_marine"){
      key <- "one_place-one_time-one_occ"
    }
  }
  else{
    dir <- "../../PyRate_outputs/20_04/order_level/"
  }
  #get indices of the runs to drop according to the "excluded_runs.csv" table
  drop_idx <- which(runs_to_exclude[, colnames(runs_to_exclude)[i]] == "OUT")
  print(drop_idx)
  #directory of the corresponding log files
  logs_dir <- paste0(dir, "dir_", key, "/pyrate_mcmc_logs/")
  for(file in list.files(logs_dir)){
    new_name <- rename_file(file, drop_idx = drop_idx)
    file.rename(from = paste0(logs_dir, "/", file), to = paste0(logs_dir, "/", new_name))
  }
}
