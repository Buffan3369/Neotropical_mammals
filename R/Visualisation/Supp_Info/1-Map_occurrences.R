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

## Load data
# Occurrence data
occdf <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
occdf <- occdf %>% mutate(loc = sapply(loc, 
                                       FUN = function(x){
                                         if(x == "E"){
                                           return("Extratropical")
                                         }
                                         else{
                                           return("Tropical")
                                         }
                                       }))
occdf$loc <- factor(occdf$loc, levels = c("Tropical", "Extratropical"))
# New world map
nw <- st_read("./data_2023/New_World_map_ecoregions/New_World_18_regions_DCsplit.shp")
# switch off the use of s2, otherwise st_union does not work
sf_use_s2(FALSE)
# open raster and turn it to dataframe
r <- terra::rast("./data_2023/New_World_map_ecoregions/South_America_topography_Boschman_2021-0_Ma.grd")
r.df <- as.data.frame(r, xy = TRUE)
colnames(r.df) <- c("lon", "lat", "elev")
r.df <- r.df %>% filter(elev >= 0)

## Process map data and plot
p <- nw %>%
  # Extract South America 
  filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
  # Merge extracted polygons
  st_union() %>% 
  # Plot
  ggplot() + 
  geom_sf(lwd=0) +
  geom_tile(data = r.df, aes(x = lon, y = lat, fill = elev)) +
  scale_fill_continuous(low = "#fee391", high = "#662506") +
  geom_point(data = occdf, aes(x = lng, y = lat, colour = loc), size = 2) +
  scale_color_manual(values = c("#dd3497", "#74a9cf")) +
  labs(x = "Longitude", y = "Latitude", fill = "Elevation (m)", colour = NULL) +
  theme(panel.grid.major = element_line(linetype = 3, colour = "black", linewidth = 0.1),
        panel.grid.minor = element_line(linetype = 3, colour = "black", linewidth = 0.1),
        panel.background = element_rect(fill = "#f0f0f0"),
        plot.margin=grid::unit(c(0,0,0,0), "mm"))

## Save
ggsave("./figures/supp_figs/Fig_S2_occurrences_map.pdf", plot = p, height = 10, width = 8)

## Plot map without occurrences ------------------------------------------------
map <- nw %>%
  # Extract South America 
  filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
  # Merge extracted polygons
  st_union() %>% 
  # Plot
  ggplot() + 
  geom_sf(lwd=0) +
  geom_tile(data = r.df, aes(x = lon, y = lat, fill = elev)) +
  scale_fill_continuous(low = "#fee391", high = "#662506") +
  theme(axis.line=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        legend.position = "none",
        panel.background = element_rect(fill = "transparent"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin=grid::unit(c(0,0,0,0), "mm"))

ggsave("./figures/supp_figs/andes_geo_strat/map.png", plot = map, height = 120, width = 50, units = "mm", dpi = 600)


## Map with collections coloured based on their Eocene/Oligocene affinity ------
rm(list = ls())
## Load data
# Occurrence data
occdf <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
occdf <- occdf %>% filter(epoch %in% c("Eocene", "Oligocene"))
occdf$epoch <- as.factor(occdf$epoch)
# New world map
nw <- st_read("./data_2023/New_World_map_ecoregions/New_World_18_regions_DCsplit.shp")
# switch off the use of s2, otherwise st_union does not work
sf_use_s2(FALSE)

## Process map data and plot
p <- nw %>%
  # Extract South America 
  filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
  # Merge extracted polygons
  st_union() %>% 
  # Plot
  ggplot() + 
  geom_sf(lwd=0.2, fill = "transparent") +
  geom_point(data = occdf, aes(x = lng, y = lat, colour = epoch), size = 2) +
  scale_color_manual(values = c("#54278f", "#9e9ac8")) +
  theme(axis.line=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        legend.position = "none",
        panel.background = element_rect(fill = "transparent"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin=grid::unit(c(0,0,0,0), "mm"))

## Save 
ggsave("./figures/supp_figs/andes_geo_strat/background_map_with_occ.pdf", plot = p, height = 10, width = 8)
