################################################################################
# Name: 1-Map_occurrences.R
# Author: Lucas Buffan
# Date: 2023-12-18
# Aim: Visualising occurrence data and Tropical/extratropical affinities.
################################################################################

library(sf)
library(spData)
library(ggplot2)
library(tidyverse)

## Load data -------------------------------------------------------------------
  # Occurrence data
occdf <- readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
  # New world map
nw <- st_read("./data_2023/New_World_map_ecoregions/New_World_18_regions_DCsplit.shp")

## Process map data and pot ----------------------------------------------------
p <- nw %>%
  # Extract South America 
  filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
  # Merge extracted polygons
  st_union() %>% 
  # Plot
  ggplot() + 
  geom_sf(colour = "bisque2", fill = "bisque2", lwd = 0.01) +
  annotate(geom = "rect", xmin = -67, xmax = -65, ymin = -27, ymax = -25, fill = "bisque2") +
  annotate(geom = "rect", xmin = -75, xmax = -70, ymin = -15, ymax = -10, fill = "bisque2") +
  annotate(geom = "rect", xmin = -79.6, xmax = -70, ymin = -6.8, ymax = -2.5, fill = "bisque2") +
  annotate(geom = "rect", xmin = -69, xmax = -70, ymin = -18, ymax = -13, fill = "bisque2") +
  geom_point(data = occdf, aes(x = lng, y = lat, colour = loc), size = 2) +
  scale_color_manual(values = c("#01665e", "#8c510a")) +
  theme(axis.line=element_blank(),
    axis.text.x=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks=element_blank(),
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    panel.background = element_rect(fill = "skyblue2"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position="none")

## Save ------------------------------------------------------------------------
ggsave("./figures/Fig_S2_occurrences_map.png", plot = p, height = 8.5, width = 6)
