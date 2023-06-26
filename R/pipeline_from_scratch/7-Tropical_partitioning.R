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
                     age = occdf$age)

to_rot <- palaeorotate(occdf = to_rot,
                       lng = "lng",
                       lat = "lat",
                       age = "age",
                       model = "MERDITH2021",
                       method = "point",
                       uncertainty = FALSE)

## Palaeolatitudinal binning ---------------------------------------------------
  #Quick and dirty tropical assignation
bins <- data.frame(bin = c(1,2),
                   max = c(12, -30),
                   mid = c(-9, -45),
                   min = c(-30, -60))
to_rot <- bin_lat(occdf = to_rot,
                  bins = bins,
                  lat = "p_lat")

## Merge and save binned palaeorotated occurrences dataframe --------------------
occdf <- cbind.data.frame(occdf, to_rot[,!(colnames(to_rot) %in% c("lng", "lat", "age"))])
write.table(occdf,
            file = "../../DATA/lat_binning/full_list_palaeorotated_binned.txt",
            sep = "\t",
            dec = ",",
            na = "",
            row.names = FALSE,
            quote = FALSE)

## Split based on palaeolatitudinal bin and save pyrate inputs -----------------
source("../../pyrate_utilities.R")

bin_sign <- hash::hash("1"="Tropical", "2"="Extra-tropical")
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
