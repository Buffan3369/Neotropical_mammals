################################################################################
# Name: 3-Faunal_Turnover_METATHERIA.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots Metatheria
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
  # Full TsTe table
TsTe_ttl <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/LTT/Full_EOT_gen_occ_SALMA_smoothed_10_Grj_KEEP_se_est.txt",
                       header = TRUE)
TsTe_ttl <- TsTe_ttl %>%
  add_column(order = ref$order, genus = ref$Species)
  # Extract metatherians
TsTe_met <- TsTe_ttl %>%
  filter(order %in% tax_dict$Metatheria)

#higher-level taxonomy
syst <- read.csv("./data_2023/systematics/metatheria_genera_EOT.csv")
# add relevant info
Ts_met <- TsTe_met %>% 
  select(matches("ts")) 
Te_met <- TsTe_met %>% 
  select(matches("te"))
TsTe_met <-TsTe_met %>%
  mutate(mean_ts = rowMeans(Ts_met),
         mean_te = rowMeans(Te_met)) %>% 
  select(order, genus, mean_ts, mean_te)

rm(Ts_met, Te_met)

TsTe_met <- TsTe_met %>%
  add_column(retained_scale = sapply(X = TsTe_met$genus, FUN = function(x){syst$retained_scale[which(syst$genus == x)]}),
             .before = "genus")

## SPARASSODONTA  --------------------------------------------------------------
TsTe_met_spar <- TsTe_met
TsTe_met_spar <- TsTe_met_spar %>% 
  filter(mean_ts >= 23.03 & retained_scale %in% c("Borhyaenoidea", "Hathliacynidae", "Other_Sparassodonta")) %>%
  arrange(retained_scale, mean_ts) %>%
  mutate(y_colour = sapply(X = retained_scale, FUN = function(x){
    if(x == "Borhyaenoidea"){
      return("#3378ff")
    }
    else if(x == "Hathliacynidae"){
      return("#d95f0e")
    }
    else{
      return("black")
    }
  }))
TsTe_met_spar$retained_scale[which(TsTe_met_spar$retained_scale == "Other_Sparassodonta")] <- "Others"
TsTe_met_spar$retained_scale <- factor(TsTe_met_spar$retained_scale, levels = c("Others", "Hathliacynidae", "Borhyaenoidea"))

#plot
Spar_plot <- TsTe_met_spar %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = mean_ts, xend = mean_te, colour = retained_scale)) +
  # colours
  scale_colour_manual(values = c("black", "#d95f0e", "#3378ff")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = NULL) + 
  # add silhouette
  add_phylopic(x = 49, y = 3, name = "Lycopsis longirostrus", ysize = 1.5) +
  annotate(geom = "text", x = 49, y = 1.5, label = "Sparassodonta", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31.5, y = nrow(TsTe_met_spar)-1, label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_met_spar)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_met_spar$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))

## POLYDOLOPIMORPHIA (including argyrolagids) ----------------------------------
TsTe_met_pol <- TsTe_met
TsTe_met_pol <- TsTe_met_pol %>% 
  filter(mean_ts >= 23.03 & retained_scale %in% c("Argyrolagoidea", "Bonapartherioidea", "Polydolopiformes", "Other_Polydolopimorphia")) %>%
  mutate(y_colour = sapply(X = retained_scale, FUN = function(x){
    if(x == "Argyrolagoidea"){
      return("#4a1486")
    }
    else if(x == "Bonapartherioidea"){
      return("#df65b0")
    }
    else if(x == "Polydolopiformes"){
      return("#4eb3d3")
    }
    else{
      return("black")
    }
  })) %>% 
  mutate(i = sapply(X = retained_scale, FUN = function(x){
    if(x == "Argyrolagoidea"){
      return(1)
    }
    else if(x == "Bonapartherioidea"){
      return(2)
    }
    else if(x == "Polydolopiformes"){
      return(3)
    }
    else{return(4)}
  })) %>% 
  arrange(i, mean_ts)
TsTe_met_pol$retained_scale[which(TsTe_met_pol$retained_scale == "Other_Polydolopimorphia")] <- "Others"
TsTe_met_pol$retained_scale <- factor(TsTe_met_pol$retained_scale, levels = c("Others", "Argyrolagoidea", "Bonapartherioidea", "Polydolopiformes"))

#plot
Pol_plot <- TsTe_met_pol %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +  
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = mean_ts, xend = mean_te, colour = retained_scale)) +
  # colours
  scale_colour_manual(values = c("black", "#4a1486", "#df65b0", "#4eb3d3")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = NULL, colour = NULL) + 
  # add silhouette
  add_phylopic(x = 49, y = 2.5, name = "Marmosa", ysize = 2) +
  annotate(geom = "text", x = 48.5, y = 1, label = "Polydolopimorphia", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31.5, y = nrow(TsTe_met_pol)-2, label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_met_pol)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_met_pol$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))

## PAUCITUBERCULATA -------------------------------------------
TsTe_met_Pau <- TsTe_met
TsTe_met_Pau <- TsTe_met_Pau %>% 
  filter(mean_ts >= 23.03 & retained_scale %in% c("Caenolestoidea", "Palaeothentoidea", "Other_Paucituberculata")) %>%
  mutate(y_colour = sapply(X = retained_scale, FUN = function(x){
    if(x == "Caenolestoidea"){
      return("#034e7b")
    }
    else if(x == "Palaeothentoidea"){
      return("#238443")
    }
    else{
      return("black")
    }
  })) %>% 
  mutate(i = sapply(X = retained_scale, FUN = function(x){
    if(x == "Caenolestoidea"){
      return(1)
    }
    else if(x == "Palaeothentoidea"){
      return(2)
    }
    else{return(3)}
  })) %>% 
  arrange(i, mean_ts)
TsTe_met_Pau$retained_scale[which(TsTe_met_Pau$retained_scale == "Other_Paucituberculata")] <- "Others"
TsTe_met_Pau$retained_scale <- factor(TsTe_met_Pau$retained_scale, levels = c("Others", "Palaeothentoidea", "Caenolestoidea"))

#plot
Pau_plot <- TsTe_met_Pau %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = mean_ts, xend = mean_te, colour = retained_scale)) +
  # colours
  scale_colour_manual(values = c("black", "#238443", "#034e7b")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus", colour = NULL) + 
  # add silhouette
  add_phylopic(x = 49, y = nrow(TsTe_met_Pau)-3, name = "Caenolestes fuliginosus", ysize = 2) +
  annotate(geom = "text", x = 48.7, y = nrow(TsTe_met_Pau)-4.5, label = "Paucituberculata", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31, y = nrow(TsTe_met_Pau)-1, label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_met_Pau)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_met_Pau$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))

## MICROBIOTHERIA --------------------------------------------------------------
TsTe_met_Mi <- TsTe_met
TsTe_met_Mi <- TsTe_met_Mi %>% 
  filter(mean_ts >= 23.03 & retained_scale %in% c("Microbiotheria")) %>%
  arrange(mean_ts) %>%
  mutate(y_colour = "#fe9929")

#plot
Mi_plot <- TsTe_met_Mi %>%
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_segment(aes(x = mean_ts, xend = mean_te, colour = retained_scale)) +
  # colours
  scale_colour_manual(values = c("#fe9929")) +
  scale_x_reverse(breaks = seq(from = 23.03, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = NULL, colour = NULL) + 
  # add silhouette
  add_phylopic(x = 48.5, y = 1.4, name = "Dromiciops gliroides", ysize = 0.8) +
  annotate(geom = "text", x = 48.5, y = 0.8, label = "Microbiotheria", size = 4) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 31.5, y = nrow(TsTe_met_Mi), label = "EOT", size = 8, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_met_Mi)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS  
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_text(face = "italic", size = 9, colour = TsTe_met_Mi$y_colour),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text.x = element_text(size = 15),
        panel.background = element_rect(fill = "grey95"),
        legend.position = "top",
        legend.key=element_rect(fill="white"))

## Assemble and save -----------------------------------------------------------
# Stackoverflow's function to enlarge pane
enlarge_output_pane <- function(height. = 700, width. = 1300){
  
  # detect current output pane dimensions
  dim_px <- grDevices::dev.size("px")
  
  # if detected width is less than 'width.', widen output pane with RStudio's layoutZoomRightColumn command
  if(dim_px[1] < width.){ rstudioapi::executeCommand("layoutZoomRightColumn") }
  
  # if detected height is less than 'height.', switch to Viewer windom and set height
  if(dim_px[2] < height.){
    
    viewer <- getOption("viewer")
    viewer("http://localhost:8100", height = height.)
    
  }
  
}
enlarge_output_pane()
metatheria <- ggarrange(Pau_plot, Pol_plot, Spar_plot, Mi_plot)
enlarge_output_pane()
ggsave("./figures/Figure_3/Metatheria_turnover.pdf", metatheria, height = 300, width = 300, units = "mm")
