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
source("./R/useful/load_gts.R") # load geological timescales

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
# compute Jaccard's similarities between Eocene and Oligocene assemblages of each of or five groups
JI <- data.frame(group = keys(tax_dict),
                 jac = sapply(X = keys(tax_dict),
                              FUN = function(x){
                                sub <- TsTe_ttl %>% filter(class == x)
                                Eoc_gen <- sub$genus[which(sub$ts >= 33.9)]
                                Olig_gen <-  sub$genus[which(sub$te <= 33.9)]
                                return(round(jaccard(Eoc_gen, Olig_gen), digits = 2))
                              }))
# plot
tot_plot <- TsTe_ttl %>% 
  ggplot(aes(y = fct_inorder(genus), yend = fct_inorder(genus))) +
  # geological stages
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  # plot longevities
  geom_segment(aes(x = ts, xend = te), linewidth = 0.3) +
  scale_x_reverse(breaks = seq(from = 25, to = 50, by = 5), labels = seq(from = 25, to = 50, by = 5)) +
  labs(x = "Time (Ma)", y = "Genera") +
  # delimit groups with rectangles and add Jaccard's similarities
  # Notoungulates
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Notoungulata[1], ymax = MinMax$Notoungulata[2], fill = "#addd8e", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Notoungulata[1]+18, name = "Trigonostylops", ysize = 11) +
  annotate(geom = "text", x = 50, y = MinMax$Notoungulata[1]+5, label = "Notoungulata", size = 3) +
  annotate(geom = "text", x = 25, y = MinMax$Notoungulata[2]-4, label = paste0("J=",JI$jac[which(JI$group == "Notoungulata")]), size = 4, fontface = "bold") +
  # Other SANUs
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Other_SANUs[1], ymax = MinMax$Other_SANUs[2], fill = "#fa9fb5", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Other_SANUs[1]+16, name = "Protheosodon coniferus", ysize = 12) +
  annotate(geom = "text", x = 50, y = MinMax$Other_SANUs[1]+5, label = "Other SANUs", size = 3) +
  annotate(geom = "text", x = 25, y = MinMax$Other_SANUs[2]-4, label = paste0("J=",JI$jac[which(JI$group == "Other_SANUs")]), size = 4, fontface = "bold") +
  # Rodentia
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Rodentia[1], ymax = MinMax$Rodentia[2], fill = "#7fcdbb", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Rodentia[1]+16, name = "Spalacopus cyanus", ysize = 12) +
  annotate(geom = "text", x = 50, y = MinMax$Rodentia[1]+5, label = "Rodentia", size = 3) +
  annotate(geom = "text", x = 25, y = MinMax$Rodentia[2]-4, label = paste0("J=",JI$jac[which(JI$group == "Rodentia")]), size = 4, fontface = "bold") +
  # Xenarthra
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Xenarthra[1], ymax = MinMax$Xenarthra[2], fill = "#fec44f", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Xenarthra[1]+15, name = "Propalaehoplophorus australis", ysize = 10) +
  annotate(geom = "text", x = 50, y = MinMax$Xenarthra[1]+5, label = "Xenarthra", size = 3) +
  annotate(geom = "text", x = 25, y = MinMax$Xenarthra[2]-4, label = paste0("J=",JI$jac[which(JI$group == "Xenarthra")]), size = 4, fontface = "bold") +
  # Metatheria
  annotate(geom = "rect", xmin = -Inf, xmax = Inf, ymin = MinMax$Metatheria[1], ymax = MinMax$Metatheria[2], fill = "#bcbddc", alpha = 0.3) +
  add_phylopic(x = 50, y = MinMax$Metatheria[1]+19, name = "Marmosa", ysize = 18) +
  annotate(geom = "text", x = 50, y = MinMax$Metatheria[1]+5, label = "Metatheria", size = 3) +
  annotate(geom = "text", x = 25, y = MinMax$Metatheria[2]-4, label = paste0("J=",JI$jac[which(JI$group == "Metatheria")]), size = 4, fontface = "bold") +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32, y = nrow(TsTe_ttl)-4, label = "EOT", size = 5, colour = "red") +
  # Artificially extend plotting window
  annotate(geom = "text", x = 35, y = nrow(TsTe_ttl)+0.5, label = " ") +
  annotate(geom = "text", x = 35, y = 0.5, label = " ") +
  # GTS
  coord_geo(pos = list("bottom", "bottom", "bottom"),
            dat = list(gsc3, gsc2, gsc1),
            abbrv = list(T, T, F),
            lwd = 0.35,
            center_end_labels = TRUE,
            height = unit(0.75, "line"),
            size = "auto",
            xlim = c(53, 23.03)) +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.key=element_rect(fill="white"),
        panel.background = element_blank())

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
                    display_EECO_MECO = TRUE) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + # EOT
  annotate(geom = "segment", x = 47, xend = 50, y = 0.48, yend = 0.48, colour = "#08519c", linewidth = 1) +
  annotate(geom = "text", x = 41.5, y = 0.48, label = "Origination rate", size = 3) +
  annotate(geom = "segment", x = 47, xend = 50, y = 0.43, yend = 0.43, colour = "#a50f15", linewidth = 1) +
  annotate(geom = "text", x = 41.5, y = 0.43, label = "Extinction rate ", size = 3) +
  annotate(geom = "text", x = 30.5, y = 0.525, label = "EOT", size = 5, colour = "red") +
  geom_text(aes(x = 51.5, y = 0.35, label = "EECO"), angle = 90, colour = "bisque4") +
  geom_text(aes(x = 41.25, y = 0.35, label = "MECO"), angle = 90, colour = "bisque4") +
  annotate(geom = "text", x = 47.8, y = 0.33, label = "*", colour = "#08519c", size = 15) +
  annotate(geom = "text", x = 37.71, y = 0.33, label = "*", colour = "#08519c", size = 15) +
  annotate(geom = "text", x = 37.71, y = 0.28, label = "*", colour = "#a50f15", size = 15)

# 2) Net plot
net_plt <- rtt_plot(data = rtt_tbl,
                    type = "net",
                    x_lab = NULL,
                    y_lab = NULL,
                    y_breaks = seq(-0.2, 0.4, 0.1),
                    y_limits = c(-0.21, 0.45),
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
                    display_EECO_MECO = TRUE) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + # EOT
  annotate(geom = "segment", x = 47, xend = 50, y = 0.35, yend = 0.35, colour = "#504A4B", linewidth = 1) +
  annotate(geom = "text", x = 40.5, y = 0.35, label = "Net diversification\n rate", size = 3)

# 3) LTT
ltt_tbl <- read.table(ltt_path, header = TRUE)
ltt_tbl <- ltt_tbl %>%
  rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div) %>%
  filter(Age > 24 & Age < 52)
ltt_tbl$Age[1] <- 24
ltt_tbl$Age[nrow(ltt_tbl)] <- 52

#plot
ltt.plot <- ltt_plot(ltt_tbl,
                     stage_x_breaks = FALSE,
                     manual_x_breaks = seq(25, 50, 5),
                     axes.labelsize=15,
                     ticks.labelsize = 12,
                     x_lab = "Time (Ma)",
                     y_lab = NULL,
                     y_breaks = seq(0,(round(max(ltt_tbl$Diversity), -1) + 10),20), 
                     y_limits = c(40,(round(max(ltt_tbl$Diversity), -1) + 12)),
                     display_gts = TRUE,
                     xlim = c(52, 24),
                     avg_col = "#006d2c",
                     ribbon_col = "#74c476",
                     plot.border = FALSE,
                     x.axis = TRUE,
                     display_EECO_MECO = TRUE,
                     several_gts = TRUE,
                     geoscale = gsc1_bis,
                     geoscale2 = gsc2_bis,
                     geoscale3 = gsc3_bis,
                     geoscale_height = unit(0.75, "line"),
                     geoscale_labelsize = "auto",
                     abbr = list(TRUE, TRUE, FALSE)) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + #EOT
  annotate(geom = "segment", x = 42.5, xend = 45, y = 105, yend = 105, colour = "#006d2c", linewidth = 1) +
  annotate(geom = "text", x = 39.25, y = 105, label = "Diversity", size = 3)

plotlist <- list(rtt_plt, NULL, net_plt, NULL, ltt.plot)

fig_1 <- ggarrange(tot_plot,
                   ggarrange(plotlist = plotlist, ncol = 1, heights = c(1, 0.1, 1, 0.1, 1.3), labels = c("(B)", NA, "(C)", NA, "(D)"), hjust = -0.3), 
                   labels = c("(A)", NA), ncol = 2, heights = c(3, 3), widths = c(1.7, 1), hjust = -0.1)

ggsave("./figures/Figure_1/FINAL_FIG_1.pdf", fig_1, width = 210, height = 297, units = "mm")


## Additional quantification: number of lineages lost between the mid Eocene and the Early Oligocene
# Genera
g_48 <- ltt_tbl$Diversity[240] # age: 48.01337 Ma
g_35 <- ltt_tbl$Diversity[111] # age: 34.98260 Ma
g_32 <- ltt_tbl$Diversity[81]  # age: 32.07574 Ma
# Species
ltt_pth_sp <- "./results_EXTENDED/SALMA_smoothed/species_level/1-Full/MH_sampler/LTT/Full_EOT_sp_occ_SALMA_smoothed_12_Grj_KEEP_se_est_ltt.txt"
ltt_tbl_sp <- read.table(ltt_pth_sp, header = TRUE)
sp_48 <- ltt_tbl_sp$diversity[346] # age: 48.08234 Ma
sp_35 <- ltt_tbl_sp$diversity[216] # age: 35.03957 Ma
sp_32 <- ltt_tbl_sp$diversity[186] # age: 32.02970 Ma
  # Show the results
cat(paste0("Number of genera lost between mid-Eocene and Early Oligocene: ", round(g_48-g_32), " (", round((g_48-g_32)/g_48*100), "%)\n"))
cat(paste0("Number of genera lost 1My before and after the EOT: ", round(g_35-g_32), " (", round((g_35-g_32)/g_35*100), "%)\n"))

cat(paste0("Number of species lost between mid-Eocene and Early Oligocene: ", round(sp_48-sp_32), " (", round((sp_48-sp_32)/sp_48*100), "%)\n"))
cat(paste0("Number of species lost 1My before and after the EOT: ", round(sp_35-sp_32), " (", round((sp_35-sp_32)/sp_35*100), "%)\n"))
