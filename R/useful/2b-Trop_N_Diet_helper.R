################################################################################
# Name: 2b-Backtrace_coords.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: Helper script containing the detail of the backtracing step, assigning 
#   spatial coordinates to occurrences with no defined collection, as well as 
#   the diet categories vector.
################################################################################

library(hash)

## You need to run 2-Tropics_and_diet.R until line 27 to make it work
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

occdf <- occdf[-which(is.na(occdf$lat)),] #remove the single pleistocene occurrence for which we couldn't retrieve coordinates

## Diet categories vector
diet_cat <- hash("carnivore, durophage" = "carnivore", # 1 occurrence
                 "carnivore, suspension feeder" = "carnivore", # 19 occurrences
                 "frugivore, folivore" = "herbivore", # 236 occurrences
                 "frugivore, herbivore" = "herbivore", # 21 occurrences
                 "frugivore, omnivore" = "omnivore", # 27 occurrences
                 "grazer, browser" = "herbivore",
                 "carnivore, omnivore" = "omnivore",
                 "omnivore, carnivore" = "omnivore",
                 "insectivore, frugivore" = "insectivore",
                 "insectivore, herbivore" = "insectivore",
                 "piscivore, carnivore" = "carnivore",
                 "browser, browser" = "browser",
                 "frugivore, granivore" = "frugivore",
                 "granivore, frugivore" = "frugivore",
                 "herbivore, frugivore" = "herbivore",
                 "herbivore, insectivore" = "insectivore",
                 "piscivore, insectivore" = "carnivore",
                 "frugivore, omnivore" = "omnivore",
                 "frugivore, carnivore" = "carnivore",
                 "piscivore" = "carnivore",
                 "folivore" = "browser",
                 "herbivore, carnivore" = "carnivore",
                 "grazer, herbivore" = "grazer",
                 "frugivore, insectivore" = "insectivore",
                 "herbivore, omnivore" = "omnivore",
                 "insectivore, piscivore" = "insectivore",
                 "insectivore, carnivore" = "carnivore",
                 "carnivore, insectivore" = "carnivore",
                 "browser, grazer" = "herbivore")