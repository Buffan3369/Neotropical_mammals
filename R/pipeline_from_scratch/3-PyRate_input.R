################################################################################
######################## Write and save PyRate inputs ##########################
################################################################################

## Load libraries --------------------------------------------------------------
library(readxl)
library(hash)
library(dplyr)

#date <- "20-04"      #Intermediate cleaning
#date <- "12-05"      #Too stringent smoothing
#date <- "31-05"      #Less stringent smoothing, Xenarthra added 
date <- "21-06"       #Marsupials cleaned

## Species list (non-marine) ---------------------------------------------------
if(date == "20-04"){
  species_list <- read_xlsx("../../DATA/order_level/matched_order_level/Full_species_list_former_SALMA.xlsx") 
}
if(date == "12-05"){
  species_list <- read.table("../../DATA/order_level/Sub_Epoch_Binning/full_list_SUBEPOCH_without_Xenarthra.txt",
                             header = TRUE, 
                             dec = ",", 
                             sep = "\t", 
                             quote = "", 
                             fill = TRUE)
}
if(date == "31-05"){
  species_list <- read.table("../../DATA/order_level/Sub_Epoch_Binning/full_list_SALMA_ONLY_SUBEPOCH.txt",
                             header = TRUE, 
                             dec = ",", 
                             sep = "\t", 
                             quote = "", 
                             fill = TRUE)
}
if(date == "21-06"){
  species_list <- read.table("../../DATA/Cleaning_Narla/full_list_marsu_cleaned.txt",
                             header = TRUE, 
                             dec = ",", 
                             sep = "\t", 
                             quote = "", 
                             fill = TRUE)
}
  #exclude marine taxa
marine_idx <- which((species_list$order %in% c("Cetacea", "Sirenia")) |
                      (species_list$family %in% c("Otariidae", "Phocidae", "Odobenidae")))
species_list <- species_list[-marine_idx, ]
## All-in-one input ------------------------------------------------------------
all_in <- species_list[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(all_in) <- c("Species", "Status", "min_age", "max_age")
write.table(x = all_in,
            file = paste0("./data_2023/PyRate/cleaning_", date, "/all_in_one.txt"),
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
  #if no state indication
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
#print(length(unique(final_unique$Species)) == length(unique(all_in$Species))) #VERIFICATION
write.table(x = final_unique,
            file = paste0("./data_2023/PyRate/cleaning_", date, "/one_place-one_time-one_occ.txt"),
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)

## Order-level split -----------------------------------------------------------
  #we exclude orders with too few occurrences

#excluded <- c("Lagomorpha","Dasyuromorphia", "Eulipotyphla", "Monotremata", "Xenungulata", "Cimolesta", "Gondwanatheria")
excluded <- unique(species_list$order)[!(unique(species_list$order) %in% c("Paucituberculata", "Polydolopimorphia",
                                                                           "Microbiotheria", "Sparassodonta", "Didelphimorphia"))]

for(order in unique(species_list$order)[!(unique(species_list$order) %in% excluded)]){
  if(is.na(order) == FALSE){
    order_split <- species_list[which(species_list$order == order), ]
    pyrate_input <- order_split[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
    colnames(pyrate_input) <- c("Species", "Status", "min_age", "max_age")
    write.table(x = pyrate_input,
                file = paste0("./data_2023/PyRate/cleaning_", date, "/order_level/", order, ".txt"),
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

  #marsupial genera with no order specified
marsu_genera <- c("Chulpasia", "Fieratherium", "Marmosopsis", "Monodelphosis",
                  "Zeusdelphys", "Coona", "Derorhynchus", "Diogenesia", "Pauladelphys",
                  "Periakros", "Reigia", "Rumiodon", "Jaskhadelphys", "Kiruwamaq", 
                  "Minusculodelphis", "Canchadelphys", "Caroloameghinia", "Peradectes",
                  "Procaroloameghinia", "Bergqvistherium", "Carolocoutoia", "Guggenheimia",
                  "Periprotodidelphis", "Protodidelphis", "Andinodelphys", "Mayulestes",
                  "Eobrasilia", "Carolopaulacoutoia", "Didelphopsis", "Itaboraidelphys",
                  "Szalinia", "Gaylordia", "Acdestoides", "Incadelphys", "Khasia",
                  "Mirandatherium", "Mizquedelphys", "Progarzonia")

for(key in keys(dict)){
  group_split <- species_list[which(species_list$order %in% values(dict[key])), ]
  if(key == "marsupials"){
    group_split <- cbind(group_split,
                         species_list[which(species_list$genus %in% marsu_genera), ])
  }
  pyrate_input <- group_split[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  colnames(pyrate_input) <- c("Species", "Status", "min_age", "max_age")
  write.table(x = pyrate_input,
              file = paste0("./data_2023/PyRate/cleaning_", date, "/infra_order_level/", key, ".txt"),
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

########################### SPECIES-LEVEL ANALYSIS #############################
  ## All in one ----------------------------------------------------------------
all_in_sp <- species_list[-which(species_list$status == ""), ]
#Add species name as genus name when unprecised
all_in_sp$accepted_name[which(all_in_sp$accepted_name == "")] <- all_in_sp$genus[which(all_in_sp$accepted_name == "")]
#Target species names that are same as genus names: if several per genus, rename as different species if coming from different countries
for(genus in unique(all_in_sp$genus)){
  idx <- which(all_in_sp$accepted_name == genus)
  if((length(idx) > 0) & (length(unique(all_in_sp$cc[idx])) > 1)){
#    print(genus)
    df <- data.frame(name = all_in_sp$accepted_name[idx],
                     country = all_in_sp$cc[idx])
    df$letter <- NA
    i = 1
    for(cc in unique(df$country)){
      df$letter[which(df$country == cc)] <- letters[i]
      i = i+1
    }
    all_in_sp$accepted_name[idx] <- paste0(df$name, "_", df$letter)
  }
}
#Format
all_in_sp <- all_in_sp[, c("accepted_name", "status", "min_ma", "max_ma")]
colnames(all_in_sp) <- c("Species", "Status", "min_age", "max_age")
write.table(x = all_in_sp,
            file = paste0("./data_2023/PyRate/cleaning_", date, "/SPECIES_LEVEL/all_in_one_SPECIES.txt"),
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)
  ## Spatially weighted --------------------------------------------------------
apply_unique <- lapply(X = unique(species_list$accepted_name),
                       FUN = just_one,
                       sp_ds = species_list)
final_unique <- apply_unique[[1]]
for(i in 2:length(apply_unique)){
  final_unique <- rbind(final_unique, apply_unique[[i]])
}
for(genus in unique(final_unique$genus)){
  idx <- which(final_unique$accepted_name == genus)
  if((length(idx) > 0) & (length(unique(final_unique$cc[idx])) > 1)){
#    print(genus)
    df <- data.frame(name = final_unique$accepted_name[idx],
                     country = final_unique$cc[idx])
    df$letter <- NA
    i = 1
    for(cc in unique(df$country)){
      df$letter[which(df$country == cc)] <- letters[i]
      i = i+1
    }
    final_unique$accepted_name[idx] <- paste0(df$name, "_", df$letter)
  }
}
final_unique_sp <- final_unique[-which(final_unique$status == ""), c("accepted_name", "status", "min_ma", "max_ma")]
colnames(final_unique_sp) <- c("Species", "Status", "min_age", "max_age") 
write.table(x = final_unique_sp,
            file = paste0("./data_2023/PyRate/cleaning_", date, "/SPECIES_LEVEL/one_place-one_time-one_occ-SPECIES.txt"),
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)

################################ FOCUS ON EOT ##################################
  ## Full dataset --------------------------------------------------------------
Eot_occ <- species_list[which(species_list$epoch %in% c("Oligocene", "Eocene")),
                        c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(Eot_occ) <- c("Species", "Status", "min_age", "max_age")
write.table(x = Eot_occ,
            file = paste0("./data_2023/PyRate/cleaning_", date, 
                          "/Eocene_Oligocene/Eocene_Oligocene_occurrences.txt"),
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)
#count number of singletons (=genera only represented by one occurrence)
ct_gen <- Eot_occ %>% count(Species) #remember that the "genus" column was renamed "Species" for PyRate
message(paste0("Among the ", nrow(ct_gen), " genera present in the Eocene-Oligocene dataset, there are ", length(which(ct_gen == 1)), " singletons."))

  ## Taxonomic subdivision -----------------------------------------------------
Eot_occ1 <- species_list[which(species_list$epoch %in% c("Oligocene", "Eocene")),]
tax_dict <- hash::hash("SANU"=c("Notoungulata", "Pyrotheria", "Astrapotheria", "Xenungulata", "Litopterna"),
                       "Metatheria"=c("Polydolopimorphia", "Paucituberculata", "Sparassodonta"),
                       "Rodentia"="Rodentia",
                       "Xenarthra"=c("Cingulata", "Pilosa"))
for(taxo in c("SANU", "Metatheria", "Rodentia", "Xenarthra")){
  tmp <- Eot_occ1[which(Eot_occ1$order %in% values(tax_dict[taxo])), ]
  tmp <- tmp[,c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  colnames(tmp) <- c("Species", "Status", "min_age", "max_age")
  write.table(x = tmp,
              file = paste0("./data_2023/PyRate/cleaning_", date, 
                            "/Eocene_Oligocene/Order_level/", taxo, "_EOT.txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE)
  
}
  ## Spatially scaled dataset ------------------------------------------------------
apply_unique <- lapply(X = unique(Eot_occ1$genus),
                       FUN = just_one,
                       sp_ds = Eot_occ1)
final_unique <- Reduce(dplyr::full_join, apply_unique) #drop to 766 occurrences
final_unique <- final_unique[,c("genus", "gen_lvl_status", "min_ma", "max_ma")]
colnames(final_unique) <- c("Species", "Status", "min_age", "max_age")
write.table(x = final_unique,
            file = paste0("./data_2023/PyRate/cleaning_", date, 
                          "/Eocene_Oligocene/Eocene_Oligocene_occurrences_spatially_scaled.txt"),
            sep = "\t",
            na = "",
            row.names = FALSE,
            quote = FALSE)

####### Extract ages using Silvestro et al. function (for PyRate output) #######
source("../../pyrate_utilities.R")
for(file in c(paste0("./data_2023/PyRate/cleaning_", date, "/all_in_one.txt"),
              paste0("./data_2023/PyRate/cleaning_", date, "/one_place-one_time-one_occ.txt"))){
  extract.ages(file, replicates = 10)
}

for(file in c(paste0("./data_2023/PyRate/cleaning_", date, "/SPECIES_LEVEL/all_in_one_SPECIES.txt"),
              paste0("./data_2023/PyRate/cleaning_", date, "/SPECIES_LEVEL/one_place-one_time-one_occ-SPECIES.txt"))){
  extract.ages(file, replicates = 10)
}

for(file in list.files(paste0("./data_2023/PyRate/cleaning_", date, "/order_level/"))){
  extract.ages(paste0("./data_2023/PyRate/cleaning_", date, "/order_level/", file), replicates = 10)
}
for(file in list.files("./data_2023/PyRate/cleaning_", date, "/infra_order_level/")){
  extract.ages(paste0("./data_2023/PyRate/cleaning_", date, "/infra_order_level/", file), replicates = 10)
}
for(file in list.files("./data_2023/PyRate/cleaning_20-04/marine/")){
  extract.ages(paste0("./data_2023/PyRate/cleaning_20-04/marine/", file), replicates = 10)
}
#EOT
extract.ages(paste0("./data_2023/PyRate/cleaning_", date, 
                    "/Eocene_Oligocene/Eocene_Oligocene_occurrences.txt"), replicates = 10)
extract.ages(paste0("./data_2023/PyRate/cleaning_", date, 
                    "/Eocene_Oligocene/Eocene_Oligocene_occurrences_spatially_scaled.txt"), replicates = 10)
for(taxo in c("SANU", "Xenarthra", "Metatheria", "Rodentia")){
  extract.ages(paste0("./data_2023/PyRate/cleaning_", date, 
                      "/Eocene_Oligocene/Order_level/", taxo, "_EOT.txt"), replicates = 10)
}
