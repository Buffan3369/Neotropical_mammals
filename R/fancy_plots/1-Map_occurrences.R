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

data("world")
occdf <- readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")

world %>% 
  filter(continent == "South America") %>% 
  ggplot() + 
  geom_sf() +
  geom_point(data = occdf, aes(x = lng, y = lat, colour = loc)) +
  scale_color_manual(values = c("brown", "green")) +
  theme(panel.background = element_blank())

weird <- occdf %>% 
  filter(lat > -10 & loc == "E")

#requires internet connexion
pmap_30 <- sf::read_sf("https://gws.gplates.org/reconstruct/coastlines/?&time=30&model=PALEOMAP")

pmap_30 %>% 
  ggplot() + 
  geom_sf() +
  geom_point(data = occdf, aes(x = p_lng, y = p_lat, colour = loc)) +
  scale_color_manual(values = c("brown", "green")) +
  theme(panel.background = element_blank())
