################################################################################
# Name: 3-Faunal_Turnover_METATHERIA.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots Xenarthra
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

# Open species List
spl <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")

# GEOSCALES
# First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

# DATA PROCESSING AND PLOTTING 
TsTe_xen <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/6-Order_level/Xenarthra/BDCS/TsTe_Xenarthra_SALMA_smoothed_genus_level.txt", header = T)
species_list_idx <- read.table("./data_2023/PyRate/EXTENDED/SALMA_smoothed/genus_level/5-Order_level/Xenarthra_EOT_gen_occ_SALMA_smoothed_TaxonList.txt",
                               header = TRUE)
species_list_idx <- species_list_idx[-which(species_list_idx$Species == "Octodontotherium"),] # for some reason, disappeared

# Assess mean Ts and Te across replicates, and add "genus" column 
Ts_xen <- TsTe_xen %>% 
  select(matches("ts")) 
Te_xen <- TsTe_xen %>% 
  select(matches("te"))
TsTe_xen <- TsTe_xen %>% 
  mutate(mean_ts = rowMeans(Ts_xen),
         mean_te = rowMeans(Te_xen),
         genus = species_list_idx$Species) %>%
  select(genus, mean_ts, mean_te) %>%
  rename(ts = "mean_ts", te = "mean_te") %>% 
  filter(ts > 23.03) %>%
  arrange(genus)
rm(Ts_xen, Te_xen)
# Add family, subfamily and tribe info
supp <- read.csv("./data_2023/systematics/xenarthra_genera_EOT.csv", header = TRUE)
supp <- supp %>% filter(genus != "Octodontotherium")
TsTe_xen <- TsTe_xen %>% add_column(family = supp$family, subfamily = supp$subfamily, tribe = supp$tribe, .before = "ts")

## 1) Ts-arranged genus plot
TsTe_xen1 <- TsTe_xen %>% 
  arrange(ts) %>%
  mutate(subfamily = sapply(X = subfamily, FUN = function(sf){
    if(sf %in% c("Dasypodinae", "Euphractinae")){
      return(sf)
    }
    else{
      return("Others")
    }
  })) %>%
  mutate(subfamily = factor(subfamily, levels = c("Dasypodinae", "Euphractinae", "Others"))) %>%
  mutate(y_colour = sapply(X = subfamily, FUN = function(sf){
    if(sf == "Dasypodinae"){
      return("#bf812d")
    }
    else if(sf == "Euphractinae"){
      return("#35978f")
    }
    else{
      return("black")
    }
  })) 

Turnov_xen <- TsTe_xen1 %>% 
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te, colour = subfamily), linewidth = 0.8) +
  scale_colour_manual(values = c("#993404", "#35978f", "black")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = "Sub-Family") + 
  # add silhouette
  add_phylopic(x = 49.2, y = 5, name = "Propalaehoplophorus australis", ysize = 4) +
  annotate(geom = "text", x = 49, y = 2, label = "Xenarthra", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31.5, y = 34, label = "EOT", size = 7, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = 38.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(size = 6, colour = TsTe_xen1$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        legend.key=element_rect(fill="white"))

ggsave("./figures/Figure_3/Xen_turnover.pdf", Turnov_xen, height = 7, width = 8.5)
ggsave("./figures/Figure_3/Xen_turnover.png", Turnov_xen, height = 7, width = 8.5, dpi = 600)
