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

p <- world %>% 
  filter(continent == "South America") %>% 
  ggplot() + 
  geom_sf(aes(fill = "#fff7f3", alpha = 0.2)) +
  geom_point(data = occdf, aes(x = lng, y = lat, colour = loc), size = 2) +
  scale_color_manual(values = c("#5ab4ac", "#8c510a")) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background = element_blank(),
        legend.position="none")

ggsave("./figures/Fig_S2_occurrences_map.png", plot = p, height = 10, width = 7.5)
