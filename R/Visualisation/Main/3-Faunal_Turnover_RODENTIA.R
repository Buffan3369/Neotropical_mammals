################################################################################
# Name: 3-Faunal_Turnover_RODENTIA.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots rodents
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

source("./R/useful/helper_functions.R")

# Open species List
spl <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")

# GEOSCALES
# First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

# DATA Preprocessing
# Reference dataset for taxonomic equivalents
ref <- read.table("./data_2023/PyRate/EXTENDED/SALMA_kept/genus_level/1-Full/Full_EOT_gen_occ_SALMA_kept_TaxonList.txt", header = TRUE)
ref$order <- sapply(X = ref$Species, FUN = function(x){unique(spl$order[which(spl$genus == x)])})
ref$family <- sapply(X = ref$Species, FUN = function(x){unique(spl$family[which(spl$genus == x)])})
# Full TsTe table
TsTe_ttl <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/LTT/Full_EOT_gen_occ_SALMA_smoothed_10_Grj_KEEP_se_est.txt",
                       header = TRUE)
TsTe_ttl <- TsTe_ttl %>%
  add_column(order = ref$order, family = ref$family, genus = ref$Species)
# Extract rodents
TsTe_rod <- TsTe_ttl %>% 
  filter(order == "Rodentia")

Ts_rod <- TsTe_rod %>% 
  select(matches("ts")) 
Te_rod <- TsTe_rod %>% 
  select(matches("te"))
TsTe_rod <- TsTe_rod %>%
  mutate(mean_ts = rowMeans(Ts_rod),
         mean_te = rowMeans(Te_rod)) %>% 
  select(order, family, genus, mean_ts, mean_te) %>%
  rename(ts = "mean_ts", te = "mean_te") %>% 
  filter(ts > 23.03) %>%
  arrange(ts)

rm(Ts_rod, Te_rod)

# Plot
Rod_plot <- TsTe_rod %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = NULL) + 
  # add silhouette
  add_phylopic(x = 50, y = 7, name = "Ricardomys longidens", ysize = 5) +
  annotate(geom = "text", x = 49.8, y = 3, label = "Rodentia", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31, y = round(nrow(TsTe_rod)/2, digits = 0), label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_rod)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 8),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))

ggsave("./figures/Figure_3/Rodentia_turnover.pdf", Rod_plot, height = 7, width = 8.5)
ggsave("./figures/Figure_3/Rodentia_turnover.png", Rod_plot, height = 7, width = 8.5, dpi = 600)
