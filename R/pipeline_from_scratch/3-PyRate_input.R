################################################################################
######################## Write and save PyRate inputs ##########################
################################################################################

## Load libraries --------------------------------------------------------------
library(readxl)
library(hash)
## Species list (non-marine) ---------------------------------------------------
species_list <- read_xlsx("../../DATA/order_level/matched_order_level/species_list.xlsx")
  #exclude marine taxa
marine_idx <- which((species_list$order %in% c("Cetacea", "Sirenia")) |
                      (species_list$family %in% c("Otariidae", "Phocidae", "Odobenidae")))
species_list <- species_list[-marine_idx, ]
## All-in-one input ------------------------------------------------------------
all_in <- species_list[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(all_in) <- c("Species", "Status", "min_age", "max_age")
write.table(x = all_in,
            file = "./data_2023/PyRate/cleaning_20-04/all_in_one.txt",
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)
## One place, one time, one occurrence -----------------------------------------
# (several occurrences of the same genus in the same place at the same time will be considered as one)
just_one <- function(genus, sp_ds){
  tmp <- sp_ds[which(sp_ds$genus == genus), ]
  #if singleton, spare time
  if(nrow(tmp) == 1){
    return(tmp)
  }
  else if(length(is.na(tmp$state) == nrow(tmp))){
    #country level
    retained <- c()
    for(country in unique(tmp$cc)){
      for(age in unique(tmp$stage[which(tmp$cc == country)])){
        available_idx <- which((tmp$cc == country) & (tmp$stage == age))
        retained <- c(retained, available_idx[sample(1:length(available_idx), 1)])
      }
    }
    return(tmp[retained, ])
  }
  else{
    na.loc <- which(is.na(tmp$locality)) #occurrences without locality, will be treated at the state level
    #locality level
    tmp_loc <- tmp[-na.loc, ]
    retained <- c()
    for(locality in unique(tmp_loc$locality)){
      for(age in unique(tmp_loc$stage[which(tmp_loc$locality == locality)])){
        available_idx <- which((tmp_loc$locality == locality) & (tmp_loc$stage == age))
        retained <- c(retained, available_idx[sample(1:length(available_idx), 1)])
      }
    }
    tmp_loc <- tmp_loc[retained, ]
    #state level
    if(length(na.loc) == 0){
      tmp_state <- tmp
    }
    else{
      tmp_state <- tmp[na.loc, ]
    }
    retained <- c()
    for(state in unique(tmp_state$state)){
      for(age in unique(tmp_state$stage[which(tmp_state$state == state)])){
        available_idx <- which((tmp_state$state == state) & (tmp_state$stage == age))
        retained <- c(retained, available_idx[sample(1:length(available_idx), 1)])
      }
    }
    tmp_state <- tmp_state[retained, ]
    return(rbind(tmp_loc, tmp_state))
  }
}

apply_unique <- lapply(X = unique(species_list$genus),
                       FUN = just_one,
                       sp_ds = species_list)
final_unique <- apply_unique[[1]]
for(i in 2:length(apply_unique)){
  final_unique <- rbind(final_unique, apply_unique[[i]])
}
final_unique <- final_unique[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(final_unique) <- c("Species", "Status", "min_age", "max_age")
write.table(x = final_unique,
            file = "./data_2023/PyRate/cleaning_20-04/one_place-one_time-one_occ.txt",
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)
## Order-level split -----------------------------------------------------------
  #we exclude orders with too few occurrences
for(order in unique(species_list$order)[!(unique(species_list$order) %in% c("Lagomorpha","Dasyuromorphia", "Eulypotyphla", "Monotremata", "Xenungulata", "Cimolesta", "Gondwanatheria"))]){
  if(is.na(order) == FALSE){
    order_split <- species_list[which(species_list$order == order), ]
    pyrate_input <- order_split[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
    colnames(pyrate_input) <- c("Species", "Status", "min_age", "max_age")
    write.table(x = pyrate_input,
                file = paste0("./data_2023/PyRate/cleaning_20-04/order_level/", order, ".txt"),
                sep = "\t",
                na = "",
                row.names = FALSE,
                quote = FALSE)
  }
}
## Infra-order split -----------------------------------------------------------
marsupials <- c("Paucituberculata", "Microbiotheria", "Polydolopimorphia", "Didelphimorphia", "Dasyuromorphia")
SANUs <- c("Xenungulata", "Astrapotheria", "Litopterna", "Notoungulata", "Pyrotheria")
xenarthra <- c("Pilosa", "Cingulata")
dict <- hash("marsupials" = marsupials, "SANUs" = SANUs, "xenarthra" = xenarthra)
for(key in keys(dict)){
  group_split <- species_list[which(species_list$order %in% values(dict[key])), ]
  pyrate_input <- group_split[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  colnames(pyrate_input) <- c("Species", "Status", "min_age", "max_age")
  write.table(x = pyrate_input,
              file = paste0("./data_2023/PyRate/cleaning_20-04/infra_order_level/", key, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE)
}
## Marine taxa -----------------------------------------------------------------
marine <- read_xlsx("../../DATA/order_level/matched_order_level/species_list.xlsx")[marine_idx, ]
  #all-in-one
all_mar <- marine[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(all_mar) <- c("Species", "Status", "min_age", "max_age")
write.table(x = all_mar,
            file = "./data_2023/PyRate/cleaning_20-04/marine/full_list.txt",
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)
  #One place, one time, one occurrence
apply_unique_mar <- lapply(X = unique(marine$genus),
                           FUN = just_one,
                           sp_ds = marine)
final_unique_mar <- apply_unique_mar[[1]]
for(i in 2:length(apply_unique_mar)){
  final_unique_mar <- rbind(final_unique_mar, apply_unique_mar[[i]])
}
final_unique_mar <- final_unique_mar[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(final_unique_mar) <- c("Species", "Status", "min_age", "max_age")
write.table(x = final_unique_mar,
            file = "./data_2023/PyRate/cleaning_20-04/marine/one_place-one_time-one_occ.txt",
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)
  #Order-level
for(order in c("Sirenia", "Cetacea")){
  order_split <- marine[which(marine$order == order), ]
  pyrate_input <- order_split[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  colnames(pyrate_input) <- c("Species", "Status", "min_age", "max_age")
  write.table(x = pyrate_input,
              file = paste0("./data_2023/PyRate/cleaning_20-04/marine/", order, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE)
}

## Extract ages using Silvestro et al. function (for PyRate output) ------------
source("../../pyrate_utilities.R")
for(file in c("./data_2023/PyRate/cleaning_20-04/all_in_one.txt",
              "./data_2023/PyRate/cleaning_20-04/one_place-one_time-one_occ.txt")){
  extract.ages(file, replicates = 10)
}
for(file in list.files("./data_2023/PyRate/cleaning_20-04/order_level/")){
  extract.ages(paste0("./data_2023/PyRate/cleaning_20-04/order_level/", file), replicates = 10)
}
for(file in list.files("./data_2023/PyRate/cleaning_20-04/infra_order_level/")){
  extract.ages(paste0("./data_2023/PyRate/cleaning_20-04/infra_order_level/", file), replicates = 10)
}
for(file in list.files("./data_2023/PyRate/cleaning_20-04/marine/")){
  extract.ages(paste0("./data_2023/PyRate/cleaning_20-04/marine/", file), replicates = 10)
}
