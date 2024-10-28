################################################################################
# Name: 1-Map_occurrences.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Visualising occurrence data and Tropical/extratropical affinities.
################################################################################

library(sf)
library(spData)
library(ggplot2)
library(terra)
library(tidyverse)

## Load data -------------------------------------------------------------------
# Occurrence data
occdf <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
# New world map
nw <- st_read("./data_2023/New_World_map_ecoregions/New_World_18_regions_DCsplit.shp")
# switch off the use of s2, otherwise st_union does not work
sf_use_s2(FALSE)
# open raster and turn it to dataframe
r <- terra::rast("~/Téléchargements/0_Ma.grd")
r.df <- as.data.frame(r, xy = TRUE)
colnames(r.df) <- c("lon", "lat", "elev")
r.df <- r.df %>% filter(elev >= 0)

## Process map data and pot ----------------------------------------------------
nw %>%
  # Extract South America 
  filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
  # Merge extracted polygons
  st_union() %>% 
  # Plot
  ggplot() + 
  geom_sf(fill = "transparent", lwd = 0) +
  geom_tile(data = r.df, aes(x = lon, y = lat, fill = elev)) +
  scale_fill_continuous(low = "#fee391", high = "#662506") +
  geom_point(data = occdf, aes(x = lng, y = lat, colour = loc), size = 2) +
  scale_color_manual(values = c("#74a9cf", "#dd3497")) +
  labs(x = "Longitude", y = "Latitude", fill = "Elevation (m)", colour = NA)
# theme(axis.line=element_blank(),
#       axis.text.x=element_blank(),
#       axis.text.y=element_blank(),
#       axis.ticks=element_blank(),
#       axis.title.x=element_blank(),
#       axis.title.y=element_blank(),
#        panel.background = element_rect(fill = "#c6dbef"),
# panel.grid.major = element_blank(),
# panel.grid.minor = element_blank()
#)

## Save ------------------------------------------------------------------------
ggsave("./figures/supp_figs/Fig_S2_occurrences_map.pdf", plot = p, height = 8.5, width = 6)