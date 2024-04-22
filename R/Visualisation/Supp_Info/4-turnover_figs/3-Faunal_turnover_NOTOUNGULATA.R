################################################################################
# Name: 3-Faunal_Turnover.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots per family and genera Notoungulata (SALMA
#       smoothed)
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

source("./R/useful/helper_functions.R")

# Open species List
spl <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")

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
# Extract notoungulates
TsTe_noto <- TsTe_ttl %>%
  filter(order %in% tax_dict$Notoungulata)

Ts_noto <- TsTe_noto %>% 
  select(matches("ts")) 
Te_noto <- TsTe_noto %>% 
  select(matches("te"))

TsTe_noto <- TsTe_noto %>% 
  mutate(mean_ts = rowMeans(Ts_noto),
         mean_te = rowMeans(Te_noto)) %>%
  select(genus, family, mean_ts, mean_te) %>%
  rename(ts = "mean_ts", te = "mean_te") %>% 
  filter(ts > 23.03, genus != "Bryanpattersonia") #too late to re-run everything, we just exclude this artefactual genus
rm(Ts_noto, Te_noto)

  ## 1) Ts-arranged genus plot
TsTe_noto1 <- TsTe_noto %>%
  mutate(family = sapply(X = TsTe_noto$family, FUN = function(fam){
    if(fam %in% c("Homalodotheriidae", "Hegetotheriidae", "Mesotheriidae", "Toxodontidae")){
      return(fam)
    }
    else{
      return("Others")
    }
  })) %>%
  mutate(family = factor(family, levels = c("Homalodotheriidae", "Hegetotheriidae", 
                                            "Mesotheriidae", "Toxodontidae", "Others"))) %>% 
  arrange(ts)
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
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = ts, xend = te, colour = family), linewidth = 0.8) +
  scale_colour_manual(values = c("#49006a", "#ae017e", "#f768a1", "#9e9ac8", "black")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
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
            lwd = 0.5,
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 6, colour = TsTe_noto1$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        legend.key=element_rect(fill="white"))

  ## 2) Te-arranged genus plot
TsTe_noto2 <- TsTe_noto %>% 
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
                                            "Notostylopidae", "Others")))  %>%
  arrange(te)

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
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = ts, xend = te, colour = family), linewidth = 0.8) +
  scale_colour_manual(values = c("#993404", "#fe9929", "#fc9272", "black")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
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
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 6, colour = TsTe_noto2$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        legend.key=element_rect(fill="white"))

  # Save
enlarge_output_pane()
turnov_gen <- ggarrange2(noto_death, noto_birth, ncol = 2)
ggsave("./figures/Figure_3/Noto_turnover.pdf", turnov_gen, height = 10, width = 20)
ggsave("./figures/Figure_3/Noto_turnover.png", turnov_gen, height = 10, width = 20, dpi = 600)

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
  filter(!is.na(family), family %in% c("Homalodontotheridae", "Perutheriidae") == FALSE) %>% # Perutheriids and Homalodontotherids are just represented by a single occ
  mutate(Ts = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = noto_genera, TsTe_tbl = TsTe_noto, time = "Ts"),
         Te = sapply(X = family, FUN = Ori_ext, gen_fam_tbl = noto_genera, TsTe_tbl = TsTe_noto, time = "Te"),
         phyl = ifelse(family %in% monophyl, "Monophyletic", "Non-monophyletic")) %>% 
  arrange(Ts) %>% 
  ggplot(aes(y = fct_inorder(family), yend = fct_inorder(family))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
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

enlarge_output_pane()
ggsave("./figures/Figure_3/Noto_families.pdf", noto_fam, height = 7, width = 10)
ggsave("./figures/Figure_3/Noto_families.png", noto_fam, height = 7, width = 10, dpi = 400)
