################################################################################
# Name: 2-Tropics_and_diet.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: Assign tropical/extra-tropical affinity and ecomorphotype
#   (proxy for rough diet) information to each occurrence.
# Note: Palaeotropics positions were obtained from Quintero et al. (2023) 
#   (adapted from Scotese (2021)) and ecomorphotype information from PBDB.
################################################################################

library(tidyverse)
library(palaeoverse)
library(terra)
library(sp)
library(hash)

#-------------------------------------------------------------------------------
############################ Tropical Assignment ###############################
#-------------------------------------------------------------------------------
## Load data -------------------------------------------------------------------
  #occurrence data
occdf <- readRDS("./data_2023/SPECIES_LISTS/3-Fully_cleaned_Cnz_SA_mammals_SALMA_kept.RDS")
occdf$min_ma <- as.numeric(occdf$min_ma)
occdf$max_ma <- as.numeric(occdf$max_ma)
  #raw dataset containing position information 
raw <- read.csv("./data_2023/SPECIES_LISTS/1-Raw_Cnz_SA_Mammals.csv")
coord_ref <- raw %>%
  group_by(collection_no, lng, lat) %>% 
  distinct(collection_no)
  #Associate each collection to its coordinates
occdf <- occdf %>%
  left_join(coord_ref)
  #Backtrace (for newly-entered occurrences, without collection number)
source("./R/useful/2b-Trop_N_Diet_helper.R")

## Create mid_ma column (mid age, for palaeorotation) --------------------------
occdf$age <- sapply(X = 1:nrow(occdf),
                    FUN = function(x){
                      M <- (occdf$max_ma[x] + occdf$min_ma[x])/2
                      return(M)
                    })

## Palaeorotate using the PALEOMAP Global Plate Model --------------------------
to_rot <- data.frame(lng = occdf$lng,
                     lat = occdf$lat,
                     age = occdf$age,
                     genus = occdf$genus)
to_rot <- palaeorotate(occdf = to_rot,
                       lng = "lng",
                       lat = "lat",
                       age = "age",
                       model = "PALEOMAP",
                       method = "point",
                       uncertainty = FALSE)
occdf <- occdf %>% 
  add_column(p_lng = to_rot$p_lng, p_lat = to_rot$p_lat, .after = "lat") %>% 
  filter(!(is.na(p_lat))) #filter out the 3 occurrences we couldn't palaeorotate

## Proceed to actual tropical assignment ---------------------------------------
  #function to find closest lat in a given lat vect
closest <- function(lat, ref_lats){
  DisT <- abs(ref_lats - lat)
  return(which.min(DisT))
}

# reproject Ignacio's maps using the WGS84 projection
# for(t in seq(from = 5, to = 60, by = 5)){
#   input <- paste0("./paleoTropics/paleoTropics/Ma_", (t-5), "_moll.grd")
#   out <- paste0("./paleoTropics/paleoTropics_WGS84/Ma_", (t-5), "_WGS84.tif")
#   gdalwarp(srcfile = input, dstfile = out, t_srs = "EPSG:4326")
# }

  #crazy loop
occdf$loc <- NA #loc will be either "E" for "Extra tropical" or "T" for "Tropical"
for(t in seq(from = 5, to = 60, by = 5)){
  # Open corresponding tropical/extratropical map
  corr_map <- terra::rast(paste0("./paleoTropics/paleoTropics_WGS84/Ma_", (t-5), "_WGS84.tif"))
  # Indices of the corresponding occurrences
  idx <- which((occdf$age < t) & (is.na(occdf$loc)))
  # Build spatial data vector 
  xy <- cbind(occdf$p_lng[idx], occdf$p_lat[idx])
  sp <- terra::vect(xy, crs = crs(corr_map))
  #plot(corr_map)
  #plot(sp, add = TRUE)
  # Extract values from the raster  
  val <- terra::extract(corr_map, sp, method = 'bilinear')
  xyz <- cbind(xy, val[,2])
  occdf$loc[idx] <- xyz[,3]
}
occdf$loc[which(occdf$loc > 1)] <- "E" #Extra-tropical
occdf$loc[which(occdf$loc == 1)] <- "T"

# Indicative message
cat("Proportion of Tropical occurrences:", round(length(which(occdf$loc == "T"))/nrow(occdf), digits = 2), "\n")
cat("Proportion of Extra-tropical occurrences:", round(length(which(occdf$loc == "E"))/nrow(occdf), digits = 2), "\n")
cat("Proportion of occurrences with unassigned affinity:", round(length(which(is.na(occdf$loc)))/nrow(occdf), digits = 2), "\n")

#-------------------------------------------------------------------------------
############################# 'Diet' Assignment ################################
#-------------------------------------------------------------------------------
# Simplify diet categories
diet_ref <- raw %>% 
  group_by(genus, diet) %>% 
  distinct(genus)

for(cat in keys(diet_cat)){ #diet_cat imported from 2b-
  idx <- which(diet_ref$diet == cat)
  diet_ref$diet[idx] <- values(diet_cat[cat])[[1]]
}
# Assign proper "diets"
assign_diet <- function(genus){
  if(genus %in% diet_ref$genus){
    idx <- which(diet_ref$genus == genus)
    return(diet_ref$diet[idx])
  }
  else{
    return(NA)
  }
}
occdf$diet <- sapply(X = occdf$genus, FUN = assign_diet)
# modifications done after one-by-one checking of the remaining unassigned occurrences
occdf$diet[which( (is.na(occdf$diet)) & (occdf$order %in% c("Notoungulata", "Astrapotheria")))] <- "herbivore"
occdf$diet[which( (is.na(occdf$diet)) & (occdf$order %in% c("Sparassodonta", "Carnivora")))] <- "carnivore"
occdf$diet[which( (is.na(occdf$diet)) & (occdf$order %in% c("Rodentia", "Pilosa") ))] <- "herbivore"
occdf$diet[which( (is.na(occdf$diet)) & (occdf$order == "Cingulata"))] <- "omnivore"
occdf$diet[which( (is.na(occdf$diet)) & (occdf$family %in% c("Argyrolagidae",
                                                       "Polydolopidae",
                                                       "Prepidolopidae",
                                                       "Palaeothentidae")))] <- "omnivore"
occdf$diet[which( (is.na(occdf$diet)) & (occdf$family == "Cervidae"))] <- "herbivore"
occdf$diet[which(occdf$genus == "cf. Perulestes")] <- "insectivore"
occdf$diet[which(occdf$genus == "Patagonia")] <- "herbivore"
occdf$diet[which(occdf$genus == "Neosaimiri")] <- "omnivore"
occdf$diet[which(occdf$genus == "cf. Aotus")] <- "omnivore"
occdf$diet[which(occdf$genus == "Callicebus")] <- "frugivore"

## Small correction for Mustersan's age boundaries
occdf$min_ma[which(occdf$stage == 'Mustersan')] <- 35
#-------------------------------------------------------------------------------
##################### Save the whole occurrence dataframe ######################
#-------------------------------------------------------------------------------
# All Cenozoic
saveRDS(occdf, "./data_2023/SPECIES_LISTS/4-Fully_cleaned_Cnz_SA_mammals_SALMA_kept_Tropics_Diet.RDS")
# EOT
all_cleaned_EOT <- occdf %>% filter(epoch %in% c("Eocene", "Oligocene"))
saveRDS(all_cleaned_EOT, "./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
# Extended dataset (mid-Palaeocene/mid_Miocene)
all_cleaned_extended <- occdf %>% filter(age <= 61.6 & age >= 15.97)
all_cleaned_extended$stage[which(all_cleaned_extended$stage == "Santacrucian-Friasian")] <- "Santacrucian"
all_cleaned_extended$stage[which(all_cleaned_extended$stage == "Colhuehuapian-Burdigalian")] <- "Colhuehuapian"
saveRDS(all_cleaned_extended, "./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
