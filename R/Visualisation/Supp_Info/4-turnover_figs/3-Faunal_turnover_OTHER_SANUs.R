################################################################################
# Name: 3-Faunal_Turnover_OTHER_SANUs.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots all SANUs but notoungulates
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
# Extract native ungulates other than notoungulates (Litopterna, Astrapotheria, Pyrotheria, Xenungulata)
TsTe_sanu <- TsTe_ttl %>%
  filter(order %in% tax_dict$Other_SANUs)
# Combine death and birth ages
# add relevant info
Ts_sanu <- TsTe_sanu %>% 
  select(matches("ts")) 
Te_sanu <- TsTe_sanu %>% 
  select(matches("te"))
TsTe_sanu <-TsTe_sanu %>%
  mutate(mean_ts = rowMeans(Ts_sanu),
         mean_te = rowMeans(Te_sanu)) %>% 
  select(order, family, genus, mean_ts, mean_te) %>%
  rename(ts = "mean_ts", te = "mean_te") %>% 
  filter(ts > 23.03) %>%
  arrange(ts)

rm(Ts_sanu, Te_sanu)
# 31 litopterns, 12 Astrapotheres, 9 Didolodontids, 6 Pyrotheres, 2 Xenungulates

## Litopterna ------------------------------------------------------------------
TsTe_lito <- TsTe_sanu %>% 
  filter(order == "Litopterna") %>%
  mutate(family = sapply(X = family, FUN = function(fam){
    if(fam %in% c("Proterotheriidae", "Macraucheniidae", "Adianthidae", "Protolipternidae")){
      return(fam)
    }
    else{
      return("Others")
    }
  })) %>%
  mutate(family = factor(family, levels = c("Others", "Proterotheriidae", "Macraucheniidae", "Adianthidae", 
                                            "Protolipternidae"))) %>% 
  arrange(ts)

# add y axis colours
TsTe_lito <- TsTe_lito %>%
  mutate(y_colour = sapply(X = 1:nrow(TsTe_lito), FUN = function(i){
    fam <- as.character(TsTe_lito$family[i])
    if(fam == "Proterotheriidae"){
      return("#1b9e77")
    }
    else if(fam == "Macraucheniidae"){
      return("#d95f02")
    }
    else if(fam == "Adianthidae"){
      return("#7570b3")
    }
    else if(fam == "Protolipternidae"){
      return("#e7298a")
    }
    else{
      return("black")
    }
  })) %>% 
  mutate(i = sapply(X = family, FUN = function(x){
    if(x == "Adianthidae"){
      return(1)
    }
    else if(x == "Macraucheniidae"){
      return(2)
    }
    else if(x == "Proterotheriidae"){
      return(3)
    }
    else if(x == "Protolipternidae"){
      return(4)
    }
    else{return(5)}
  })) %>% 
  arrange(i)

#plot
Lito_plot <- TsTe_lito %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = ts, xend = te, colour = family)) +
  # colours
  scale_colour_manual(values = c("black", "#1b9e77", "#d95f02", "#7570b3", "#e7298a")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = NULL) + 
  # add silhouette
  add_phylopic(x = 50, y = 4, name = "Protheosodon coniferus", ysize = 3) +
  annotate(geom = "text", x = 49.8, y = 2, label = "Litopterna", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31, y = nrow(TsTe_lito)-1, label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_lito)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_lito$y_colour),
        axis.title.x = element_text(size = 18, vjust = -0.5),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))

## Astrapotheria ---------------------------------------------------------------
TsTe_astrapo <- TsTe_sanu %>% 
  filter(order == "Astrapotheria") %>%
  mutate(family = sapply(X = family, FUN = function(fam){
    if(fam %in% c("Astrapotheriidae", "Trigonostylopidae")){
      return(fam)
    }
    else{
      return("Others")
    }
  })) %>%
  mutate(family = factor(family, levels = c("Others", "Astrapotheriidae", "Trigonostylopidae"))) %>% 
  arrange(ts)

# add y axis colours
TsTe_astrapo <- TsTe_astrapo %>%
  mutate(y_colour = sapply(X = 1:nrow(TsTe_astrapo), FUN = function(i){
    fam <- as.character(TsTe_astrapo$family[i])
    if(fam == "Astrapotheriidae"){
      return("#7b3294")
    }
    else if(fam == "Trigonostylopidae"){
      return("#008837")
    }
    else{
      return("black")
    }
  })) %>% 
  mutate(i = sapply(X = family, FUN = function(x){
    if(x == "Astrapotheriidae"){
      return(1)
    }
    else if(x == "Trigonostylopidae"){
      return(2)
    }
    else{return(3)}
  })) %>% 
  arrange(i)

#plot
Astrapo_plot <- TsTe_astrapo %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = ts, xend = te, colour = family)) +
  # colours
  scale_colour_manual(values = c("black", "#7b3294", "#008837")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = NULL, colour = NULL) + 
  # add silhouette
  add_phylopic(x = 50, y = 2, name = "Astrapotherium magnum", ysize = 1) +
  annotate(geom = "text", x = 49.6, y = 1, label = "Astrapotheria", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31, y = nrow(TsTe_astrapo)-1, label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_astrapo)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_astrapo$y_colour),
        axis.title.x = element_text(size = 18, vjust = -0.5),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))


## Pyrotheria ------------------------------------------------------------------
TsTe_pyro <- TsTe_sanu %>% 
  filter(order == "Pyrotheria")%>% 
  arrange(ts) %>%
  mutate(y_colour = "#a6611a")

#plot
Pyro_plot <- TsTe_pyro %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = ts, xend = te), colour =  "#a6611a") +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = NULL, colour = NULL) + 
  # add silhouette
  add_phylopic(x = 49, y = 1.15, name = "Pyrotherium", ysize = 0.5) +
  annotate(geom = "text", x = 49.6, y = 0.7, label = "Pyrotheria", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31, y = nrow(TsTe_pyro), label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_pyro)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_pyro$y_colour),
        axis.title.x = element_text(size = 18, vjust = -0.5),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"))

## Assemble and save -----------------------------------------------------------

enlarge_output_pane()
sanu_tot <- ggarrange(Lito_plot, Astrapo_plot, Pyro_plot, nrow = 1)
enlarge_output_pane()
ggsave("./figures/Figure_3/SANU_turnover.png", sanu_tot, height = 200, width = 600, units = "mm", dpi = 600)
ggsave("./figures/Figure_3/SANU_turnover.pdf", sanu_tot, height = 200, width = 600, units = "mm")