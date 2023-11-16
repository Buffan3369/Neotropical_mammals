################################################################################
######### Add spatial coordinates to and palaeorotate our occurrences ##########
################################################################################

library(palaeoverse)
library(dplyr)
library(readxl)
library(hash)

## Fix temporal issue with raw data (absence of coordinates) -------------------
# Remove extant mammals from our dataset (we don't care about their palaeocoordinates, they are actual)
occdf <- read_xlsx("../../DATA/order_level/Sub_Epoch_Binning/full_list_SALMA_ONLY_SUBEPOCH.xlsx")
extant_mammals <- read.csv("./data_2023/extant_mammals.csv")
occdf <- occdf[-which((occdf$genus %in% extant_mammals$Genus) &
                        is.na(occdf$collection_no)), ]
# Newer raw dataset with coordinates
newest_raw <- read.csv("C:/Users/lucas/Downloads/pbdb_data.csv")
# Create Longitude and Latitude columns
occdf$lng <- NA
occdf$lat <- NA
# Fill them by collection
for(collection in unique(occdf$collection_no)){
  if(collection %in% newest_raw$collection_no){
    #longitude
    occdf$lng[which(occdf$collection_no == collection)] <-
      unique(newest_raw$lng[which(newest_raw$collection_no == collection)])
    #latitude
    occdf$lat[which(occdf$collection_no == collection)] <-
      unique(newest_raw$lat[which(newest_raw$collection_no == collection)])
  }
}
# Backtrace
occdf[which( (occdf$locality %in% c("Shapaja (TAR-74)", "Shapaja (TAR-31)", "Shapaja (TAR-22)", "Shapaja (TAR-72)")) &
               (is.na(occdf$lat)) ), c("lng")] <- -76.16
occdf[which( (occdf$locality %in% c("Shapaja (TAR-74)", "Shapaja (TAR-31)", "Shapaja (TAR-22)", "Shapaja (TAR-72)")) &
               (is.na(occdf$lat)) ), c("lat")] <- -6.56

occdf[which( (occdf$state == "Entre Ríos") &
               (is.na(occdf$lat)) ), c("lng")] <- -59.20
occdf[which( (occdf$state == "Entre Ríos") &
               (is.na(occdf$lat)) ), c("lat")] <- -32.17

occdf[which( (occdf$state == "Santa Fe") &
               (is.na(occdf$lat)) ), c("lng")] <- -60.58
occdf[which( (occdf$state == "Santa Fe") &
               (is.na(occdf$lat)) ), c("lat")] <- -29.80

occdf[which( (occdf$state == "Tarija") &
               (is.na(occdf$lat)) ), c("lng")] <- -64.50
occdf[which( (occdf$state == "Tarija") &
               (is.na(occdf$lat)) ), c("lat")] <- -21.72

occdf[which( (occdf$state == "Canelones") &
               (is.na(occdf$lat)) ), c("lng")] <- -55.95
occdf[which( (occdf$state == "Canelones") &
               (is.na(occdf$lat)) ), c("lat")] <- -34.30

occdf[which( (occdf$state == "Colonia") &
               (is.na(occdf$lat)) ), c("lng")] <- -57.82
occdf[which( (occdf$state == "Colonia") &
               (is.na(occdf$lat)) ), c("lat")] <- -34.45

occdf[which( (occdf$state == "Montevideo") &
               (is.na(occdf$lat)) ), c("lng")] <- -56.17
occdf[which( (occdf$state == "Montevideo") &
               (is.na(occdf$lat)) ), c("lat")] <- -34.79

occdf[which( (occdf$state == "Formosa") &
               (is.na(occdf$lat)) ), c("lng")] <- -60.15
occdf[which( (occdf$state == "Formosa") &
               (is.na(occdf$lat)) ), c("lat")] <- -24.70

occdf[which( (occdf$locality == "Cuarcim" ) &
               (is.na(occdf$lat)) ), c("lng")] <- -57.60
occdf[which( (occdf$locality == "Cuarcim" ) &
               (is.na(occdf$lat)) ), c("lat")] <- -30.21

occdf[which( (occdf$locality == "Quebrada de Chalan" ) &
               (is.na(occdf$lat)) ), c("lng")] <- -78.68 #cf. Coltorti et al. 1998: The last occurrence of Pleistocene megafauna in the Ecuadorian Andes
occdf[which( (occdf$locality == "Quebrada de Chalan" ) &
               (is.na(occdf$lat)) ), c("lat")] <- -1.85

occdf[which( (occdf$locality == "Quebradas Pistud and Cuesaca" ) &
               (is.na(occdf$lat)) ), c("lng")] <- -77.95 #cf. Coltorti et al. 1998: The last occurrence of Pleistocene megafauna in the Ecuadorian Andes
occdf[which( (occdf$locality == "Quebradas Pistud and Cuesaca" ) &
               (is.na(occdf$lat)) ), c("lat")] <- 0.38

occdf[which( (occdf$state == "Chubut") &
               (is.na(occdf$lat)) ), c("lng")] <- -68.38
occdf[which( (occdf$state == "Chubut") &
               (is.na(occdf$lat)) ), c("lat")] <- -44.05

occdf[which( (occdf$state == "Huila") &
               (is.na(occdf$lat)) ), c("lng")] <- -75.21
occdf[which( (occdf$state == "Huila") &
               (is.na(occdf$lat)) ), c("lat")] <- 3.22

occdf[which( (occdf$state == "Santa Cruz") &
               (is.na(occdf$lat)) ), c("lng")] <- -69.32
occdf[which( (occdf$state == "Santa Cruz") &
               (is.na(occdf$lat)) ), c("lat")] <- -48.63

occdf[which( (occdf$locality == "Santa Rosa") &
               (is.na(occdf$lat)) ), c("lng")] <- -72.31
occdf[which( (occdf$locality == "Santa Rosa") &
               (is.na(occdf$lat)) ), c("lat")] <- -9.69

occdf[which( (occdf$state == "Jujuy") &
               (is.na(occdf$lat)) ), c("lng")] <- -65.33
occdf[which( (occdf$state == "Jujuy") &
               (is.na(occdf$lat)) ), c("lat")] <- -23.10

## Create mid_ma column (mid age, for palaeorotation) --------------------------
occdf$age <- unlist(lapply(X = 1:nrow(occdf),
                           FUN = function(x){
                             M <- (occdf$max_ma[x] + occdf$min_ma[x])/2
                             return(M)
                            }))

## Palaeorotate ----------------------------------------------------------------
occdf <- occdf[-which(is.na(occdf$lat) & is.na(occdf$lng)),] #remove occurrences with still to coordinate, will f*ck up palaeorotate otherwise

to_rot <- data.frame(lng = occdf$lng,
                     lat = occdf$lat,
                     age = occdf$age,
                     genus = occdf$genus)

to_rot <- palaeorotate(occdf = to_rot,
                       lng = "lng",
                       lat = "lat",
                       age = "age",
                       model = "MERDITH2021",
                       method = "point",
                       uncertainty = FALSE)

#-------------------------------------------------------------------------------
############## Palaeolatitudinal binning : using a 30° Threshold ###############
#-------------------------------------------------------------------------------

bins <- data.frame(bin = c(1,2),
                   max = c(12, -30),
                   mid = c(-9, -45),
                   min = c(-30, -60))
  #Fix the issue of the genera distributed between both bins
assign_mean <- function(genus, coord){ #coord = "lat" or "lng"
  coord_list <- to_rot[which(to_rot$genus == genus), c(coord)]
  return(mean(coord_list, na.rm = TRUE))
}
assign_sd <- function(genus, coord){ #coord = "lat" or "lng"
  coord_list <- to_rot[which(to_rot$genus == genus), c(coord)]
  return(sd(coord_list, na.rm = TRUE))
}
assign_len <- function(genus){
  return(length(which(to_rot$genus == genus)))
}

mean_loc <- data.frame(genus = unique(to_rot$genus),
                       mean_lat = unlist(lapply(X = unique(to_rot$genus),
                                           FUN = assign_mean,
                                           coord = "lat")),
                       sd_lat = unlist(lapply(X = unique(to_rot$genus),
                                              FUN = assign_sd,
                                              coord = "lat")),
                       N = unlist(lapply(X = unique(to_rot$genus),
                                         FUN = assign_len)))
  # Target genera with mean+sd and mean only binned into different bins
mean_loc_binned <- mean_loc[which(mean_loc$N > 1),]
row.names(mean_loc_binned) <- 1:nrow(mean_loc_binned)
mean_loc_binned <- bin_lat(occdf = mean_loc_binned,
                           bins = bins,
                           lat = "mean_lat")
IC_loc <- mean_loc[which(mean_loc$N > 1),]
row.names(IC_loc) <- 1:nrow(IC_loc)
IC_loc$IC <- IC_loc$lat - IC_loc$sd_lat
IC_loc <- bin_lat(occdf = IC_loc,
                           bins = bins,
                           lat = "IC")
  
bin <- mean_loc_binned$lat_bin + IC_loc$lat_bin
retained_genera <- mean_loc_binned$genus[which(bin != 3)] # 3 = 2+1 or 1+2 => different bins
  # Exclude them
mean_loc <- mean_loc[which( (mean_loc$genus %in% retained_genera) |
                              (mean_loc$N == 1)), ]
mean_loc <- bin_lat(occdf = mean_loc,
                    bins = bins,
                    lat = "mean_lat")

## Merge and save binned palaeorotated occurrences dataframe -------------------
occdf$p_lat <- to_rot$p_lat
occdf$p_lng <- to_rot$p_lng
occdf$lat_bin <- NA
for(genus in occdf$genus){
  idx <- which(occdf$genus == genus)
  if(genus %in% mean_loc$genus){
    occdf$lat_bin[idx] <- mean_loc$lat_bin[which(mean_loc$genus == genus)]
  }
  else{
    occdf$lat_bin[idx] <- "UNASSIGNED"
  }
}
write.table(occdf,
            file = "../../DATA/lat_binning/full_list_palaeorotated_binned.txt",
            sep = "\t",
            dec = ",",
            na = "",
            row.names = FALSE,
            quote = FALSE)

## Split based on palaeolatitudinal bin and save pyrate inputs -----------------
source("../../pyrate_utilities.R")
occdf <- read.table(file = "../../DATA/lat_binning/full_list_palaeorotated_binned.txt",
                    header = TRUE, 
                    dec = ",", 
                    sep = "\t", 
                    quote = "", 
                    fill = TRUE)
bin_sign <- hash::hash("1"="Tropical", "2"="Extra-tropical")
  #Entire Cenozoic
for(bin in keys(bin_sign)){
  tmp <- occdf[which(occdf$lat_bin == as.numeric(bin)), c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  write.table(tmp,
              file = paste0("../../DATA/lat_binning/", values(bin_sign[bin]), "_taxa.txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE)
  extract.ages(paste0("../../DATA/lat_binning/", values(bin_sign[bin]), "_taxa.txt"),
               replicates = 10)
}
  #EOT
occdf1 <- occdf[which(occdf$epoch %in% c("Eocene", "Oligocene")),]
    #Full data
for(bin in keys(bin_sign)){
  tmp <- occdf1[which(occdf1$lat_bin == as.numeric(bin)), c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  write.table(tmp,
              file = paste0("./data_2023/PyRate/cleaning_21-06/Eocene_Oligocene/lat_partitioning/",
                            values(bin_sign[bin]), "_taxa.txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE)
  extract.ages(paste0("./data_2023/PyRate/cleaning_21-06/Eocene_Oligocene/lat_partitioning/",
                      values(bin_sign[bin]), "_taxa.txt"),
               replicates = 10)
}
    #Spatially scaled
message("Please run the `just_one` function from the `3-PyRate_inputs.R` script")
for(bin in keys(bin_sign)){
  apply_unique <- lapply(X = unique(occdf1$genus),
                         FUN = just_one,
                         sp_ds = occdf1)
  final_unique <- apply_unique[[1]]
  for(i in 2:length(apply_unique)){
    final_unique <- rbind(final_unique, apply_unique[[i]])
  }
  final_unique <- final_unique[, c("genus", "gen_lvl_status", "min_ma", "max_ma")]
  write.table(final_unique,
              file = paste0("./data_2023/PyRate/cleaning_21-06/Eocene_Oligocene/lat_partitioning/",
                            values(bin_sign[bin]), "_spatially_scaled_taxa.txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE)
  extract.ages(paste0("./data_2023/PyRate/cleaning_21-06/Eocene_Oligocene/lat_partitioning/",
                      values(bin_sign[bin]), "_spatially_scaled_taxa.txt"),
               replicates = 10)
}


#-------------------------------------------------------------------------------
########## Palaeolatitudinal binning : using tropics palaeo-extent #############
#-------------------------------------------------------------------------------
# data source -> Scotese (2021), An Atlas of Phanerozoic Paleogeographic Maps: The Seas Come In and the Seas Go Out
# data preprocessed by Quintero et al. (2023), The build-up of the present-day tropical diversity of tetrapods

library(raster)

map_dict <- hash()
for(i in seq(from = 20, to = 60, by = 5)){
  map_dict[i] <- raster(paste0("../../paleoTropics/paleoTropics/Ma_", i, "_moll.grd"))
}
