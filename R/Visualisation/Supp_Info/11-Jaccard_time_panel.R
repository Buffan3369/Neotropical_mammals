################################################################################
# Name: 11-Jaccard_time_panel.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Jaccard's index across time
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

source("./R/useful/helper_functions.R")

# Open species List
spl <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
spl$genus <- sapply(X = spl$genus, FUN = spc_to_udsc) # e.g. "cf. Tarapotomys" => "cf._Tarapotomys"

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
# Compute mean ts and te
Ts_ttl <- TsTe_ttl %>% 
  select(matches("ts")) 
Te_ttl <- TsTe_ttl %>% 
  select(matches("te"))
TsTe_ttl <- TsTe_ttl %>% 
  mutate(mean_ts = rowMeans(Ts_ttl),
         mean_te = rowMeans(Te_ttl)) %>%
  select(order, family, genus, mean_ts, mean_te) %>%
  rename(ts = "mean_ts", te = "mean_te") %>% 
  filter(ts > 24 & te < 52 & genus %in% c("Bryanpattersonia", "Palaeocladosictis") == FALSE) # artefactual genera
rm(Ts_ttl, Te_ttl)

# define a key for displaying orders
TsTe_ttl$class <- "Other_mammalia"
for(key in keys(tax_dict)){
  corr_odr <- values(tax_dict[key])
  idx <- which(TsTe_ttl$order %in% corr_odr)
  TsTe_ttl$class[idx] <- key
}
TsTe_ttl <- TsTe_ttl %>%
  mutate(class = factor(class, levels = c("Other_mammalia", "Metatheria", "Xenarthra", "Rodentia", "Other_SANUs", "Notoungulata"))) %>% 
  arrange(class, ts)
# set extent of each class
MinMax <- data.frame("Other_mammalia" = c(0, which.max(which(TsTe_ttl$class == "Other_mammalia"))+1))
for(cl in c("Metatheria", "Xenarthra", "Rodentia", "Other_SANUs", "Notoungulata")){
  corr_idx <- which(TsTe_ttl$class == cl)
  MinMax <- MinMax %>% add_column(cl = c(corr_idx[which.min(corr_idx)],
                                         corr_idx[which.max(corr_idx)]+1))
}
colnames(MinMax) <- c("Other_mammalia", "Metatheria", "Xenarthra", "Rodentia", "Other_SANUs", "Notoungulata")

# compute Jaccard's similarities through time across the five groups
JI <- data.frame(age = seq(52, 24, -0.1))
jac_idx <- function(t, cls){
  sub <- TsTe_ttl %>% filter(class == cls)
  Eoc_gen <- sub$genus[which(sub$ts >= t)]
  Olig_gen <-  sub$genus[which(sub$te <= t)]
  return(round(jaccard(Eoc_gen, Olig_gen), digits = 2))
}
for(cls in keys(tax_dict)){
  JI <- JI %>% add_column(sapply(X = seq(52, 24, -0.1), FUN = function(x){return(jac_idx(t = x, cls = cls))}))
  colnames(JI) <- c(colnames(JI)[1:length(JI)-1], cls)
}

jac_plot <- JI %>% 
  pivot_longer(cols = keys(tax_dict),
               names_to = "group",
               values_to = "jaccard") %>% 
  ggplot(aes(x = age, y = jaccard)) +
  scale_x_reverse() +
  geom_line() +
  labs(x = "Time (Ma)", y = "Jaccard's index") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32, y = 0.45, label = "EOT", size = 5, colour = "red") +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  theme(axis.title = element_text(size = 18),
        axis.text.x = element_text(size = 18, vjust = 0.2),
        axis.text.y = element_text(size = 18, hjust = 0.5),
        legend.position = "none",
        strip.text.x = element_text(size = 18),
        strip.text.y = element_text(size = 18),
        strip.background = element_rect(colour = "black", fill = "bisque2"),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            lwd = 0.35,
            center_end_labels = TRUE,
            height = unit(1, "line"),
            size = "auto") +
  facet_wrap(~group, ncol = 3)

ggsave("./figures/supp_figs/jaccard_through_time.pdf", plot = jac_plot, height = 200, width = 300, units = "mm")
