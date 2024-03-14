################################################################################
# Name: 6-Faunal_Turnover_SALMA_kept.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots per family and genera for different groups with 
#       SALMA kept.
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

# Open species List
spl <- readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")

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
gsc2 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
gsc2 <- gsc2 %>% 
  rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name") %>%
  mutate(min_age = sapply(min_age, as.numeric), max_age = sapply(max_age, as.numeric))

## NOTOUNGULATA ----------------------------------------------------------------
# TsTe info
TsTe_noto <- read.table("./results/SALMA_kept/genus_level/6-Order_level/Notoungulata/LTT/combined_9_KEEP_se_est.txt",
                        header = TRUE)
species_list_idx <- read.table("./data_2023/PyRate/RESTRICTED/SALMA_kept/genus_level/5-Order_level/Notoungulata_EOT_gen_occ_SALMA_kept_TaxonList.txt",
                               header = TRUE)
TsTe_noto <- TsTe_noto %>% 
  mutate(genus = species_list_idx$Species)

## 1) Ts-arranged genus plot
TsTe_noto1 <- TsTe_noto %>% 
  arrange(ts) %>%
  mutate(family = sapply(X = genus, FUN = function(gen){
    idx <- which(spl$genus == gen)
    fam <- unique(spl$family[idx])
    if(fam %in% c("Homalodotheriidae", "Hegetotheriidae", "Mesotheriidae", "Toxodontidae")){
      return(fam)
    }
    else{
      return("Others")
    }
  })) %>%
  mutate(family = factor(family, levels = c("Homalodotheriidae", "Hegetotheriidae", 
                                            "Mesotheriidae", "Toxodontidae", "Others")))
# add colour vector for y axis
TsTe_noto1 <- TsTe_noto1 %>%
  mutate(y_colour = sapply(X = 1:nrow(TsTe_noto1), FUN = function(i){
    fam <- as.character(TsTe_noto1$family[i])
    if(fam == "Homalodotheriidae"){
      return("#49006a")
    }
    else if(fam == "Hegetotheriidae"){
      return("#ae017e")
    }
    else if(fam == "Mesotheriidae"){
      return("#f768a1")
    }
    else if(fam == "Toxodontidae"){
      return("#9e9ac8")
    }
    else{
      return("black")
    }
  }))
# proper plot
noto_birth <- TsTe_noto1 %>% 
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te, colour = family), linewidth = 0.8) +
  scale_colour_manual(values = c("#49006a", "#ae017e", "#f768a1", "#9e9ac8", "black")) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = "Family") +
  # add silhouette
  add_phylopic(x = 49.2, y = 11, name = "Trigonostylops", ysize = 8) +
  annotate(geom = "text", x = 49, y = 5, label = "Notoungulata", size = 6) +
  # highlight relevant birth events with rectangles
  # geom_rect(aes(ymin = 46.5, ymax = 65.5, xmin = 35, xmax = 38.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 56, x = 39.5, label = "(1)", size = 7, colour = "#08519c") +
  # geom_rect(aes(ymin = 30.5, ymax = 46.5, xmin = 30, xmax = 34.5), fill = "transparent", colour = "#08519c", linewidth = 0.7) +
  # annotate(geom = "text", y = 38, x = 35.5, label = "(2)", size = 7, colour = "#08519c") +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32.5, y = 115, label = "EOT", size = 7, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = 118.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53)) +
  theme(axis.text.y = element_text(size = 6, colour = TsTe_noto1$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        legend.key=element_rect(fill="white"))

## 2) Te-arranged genus plot
TsTe_noto2 <- TsTe_noto %>% 
  arrange(te) %>%
  mutate(family = sapply(X = genus, FUN = function(gen){
    idx <- which(spl$genus == gen)
    fam <- unique(spl$family[idx])
    if(fam %in% c("Archaeopithecidae", "Oldfieldthomasiidae", "Notostylopidae")){
      return(fam)
    }
    else{
      return("Others")
    }
  })) %>%
  mutate(family = factor(family, levels = c("Archaeopithecidae", "Oldfieldthomasiidae", 
                                            "Notostylopidae", "Others"))) 

TsTe_noto2 <- TsTe_noto2 %>% 
  mutate(y_colour = sapply(X = 1:nrow(TsTe_noto2), FUN = function(i){
    fam <- as.character(TsTe_noto2$family[i])
    if(fam == "Archaeopithecidae"){
      return("#993404")
    }
    else if(fam == "Oldfieldthomasiidae"){
      return("#fe9929")
    }
    else if(fam == "Notostylopidae"){
      return("#fc9272")
    }
    else{
      return("black")
    }
  }))

noto_death <- TsTe_noto2 %>% 
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te, colour = family), linewidth = 0.8) +
  scale_colour_manual(values = c("#993404", "#fe9929", "#fc9272", "black")) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = "Family") + 
  # add silhouette
  add_phylopic(x = 49.2, y = 11, name = "Trigonostylops", ysize = 8) +
  annotate(geom = "text", x = 49, y = 5, label = "Notoungulata", size = 6) +
  # highlight relevant birth events with rectangles
  # geom_rect(aes(ymin = 82.5, ymax = 99.5, xmin = 37.5, xmax = 40.5), fill = "transparent", colour = "#a50f15", linewidth = 0.7) +
  # annotate(geom = "text", y = 91, x = 36.5, label = "(1)", size = 7, colour = "#a50f15") +
  # geom_rect(aes(ymin = 61.5, ymax = 82.5, xmin = 36, xmax = 32.2), fill = "transparent", colour = "#a50f15", linewidth = 0.7) +
  # annotate(geom = "text", y = 72, x = 31.2, label = "(2)", size = 7, colour = "#a50f15") +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32.5, y = 115, label = "EOT", size = 7, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = 118.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53)) +
  theme(axis.text.y = element_text(size = 6, colour = TsTe_noto2$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        legend.key=element_rect(fill="white"))

# Save
turnov_gen <- ggarrange2(noto_death, noto_birth, ncol = 2)
ggsave("./figures/supp_figs/Fig_turnover/SALMA_kept/Noto_turnover_SALMA_kept.pdf", turnov_gen, height = 10, width = 20)
ggsave("./figures/supp_figs/Fig_turnover/SALMA_kept/Noto_turnover_SALMA_kept.png", turnov_gen, height = 10, width = 20, dpi = 400)

# Families: table with each genus and its associated family
# Monophyletic families, according to Billet et al. (2011)
monophyl <- c("Homalodotheriidae", "Leontiniidae", "Toxodontidae",
              "Interatheriidae", "Mesotheriidae", "Hegetotheriidae")

noto_genera <- spl %>% 
  filter(order == "Notoungulata") %>%
  group_by(family, genus) %>%
  distinct(genus)

# 3) Families plot
noto_fam <- spl %>%
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
  # add silhouette
  add_phylopic(x = 48.5, y = 2.5, name = "Trigonostylops", ysize = 1.5) +
  annotate(geom = "text", x = 48, y = 1.2, label = "Notoungulata", size = 6) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Family", colour = NULL) +
  #EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 35, y = 16.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(24, 53)) +
  theme(axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 10))

ggsave("./figures/supp_figs/Fig_turnover/SALMA_kept/Noto_turnover_families_SALMA_kept.pdf", noto_fam, height = 7, width = 10)
ggsave("./figures/supp_figs/Fig_turnover/SALMA_kept/Noto_turnover_families_SALMA_kept.png", noto_fam, height = 7, width = 10, dpi = 400)

## Xenarthra -------------------------------------------------------------------
rm(species_list_idx, noto_genera, noto_birth, noto_death, TsTe_noto, TsTe_noto1, TsTe_noto2)
TsTe_xen <- read.table("./results/SALMA_kept/genus_level/6-Order_level/Xenarthra/LTT/per_replicate/Xenarthra_EOT_gen_occ_SALMA_kept_1_Grj_KEEP_se_est.txt", header = T)
species_list_idx <- read.table("./data_2023/PyRate/RESTRICTED/SALMA_kept/genus_level/5-Order_level/Xenarthra_EOT_gen_occ_SALMA_kept_TaxonList.txt", header = T)
TsTe_xen <-TsTe_xen %>% mutate(genus = species_list_idx$Species)

## 1) Ts-arranged genus plot
xen_birth <- TsTe_xen %>% 
  arrange(ts) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  # add silhouette
  add_phylopic(x = 50, y = 5, name = "Propalaehoplophorus australis", ysize = 4) +
  annotate(geom = "text", x = 50, y = 2, label = "Xenarthra", size = 6) +
  #ultimate customs
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
xen_death <- TsTe_xen %>% 
  arrange(te) %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  geom_segment(aes(x = ts, xend = te)) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  # add silhouette
  add_phylopic(x = 50, y = 5, name = "Propalaehoplophorus australis", ysize = 4) +
  annotate(geom = "text", x = 50, y = 2, label = "Xenarthra", size = 6) +
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

xen_families <- spl %>%
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

# Save
turnov_gen_xen <- ggarrange2(, noto_birth, ncol = 2)
ggsave("./figures/supp_figs/Fig_turnover/SALMA_kept/Noto_turnover_SALMA_kept.pdf", turnov_gen, height = 10, width = 20)
ggsave("./figures/supp_figs/Fig_turnover/SALMA_kept/Noto_turnover_SALMA_kept.png", turnov_gen, height = 10, width = 20, dpi = 400)


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
