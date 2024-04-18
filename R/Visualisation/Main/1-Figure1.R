################################################################################
# Name: 1-Figure1.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 1, faunal turnover across all mammals + RTT
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(rphylopic)
library(readxl)

source("./R/useful/helper_functions.R")

## 1-LONGEVITY PLOT ------------------------------------------------------------

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
  filter(ts > 24 & te < 52 & genus %in% c("Bryanpattersonia", "Palaeocladosictis") == FALSE)
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
# plot
tot_plot <- TsTe_ttl %>% 
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  # geological stages
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  # plot longevities
  geom_segment(aes(x = ts, xend = te), linewidth = 0.3) +
  scale_x_reverse(breaks = seq(from = 23, to = 50, by = 5), labels = seq(from = 23, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genus") +
  # delimit groups with rectangles
     # Notoungulates
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Notoungulata[1], ymax = MinMax$Notoungulata[2], fill = "#addd8e", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Notoungulata[1]+18, name = "Trigonostylops", ysize = 11) +
  annotate(geom = "text", x = 50, y = MinMax$Notoungulata[1]+5, label = "Notoungulata", size = 3) +
  # Other SANUs
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Other_SANUs[1], ymax = MinMax$Other_SANUs[2], fill = "#fa9fb5", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Other_SANUs[1]+16, name = "Protheosodon coniferus", ysize = 12) +
  annotate(geom = "text", x = 50, y = MinMax$Other_SANUs[1]+5, label = "Other SANUs", size = 3) +
    # Rodentia
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Rodentia[1], ymax = MinMax$Rodentia[2], fill = "#7fcdbb", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Rodentia[1]+16, name = "Spalacopus cyanus", ysize = 12) +
  annotate(geom = "text", x = 50, y = MinMax$Rodentia[1]+5, label = "Rodentia", size = 3) +
    # Xenarthra
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Xenarthra[1], ymax = MinMax$Xenarthra[2], fill = "#fec44f", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Xenarthra[1]+15, name = "Propalaehoplophorus australis", ysize = 10) +
  annotate(geom = "text", x = 50, y = MinMax$Xenarthra[1]+5, label = "Xenarthra", size = 3) +
    # Metatheria
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Metatheria[1], ymax = MinMax$Metatheria[2], fill = "#bcbddc", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Metatheria[1]+19, name = "Marmosa", ysize = 18) +
  annotate(geom = "text", x = 50, y = MinMax$Metatheria[1]+5, label = "Metatheria", size = 3) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32, y = nrow(TsTe_ttl)-4, label = "EOT", size = 7, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_ttl)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            xlim = c(23.03, 53)) +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.key=element_rect(fill="white"))

## Display diversification rates -----------------------------------------------
  # 1) RTT plot
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
rtt_path <- "./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/BDS/combined_logs/combined_10_marginal_rates_RTT.r"
ltt_path <- "./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/LTT/Full_EOT_gen_occ_SALMA_smoothed_10_Grj_KEEP_se_est_ltt.txt"
# deviation for BDS rates
delta <- 0.3
# plot list
plot_list1 <- list()
# rtt plot
rtt_tbl <- extract_rtt(rtt_path, ana = "BDS")
# restrict plotting window
rtt_tbl <- rtt_tbl %>% filter(time > 24 & time <= 52)
# adjustments for plotting window
rtt_tbl$time[1] <- 24
rtt_tbl$time[nrow(rtt_tbl)] <- 52
# adjust age of shifts
rtt_tbl$time[which(rtt_tbl$time == 49)] <- 47.8 + delta
rtt_tbl$time[which(rtt_tbl$time == 48)] <- 47.8 - delta
rtt_tbl$time[which(rtt_tbl$time == 39)] <- 37.71 + delta
rtt_tbl$time[which(rtt_tbl$time == 38)] <- 37.71 - delta
rtt_tbl$time[which(rtt_tbl$time == 35)] <- 33.9 + delta
rtt_tbl$time[which(rtt_tbl$time == 34)] <- 33.9 - delta
rtt_tbl$time[which(rtt_tbl$time == 29)] <- 27.8 + delta
rtt_tbl$time[which(rtt_tbl$time == 28)] <- 27.8 - delta
# proper plot
rtt_plt <- rtt_plot(data = rtt_tbl,
                    type = "SpEx",
                    y_limits = c(0, 0.55),
                    x_lab = NULL,
                    y_lab = NULL,
                    stage_x_breaks = FALSE,
                    manual_x_breaks = seq(25, 50, 5),
                    y_breaks = seq(0, 0.5, 0.1),
                    axes.labelsize=15,
                    ticks.labelsize = 12,
                    restrict_y = TRUE,
                    restrict_thr = 0.55,
                    ori_col="#08519c",
                    ext_col="#a50f15",
                    display_gts = FALSE,
                    xlim = c(52, 24),
                    plot.border = FALSE,
                    x.axis = FALSE,
                    display_EECO_MECO = TRUE,
                    several_gts = TRUE,
                    geoscale2 = gsc2,
                    geoscale_height = unit(1, "line"),
                    abbr = list(TRUE, FALSE)) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + # EOT
  annotate(geom = "segment", x = 47, xend = 50, y = 0.5, yend = 0.5, colour = "#08519c", linewidth = 1) +
  annotate(geom = "text", x = 41.5, y = 0.5, label = "Origination rate", size = 3) +
  annotate(geom = "segment", x = 47, xend = 50, y = 0.47, yend = 0.47, colour = "#a50f15", linewidth = 1) +
  annotate(geom = "text", x = 41.5, y = 0.47, label = "Extinction rate ", size = 3) +
  annotate(geom = "text", x = 30.5, y = 0.525, label = "EOT", size = 7, colour = "red") +
  geom_text(aes(x = 51.5, y = 0.35, label = "EECO"), angle = 90, colour = "bisque4") +
  geom_text(aes(x = 41.25, y = 0.35, label = "MECO"), angle = 90, colour = "bisque4") +
  annotate(geom = "text", x = 47.8, y = 0.33, label = "*", colour = "#08519c", size = 18) +
  annotate(geom = "text", x = 37.71, y = 0.33, label = "*", colour = "#08519c", size = 18) +
  annotate(geom = "text", x = 37.71, y = 0.28, label = "*", colour = "#a50f15", size = 18)

  # 2) Net plot
net_plt <- rtt_plot(data = rtt_tbl,
                    type = "net",
                    x_lab = NULL,
                    y_lab = NULL,
                    y_breaks = seq(-0.5, 0.5, 0.1),
                    y_limits = c(-0.55, 0.55),
                    restrict_thr = 0.55,
                    stage_x_breaks = FALSE,
                    manual_x_breaks = seq(25, 50, 5),
                    axes.labelsize=15,
                    ticks.labelsize = 12,
                    net_col="#252525",
                    display_gts = FALSE,
                    xlim = c(52, 24),
                    plot.border = FALSE,
                    x.axis = FALSE,
                    display_EECO_MECO = TRUE,
                    several_gts = TRUE,
                    geoscale2 = gsc2,
                    geoscale_height = unit(1, "line"),
                    abbr = list(TRUE, FALSE)) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + # EOT
  annotate(geom = "segment", x = 47, xend = 50, y = 0.4, yend = 0.4, colour = "#504A4B", linewidth = 1) +
  annotate(geom = "text", x = 40.5, y = 0.4, label = "Net diversification\n rate", size = 3)

  # 3) LTT
ltt_tbl <- read.table(ltt_path, header = TRUE)
ltt_tbl <- ltt_tbl %>%
  rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div) %>%
  filter(Age > 24 & Age < 52)
ltt_tbl$Age[1] <- 24
ltt_tbl$Age[nrow(ltt_tbl)] <- 52
# plot
ltt.plot <- ltt_plot(ltt_tbl,
                     stage_x_breaks = FALSE,
                     manual_x_breaks = seq(25, 50, 5),
                     axes.labelsize=15,
                     ticks.labelsize = 12,
                     x_lab = "Time (Ma)",
                     y_lab = NULL,
                     y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                     y_limits = c(0,(round(max(ltt_tbl$Diversity), -1) + 22)),
                     display_gts = TRUE,
                     xlim = c(52, 24),
                     avg_col = "#006d2c",
                     ribbon_col = "#74c476",
                     plot.border = FALSE,
                     x.axis = TRUE,
                     display_EECO_MECO = TRUE,
                     several_gts = TRUE,
                     geoscale2 = gsc2,
                     geoscale_height = unit(1, "line"),
                     geoscale_labelsize = 4,
                     abbr = list(TRUE, FALSE)) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + #EOT
  annotate(geom = "segment", x = 42.5, xend = 45, y = 110, yend = 110, colour = "#006d2c", linewidth = 1) +
  annotate(geom = "text", x = 39.25, y = 110, label = "Diversity", size = 3)

plotlist <- list(rtt_plt, NULL, net_plt, NULL, ltt.plot)

fig_1 <- ggarrange(tot_plot,
          ggarrange(plotlist = plotlist, ncol = 1, heights = c(1, 0.1, 1, 0.1, 1.3), labels = c("(B)", NA, "(C)", NA, "(D)"), hjust = -0.3), 
          labels = c("(A)", NA), ncol = 2, heights = c(3, 3), widths = c(1.7, 1), hjust = -0.1)

ggsave("./figures/Figure_1/FINAL_FIG_1.pdf", fig_1, width = 210, height = 297, units = "mm")
