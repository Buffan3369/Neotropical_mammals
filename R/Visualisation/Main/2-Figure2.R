################################################################################
# Name: 5-LTT_per_guilds.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for multiple LTT plot per ecomorphotypes.
################################################################################

## Source helper functions from CorsaiR and additional facilities --------------
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library("readxl")
library("hash")
library("tidyverse")
library("ggpubr")

## Generate plotting dataframe -------------------------------------------------
dir <- "./results_EXTENDED/SALMA_smoothed/genus_level/5-Ecomorphotype"
plt_dataframe <- data.frame(Age = NA,
                            Diversity = NA,
                            min_Diversity = NA,
                            max_Diversity = NA,
                            Diet = NA)

for(ecm in c("carnivore", "herbivore", "omnivore", "insectivore")){
  ltt_tbl <- read.table(paste0(dir, "/TsTe_", ecm, "_SALMA_smoothed_genus_level_ltt.txt"), header = TRUE)
  ltt_tbl <- ltt_tbl %>%
    rename(Age = "time", Diversity = "diversity", min_Diversity = "m_div", max_Diversity = "M_div") %>%
    filter(Age > 24 & Age < 52) %>%
    add_column(Diet = ecm)
  plt_dataframe <- rbind.data.frame(plt_dataframe, ltt_tbl)
}
plt_dataframe <- plt_dataframe[-c(1),] #remove initialising row

## Pie charts ------------------------------------------------------------------
  # Early Eocene
EE_taxo <- plt_dataframe %>% 
  filter(Age <= 56 & Age >= 47.8) %>%
  select(Age, Diversity, Diet) %>%
  pivot_wider(names_from = Diet, values_from = Diversity) 
EE_taxo <- EE_taxo %>% 
  add_row(Age=51.9, carnivore=mean(EE_taxo$carnivore, na.rm = TRUE), herbivore=mean(EE_taxo$herbivore, na.rm = TRUE), 
          insectivore=mean(EE_taxo$insectivore, na.rm = TRUE), omnivore=mean(EE_taxo$omnivore, na.rm = TRUE))
  # Mid Eocene
ME_taxo <- plt_dataframe %>% 
  filter(Age <= 47.8 & Age >= 37.71) %>%
  select(Age, Diversity, Diet) %>%
  pivot_wider(names_from = Diet, values_from = Diversity) 
ME_taxo <- ME_taxo %>% 
  add_row(Age=42.7, carnivore=mean(ME_taxo$carnivore, na.rm = TRUE), herbivore=mean(ME_taxo$herbivore, na.rm = TRUE), 
          insectivore=mean(ME_taxo$insectivore, na.rm = TRUE), omnivore=mean(ME_taxo$omnivore, na.rm = TRUE))
  # Late Eocene
LE_taxo <- plt_dataframe %>% 
  filter(Age <= 37.71 & Age >= 33.9) %>%
  select(Age, Diversity, Diet) %>%
  pivot_wider(names_from = Diet, values_from = Diversity) 
LE_taxo <- LE_taxo %>% 
  add_row(Age=35.8, carnivore=mean(LE_taxo$carnivore, na.rm = TRUE), herbivore=mean(LE_taxo$herbivore, na.rm = TRUE), 
          insectivore=mean(LE_taxo$insectivore, na.rm = TRUE), omnivore=mean(LE_taxo$omnivore, na.rm = TRUE))
  # Early Oligocene
EO_taxo <- plt_dataframe %>% 
  filter(Age <= 33.9 & Age >= 27.8) %>%
  select(Age, Diversity, Diet) %>%
  pivot_wider(names_from = Diet, values_from = Diversity) 
EO_taxo <- EO_taxo %>% 
  add_row(Age=30.9, carnivore=mean(EO_taxo$carnivore, na.rm = TRUE), herbivore=mean(EO_taxo$herbivore, na.rm = TRUE), 
          insectivore=mean(EO_taxo$insectivore, na.rm = TRUE), omnivore=mean(EO_taxo$omnivore, na.rm = TRUE))
  # Late Oligocene
LO_taxo <- plt_dataframe %>% 
  filter(Age <= 27.8 & Age >= 23.03) %>%
  select(Age, Diversity, Diet) %>%
  pivot_wider(names_from = Diet, values_from = Diversity) 
LO_taxo <- LO_taxo %>% 
  add_row(Age=25.4, carnivore=mean(LO_taxo$carnivore, na.rm = TRUE), herbivore=mean(LO_taxo$herbivore, na.rm = TRUE), 
          insectivore=mean(LO_taxo$insectivore, na.rm = TRUE), omnivore=mean(LO_taxo$omnivore, na.rm = TRUE))
  # Data frame containing all proportions
    #for plot
count_df <- data.frame(epoch = c("Eocene", "Eocene", "Oliogcene", "Oligocene"),
                      stage = c("Lower", "Upper", "Lower", "Upper"),
                      carnivore = c(ME_taxo$carnivore[nrow(ME_taxo)], LE_taxo$carnivore[nrow(LE_taxo)], EO_taxo$carnivore[nrow(EO_taxo)], LO_taxo$carnivore[nrow(LO_taxo)]),
                      herbivore = c(ME_taxo$herbivore[nrow(ME_taxo)], LE_taxo$herbivore[nrow(LE_taxo)], EO_taxo$herbivore[nrow(EO_taxo)], LO_taxo$herbivore[nrow(LO_taxo)]),
                      omnivore = c(ME_taxo$omnivore[nrow(ME_taxo)], LE_taxo$omnivore[nrow(LE_taxo)], EO_taxo$omnivore[nrow(EO_taxo)], LO_taxo$omnivore[nrow(LO_taxo)]),
                      insectivore = c(ME_taxo$insectivore[nrow(ME_taxo)], LE_taxo$insectivore[nrow(LE_taxo)], EO_taxo$insectivore[nrow(EO_taxo)], LO_taxo$insectivore[nrow(LO_taxo)]))
    #for Bray-Curtis computation
count_df1 <- data.frame(stage = c("Early_Eocene", "Mid_Eocene", "Late_Eocene", "Early_Oliogcene", "Late_Oligocene"),
                        carnivore = c(EE_taxo$carnivore[nrow(EE_taxo)], ME_taxo$carnivore[nrow(ME_taxo)], LE_taxo$carnivore[nrow(LE_taxo)], EO_taxo$carnivore[nrow(EO_taxo)], LO_taxo$carnivore[nrow(LO_taxo)]),
                        herbivore = c(EE_taxo$herbivore[nrow(EE_taxo)], ME_taxo$herbivore[nrow(ME_taxo)], LE_taxo$herbivore[nrow(LE_taxo)], EO_taxo$herbivore[nrow(EO_taxo)], LO_taxo$herbivore[nrow(LO_taxo)]),
                        omnivore = c(EE_taxo$omnivore[nrow(EE_taxo)], ME_taxo$omnivore[nrow(ME_taxo)], LE_taxo$omnivore[nrow(LE_taxo)], EO_taxo$omnivore[nrow(EO_taxo)], LO_taxo$omnivore[nrow(LO_taxo)]),
                        insectivore = c(EE_taxo$insectivore[nrow(EE_taxo)], ME_taxo$insectivore[nrow(ME_taxo)], LE_taxo$insectivore[nrow(LE_taxo)], EO_taxo$insectivore[nrow(EO_taxo)], LO_taxo$insectivore[nrow(LO_taxo)]))
count_df1 <- count_df1 %>%
  pivot_longer(!c(stage),  names_to = "diet", values_to = "diversity")
rm(ME_taxo, LE_taxo, EO_taxo, LO_taxo)
  # switch to proportions
mat <- as.matrix(count_df %>% select(carnivore, herbivore, omnivore, insectivore))
prop_mat <- t(apply(X = mat, MARGIN = 1, FUN = function(x){return(x/sum(x))}))
prop_df <- cbind.data.frame(count_df[,c("epoch", "stage")], data.frame(prop_mat)) %>% 
  pivot_longer(!c(epoch, stage),  names_to = "diet", values_to = "diversity")
  # Plots
    # Early Eocene
ee_only <- count_df1 %>% 
  subset(stage == "Early_Eocene") %>% 
  mutate(prop = sapply(X = diversity, FUN = function(x){return(x/sum(diversity))}))
ee_pie <- ee_only %>% 
  ggplot(aes(x = "", y = prop, fill = diet)) +
  geom_bar(stat = "identity") +
  coord_polar("y") +
  scale_fill_manual(values = c("#de2d26", "#31a354", "#756bb1", "#2b8cbe")) +
  theme_minimal() +
  theme(axis.line = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank())
ggsave("./figures/Figure_2/early_eocene.pdf", ee_pie, height = 100, width = 100, units = "mm")
    # facet
int.labs <- c("Eocene", "Oligocene")
names(int.labs) <- c("Eocene", "Oligocene")
stg.labs <- c("Upper", "Lower")
names(stg.labs) <- c("Upper", "Lower")
pie_charts <- prop_df %>% 
  mutate(diet = factor(diet, levels = c("carnivore", "herbivore", "insectivore", "omnivore"))) %>%
  ggplot(aes(x = "", y = diversity, fill = diet)) +
  geom_bar(stat = "identity") +
  coord_polar("y") +
  scale_fill_manual(values = c("#de2d26", "#31a354", "#756bb1", "#2b8cbe")) +
  facet_wrap(epoch~stage, labeller = labeller(epoch=int.labs, stage=stg.labs)) +
  theme_minimal() +
  theme(axis.line = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank())
ggsave("./figures/Figure_2/pie_charts.pdf", height = 200, width = 200, units = "mm")
  # Compute Bray-Curtis pairwise assemblage dissimilarities
BC_matrix <- matrix(nrow = 5, ncol = 5)
stages <- c("Early_Eocene", "Mid_Eocene", "Late_Eocene", "Early_Oliogcene", "Late_Oligocene")
for(stg in stages){
  a1 <- count_df1 %>% 
    filter(stage == stg) %>% 
    select(diet, diversity)
  BC <- c()
  for(stg1 in stages){
    a2 <- count_df1 %>% 
      filter(stage == stg1) %>% 
      select(diet, diversity)
    BC <- c(BC, bray_curtis(a1, a2, round=TRUE, d=3))
  }
  i <- which(stages == stg)
  BC_matrix[,i] <- BC
}
BC_df <- data.frame(BC_matrix)
colnames(BC_df) <- stages
row.names(BC_df) <- stages
write.table(BC_df, "./figures/Figure_2/Bray_Curtis_ecological_dissimilarities.txt", sep = "\t")

BC_df1 <- BC_df
row.names(BC_df1) <- 1:nrow(BC_df1)
colnames(BC_df1) <- c("1-Early_Eocene", "2-Mid_Eocene", "3-Late_Eocene", "4-Early_Oliogcene", "5-Late_Oligocene")
BC_df1$stage <- factor(x=c("Early_Eocene", "Mid_Eocene", "Late_Eocene", "Early_Oliogcene", "Late_Oligocene"), 
                       levels = c("Early_Eocene", "Mid_Eocene", "Late_Eocene", "Early_Oliogcene", "Late_Oligocene"))
hm <- BC_df1 %>%
  pivot_longer(!(stage), names_to = "period", values_to = "BC_idx") %>% 
  ggplot(aes(x=period, y=stage, fill=BC_idx)) +
  geom_tile() +
  scale_x_discrete(labels = c("Early Eocene", "Middle Eocene", "Late Eocene", "Early Oliogcene", "Late Oligocene")) +
  scale_y_discrete(labels = c("Early Eocene", "Middle Eocene", "Late Eocene", "Early Oliogcene", "Late Oligocene")) +
  scale_fill_gradient(low = "white", high = "#ef3b2c") +
  coord_fixed() + # keep squared
  geom_text(aes(label = BC_idx), size=2) +
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text = element_text(size = 8),
        panel.border = element_rect(fill="transparent"))
ggsave("./figures/Figure_2/Bray_Curtis_heatmap.pdf", hm, height = 100, width = 100, units="mm")
## Actual plot -----------------------------------------------------------------
source("./R/useful/load_gts.R") # load geological timescales
# Plot
fig2 <- ggplot(data = plt_dataframe, aes(x = Age, y = Diversity, colour = Diet)) +
  # Aesthetics
  scale_x_reverse(breaks = seq(25, 50, 5), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0,(round(max(plt_dataframe$Diversity), -1) + 10),20),
                     limits = c(0,(round(max(plt_dataframe$Diversity), -1) + 25)),
                     expand = c(0, 0)) +
  labs(x = "Time (Ma)", y = "Diversity (nb. lineages)") +
  # Time interval bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  # Climate optima bands
  # annotate(geom = "rect", xmin = 51, xmax = Inf, ymin = -Inf, ymax = Inf, fill = "bisque") +
  # annotate(geom = "rect", xmin = 41, xmax = 41.5, ymin = -Inf, ymax = Inf, fill = "bisque") +
  # Climate optima labels
  # geom_text(aes(x = 51.45, y = 77, label = "EECO"), angle = 90, colour = "bisque4") +
  # geom_text(aes(x = 41.25, y = 77, label = "MECO"), angle = 90, colour = "bisque4") +
  # Lines
  geom_line(aes(x = Age, y = Diversity, color = Diet), linewidth = 1) +
  # Line colours
  scale_colour_manual(values = c("#de2d26", "#31a354", "#756bb1", "#2b8cbe")) +
  # Ribbons
  geom_ribbon(aes(x = Age, ymin = min_Diversity, ymax = max_Diversity, fill = Diet),
              alpha = 0.5, colour = NA) +
  # Ribbon colours
  scale_fill_manual(values = c("#de2d26", "#31a354", "#756bb1", "#2b8cbe")) +
  # EOT line
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32.7, y = 92, label = "EOT", size = 7, colour = "red") +
  # Labels
  annotate(geom = "segment", x = 51.7, xend = 50.5, y = 92.5, yend = 92.5, colour = "#de2d26", linewidth = 1.5) +
  annotate(geom = "text", x = 50.3, y = 92.5, label = "Carnivorous", hjust = 0, size = 4) +
  annotate(geom = "segment", x = 51.7, xend = 50.5, y = 90, yend = 90, colour = "#31a354", linewidth = 1.5) +
  annotate(geom = "text", x = 50.3, y = 90, label = "Herbivorous", hjust = 0, size = 4) +
  annotate(geom = "segment", x = 51.7, xend = 50.5, y = 87.5, yend = 87.5, colour = "#756bb1", linewidth = 1.5) +
  annotate(geom = "text", x = 50.3, y = 87.5, label = "Insectivorous", hjust = 0, size = 4) +
  annotate(geom = "segment", x = 51.7, xend = 50.5, y = 85, yend = 85, colour = "#2b8cbe", linewidth = 1.5) +
  annotate(geom = "text", x = 50.3, y = 85, label = "Omnivorous", hjust = 0, size = 4) +
  # Theme
  theme(axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text = element_text(size = 15),
        panel.background = element_blank(),
        legend.position = "none",
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.25)) +
  # GTS
  coord_geo(pos = list("bottom", "bottom", "bottom"),
            dat = list(gsc3_bis, gsc2_bis, gsc1_bis),
            abbrv = list(T, T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            clip = "off")

## Save ------------------------------------------------------------------------
ggsave("./figures/Figure_2/LTT_per_guilds.pdf",
       plot = fig2,
       height = 200,
       width = 300,
       units = "mm")
