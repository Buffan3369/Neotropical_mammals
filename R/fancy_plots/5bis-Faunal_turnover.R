################################################################################
# Name: 5bis-Faunal_Turnover.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots per family and genera for different groups
################################################################################

library(tidyverse)
library(deeptime)
library(readxl)

# Open species List
spl <-  readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")

# Function returning estimated age boundaries of a family
Ori_ext <- function(fam, gen_fam_tbl, TsTe_tbl, time = c("Ts", "Te")){
  tmp_fam <- gen_fam_tbl %>% filter(family == fam)
  TsTe_tmp <- TsTe_tbl %>% filter(genus %in% tmp_fam$genus)
  if(time == "Ts"){
    return(max(TsTe_tmp$ts))
  }
  else if(time == "Te"){
    return(min(TsTe_tmp$te))
  }
}

# GEOSCALES
  # First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
  # Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

## NOTOUNGULATA ----------------------------------------------------------------
  # TsTe info
TsTe_noto <- read.table("./results/SALMA_smoothed/genus_level/6-Order_level/Notoungulata/LTT/combined_10_KEEP_se_est.txt",
                        header = TRUE)
species_list_idx <- read.table("./data_2023/PyRate/SALMA_smoothed/genus_level/5-Order_level/Notoungulata_EOT_gen_occ_SALMA_smoothed_TaxonList.txt",
                               header = TRUE)
TsTe_noto <- TsTe_noto %>% mutate(genus = species_list_idx$Species)
  
  ## 1) Ts-arranged genus plot
TsTe_noto %>% 
  arrange(ts) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  geom_rect(aes(ymin = 46.5, ymax = 65.5, xmin = 35, xmax = 38.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  annotate(geom = "text", y = 56, x = 39, label = "(1)", size = 7, colour = "#08519c") +
  geom_rect(aes(ymin = 30.5, ymax = 46.5, xmin = 30, xmax = 34.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  annotate(geom = "text", y = 38, x = 35, label = "(2)", size = 7, colour = "#08519c") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32.5, y = 115, label = "EOT", size = 7, colour = "red") +
  annotate(geom = "text", x = 35, y = 118.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

  ## 2) Te-arranged genus plot
TsTe_noto %>% 
  arrange(te) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  geom_rect(aes(ymin = 82.5, ymax = 99.5, xmin = 37.5, xmax = 40.5), fill = "transparent", colour = "#a50f15", linewidth = 0.7) +
  annotate(geom = "text", y = 91, x = 37, label = "(1)", size = 7, colour = "#a50f15") +
  geom_rect(aes(ymin = 61.5, ymax = 82.5, xmin = 36, xmax = 32.2), fill = "transparent", colour = "#a50f15", linewidth = 0.7) +
  annotate(geom = "text", y = 72, x = 31.7, label = "(2)", size = 7, colour = "#a50f15") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32.5, y = 115, label = "EOT", size = 7, colour = "red") +
  annotate(geom = "text", x = 35, y = 118.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

  # Families: table with each genus and its associated family
noto_genera <- spl %>% 
  filter(order == "Notoungulata") %>%
  group_by(family, genus) %>%
  distinct(genus)

  # 3) Families plot
# Monophyletic families, according to Billet et al. (2011)
monophyl <- c("Homalodotheriidae", "Leontiniidae", "Toxodontidae",
              "Interatheriidae", "Mesotheriidae", "Hegetotheriidae", "Oldfieldthomasiidae")
spl %>%
  filter(order == "Notoungulata") %>%
  distinct(family) %>%
  filter(!is.na(family)) %>%
  mutate(Ts = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = noto_genera, TsTe_tbl = TsTe_noto, time = "Ts"),
         Te = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = noto_genera, TsTe_tbl = TsTe_noto, time = "Te"),
         phyl = ifelse(family %in% monophyl, "Monophyletic", "Non-monophyletic")) %>% 
  arrange(Ts) %>% 
  ggplot(aes(y = fct_inorder(family), yend = fct_inorder(family))) +
  geom_segment(aes(x = Ts, xend = Te, colour = phyl), linewidth = 2) +
  scale_colour_manual(values = c("black", "grey60")) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Family", colour = NULL) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 16.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))


## Xenarthra -------------------------------------------------------------------
rm(species_list_idx, noto_genera, TsTe_noto)
TsTe_xen <- read.table("./results/SALMA_smoothed/genus_level/6-Order_level/Xenarthra/LTT/combined_10_KEEP_se_est.txt", header = T)
species_list_idx <- read.table("./data_2023/PyRate/SALMA_smoothed/genus_level/5-Order_level/Xenarthra_EOT_gen_occ_SALMA_smoothed_TaxonList.txt", header = T)
TsTe_xen <-TsTe_xen %>% mutate(genus = species_list_idx$Species)
  
  ## 1) Ts-arranged genus plot
TsTe_xen %>% 
  arrange(ts) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  # geom_rect(aes(ymin = 46.5, ymax = 65.5, xmin = 35, xmax = 38.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 56, x = 39, label = "(1)", size = 7, colour = "#08519c") +
  # geom_rect(aes(ymin = 30.5, ymax = 46.5, xmin = 30, xmax = 34.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 38, x = 35, label = "(2)", size = 7, colour = "#08519c") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 36.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

## 2) Te-arranged genus plot
TsTe_xen %>% 
  arrange(te) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  # geom_rect(aes(ymin = 46.5, ymax = 65.5, xmin = 35, xmax = 38.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 56, x = 39, label = "(1)", size = 7, colour = "#08519c") +
  # geom_rect(aes(ymin = 30.5, ymax = 46.5, xmin = 30, xmax = 34.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 38, x = 35, label = "(2)", size = 7, colour = "#08519c") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 36.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

## 3) Families
xen_genera <- spl %>% 
  filter(order %in% c("Cingulata", "Pilosa")) %>%
  group_by(family, genus) %>%
  distinct(genus)

spl %>%
  filter(order %in% c("Cingulata", "Pilosa")) %>%
  distinct(family) %>%
  filter(!is.na(family)) %>%
  mutate(Ts = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = xen_genera, TsTe_tbl = TsTe_xen, time = "Ts"),
         Te = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = xen_genera, TsTe_tbl = TsTe_xen, time = "Te")) %>% 
  arrange(Ts) %>% 
  ggplot(aes(y = fct_inorder(family), yend = fct_inorder(family))) +
  geom_segment(aes(x = Ts, xend = Te), linewidth = 2) +
#  scale_colour_manual(values = c("black", "grey60")) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Family", colour = NULL) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 9.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

## Metatheria ------------------------------------------------------------------
rm(species_list_idx, xen_genera, TsTe_xen)
TsTe_met <- read.table("./results/SALMA_smoothed/genus_level/6-Order_level/Metatheria/LTT/combined_10_KEEP_se_est.txt", header = T)
species_list_idx <- read.table("./data_2023/PyRate/SALMA_smoothed/genus_level/5-Order_level/Metatheria_EOT_gen_occ_SALMA_smoothed_TaxonList.txt", header = T)
TsTe_met <-TsTe_met %>% mutate(genus = species_list_idx$Species)

## 1) Ts-arranged genus plot
TsTe_met %>% 
  arrange(ts) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  # geom_rect(aes(ymin = 46.5, ymax = 65.5, xmin = 35, xmax = 38.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 56, x = 39, label = "(1)", size = 7, colour = "#08519c") +
  # geom_rect(aes(ymin = 30.5, ymax = 46.5, xmin = 30, xmax = 34.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 38, x = 35, label = "(2)", size = 7, colour = "#08519c") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 36.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

## 2) Te-arranged genus plot
TsTe_met %>% 
  arrange(te) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  # geom_rect(aes(ymin = 46.5, ymax = 65.5, xmin = 35, xmax = 38.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 56, x = 39, label = "(1)", size = 7, colour = "#08519c") +
  # geom_rect(aes(ymin = 30.5, ymax = 46.5, xmin = 30, xmax = 34.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 38, x = 35, label = "(2)", size = 7, colour = "#08519c") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 36.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))

## 3) Families
met_genera <- spl %>% 
  filter(order %in% c("Paucituberculata", "Polydolopimorphia", "Didelphimorphia", "Microbiotheria", "Sparassodonta")) %>%
  group_by(family, genus) %>%
  distinct(genus)

spl %>%
  filter(order %in% c("Paucituberculata", "Polydolopimorphia", "Didelphimorphia", "Microbiotheria", "Sparassodonta")) %>%
  distinct(family) %>%
  filter(!is.na(family)) %>%
  mutate(Ts = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = met_genera, TsTe_tbl = TsTe_met, time = "Ts"),
         Te = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = met_genera, TsTe_tbl = TsTe_met, time = "Te")) %>% 
  arrange(Ts) %>% 
  ggplot(aes(y = fct_inorder(family), yend = fct_inorder(family))) +
  geom_segment(aes(x = Ts, xend = Te), linewidth = 2) +
  #  scale_colour_manual(values = c("black", "grey60")) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Family", colour = NULL) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 13.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53))
