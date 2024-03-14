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
dir <- "./results/SALMA_smoothed/genus_level/5-Ecomorphotype/"
plt_dataframe <- data.frame(Age = NA,
                            Diversity = NA,
                            min_Diversity = NA,
                            max_Diversity = NA,
                            Diet = NA)

for(ecm in c("carnivore", "herbivore", "omnivore", "insectivore")){
  ltt_tbl <- extract_ltt(paste0(dir, "/", ecm, "/LTT/per_replicate/"))
  ltt_tbl <- ltt_tbl %>%
    filter(Age > 24 & Age < 52) %>%
    add_column(Diet = ecm)
  plt_dataframe <- rbind.data.frame(plt_dataframe, ltt_tbl)
}
plt_dataframe <- plt_dataframe[-c(1),] #remove initialising row

## Actual plot -----------------------------------------------------------------
# First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

# Plot
fig3 <- ggplot(data = plt_dataframe, aes(x = Age, y = Diversity, colour = Diet)) +
  # Aesthetics
  scale_x_reverse(breaks = seq(25, 50, 5), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0,(round(max(plt_dataframe$Diversity), -1) + 10),20),
                     limits = c(0,(round(max(plt_dataframe$Diversity), -1) + 20)),
                     expand = c(0, 0)) +
  labs(x = "Time (Ma)", y = "Diversity (nb. lineages)") +
  # Time interval bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  # Climate optima bands
  annotate(geom = "rect", xmin = 51, xmax = Inf, ymin = -Inf, ymax = Inf, fill = "bisque") +
  annotate(geom = "rect", xmin = 41, xmax = 41.5, ymin = -Inf, ymax = Inf, fill = "bisque") +
  # Climate optima labels
  geom_text(aes(x = 51.45, y = 77, label = "EECO"), angle = 90, colour = "bisque4") +
  geom_text(aes(x = 41.25, y = 77, label = "MECO"), angle = 90, colour = "bisque4") +
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
  annotate(geom = "text", x = 32.7, y = 87, label = "EOT", size = 7, colour = "red") +
  # Labels
  annotate(geom = "segment", x = 46, xend = 47.5, y = 85, yend = 85, colour = "#de2d26", linewidth = 1.5) +
  annotate(geom = "text", x = 45.5, y = 85, label = "Carnivorous", hjust = 0, size = 5) +
  annotate(geom = "segment", x = 46, xend = 47.5, y = 80, yend = 80, colour = "#31a354", linewidth = 1.5) +
  annotate(geom = "text", x = 45.5, y = 80, label = "Herbivorous", hjust = 0, size = 5) +
  annotate(geom = "segment", x = 46, xend = 47.5, y = 75, yend = 75, colour = "#756bb1", linewidth = 1.5) +
  annotate(geom = "text", x = 45.5, y = 75, label = "Insectivorous", hjust = 0, size = 5) +
  annotate(geom = "segment", x = 46, xend = 47.5, y = 70, yend = 70, colour = "#2b8cbe", linewidth = 1.5) +
  annotate(geom = "text", x = 45.5, y = 70, label = "Omnivorous", hjust = 0, size = 5) +
  # Theme
  theme(axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text = element_text(size = 15),
        panel.background = element_blank(),
        legend.position = "none",
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.25)) +
  # GTS
  coord_geo(pos = list("bottom", "bottom"),
            dat = list(gsc2, gsc1),
            abbrv = list(T, F),
            center_end_labels = TRUE,
            height = unit(1.5, "line"),
            size = "auto",
            clip = "off")

## Save ------------------------------------------------------------------------
ggsave("./figures/Figure_3/Figure3.pdf",
       plot = fig3,
       height = 200,
       width = 300,
       units = "mm")

ggsave("./figures/Figure_3/Figure3.png",
       plot = fig3,
       height = 200,
       width = 300,
       units = "mm",
       dpi = 400)
