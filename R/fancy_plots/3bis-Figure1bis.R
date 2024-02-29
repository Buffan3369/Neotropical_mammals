################################################################################
# Name: 3bis-Figure1bis.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for rate comparison plot between tropical and extratropical.
################################################################################

library(tidyverse)
source("../../CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("../../CorsaiR/R/2-plotting_facilities.R")

## GEOSCALES -------------------------------------------------------------------
# First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")


## Tropical and extratropical RTT tables ---------------------------------------
rtt_trop <- extract_rtt("./results/SALMA_smoothed/genus_level/4-Tropical_Extratropical/Tropical/combined_logs/RTT_plots.r", ana = "RJMCMC")
rtt_trop$time[nrow(rtt_trop)] <- 52
rtt_etrop <- extract_rtt("./results/SALMA_smoothed/genus_level/4-Tropical_Extratropical/Extratropical/combined_logs/RTT_plots.r", ana = "RJMCMC")
rtt_trop <- rtt_trop %>% add_column(type="tropical")
rtt_etrop <- rtt_etrop %>% add_column(type="extratropical")

sp_trop <- rtt_trop %>% 
  select(time, sp_rate, sp_maxHPD, sp_minHPD, type) %>% 
  rename(rate = "sp_rate", minHPD = "sp_minHPD", maxHPD = "sp_maxHPD") %>% 
  mutate(rate_type = "Origination")
ex_trop <- rtt_trop %>% 
  select(time, ex_rate, ex_maxHPD, ex_minHPD, type) %>% 
  rename(rate = "ex_rate", minHPD = "ex_minHPD", maxHPD = "ex_maxHPD") %>% 
  mutate(rate_type = "Extinction")
sp_etrop <- rtt_etrop %>% 
  select(time, sp_rate, sp_maxHPD, sp_minHPD, type) %>% 
  rename(rate = "sp_rate", minHPD = "sp_minHPD", maxHPD = "sp_maxHPD") %>% 
  mutate(rate_type = "Origination")
ex_etrop <- rtt_etrop %>% 
  select(time, ex_rate, ex_maxHPD, ex_minHPD, type) %>% 
  rename(rate = "ex_rate", minHPD = "ex_minHPD", maxHPD = "ex_maxHPD") %>% 
  mutate(rate_type = "Extinction")
rtt <- rbind.data.frame(sp_etrop, sp_trop, ex_etrop, ex_trop)
rm(rtt_etrop, rtt_trop, sp_etrop, sp_trop, ex_etrop, ex_trop)
rtt <- rtt %>% 
  filter(time <= 52 & time >= 24)

for(col in colnames(rtt)[-which(colnames(rtt) %in% c("time", "type", "rate_type"))]){
  idx <- which(rtt[, col] > 1.3)
  if(length(idx) > 0){
    rtt[idx, col] <- 1.3
  }
  idx1 <- which(rtt[, col] < -1.3)
  if(length(idx1) > 0){
    rtt[idx1, col] <- -1.3
  }
}
# to represent origination first
rtt$rate_type <- factor(rtt$rate_type, levels = c("Origination", "Extinction"))

## Plot ------------------------------------------------------------------------
oriext <- ggplot(data = rtt, aes(x = time, y = rate)) +
  scale_x_reverse(breaks = seq(25, 50, 5), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 1.2, 0.2),
                     limits = c(0, 1.3),
                     expand = c(0, 0)) +
  labs(x = "Time (Ma)",
       y = "Rates (event/lineage/My)") +
  geom_line(aes(y = rate, colour = type)) +
  geom_ribbon(aes(x = time, ymin = minHPD, ymax = maxHPD, fill = type), alpha = 0.1) +
  scale_colour_manual(values = c("#ae017e", "#31a354")) +
  scale_fill_manual(values = c("#ae017e", "#31a354")) +
  theme(axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        axis.text = element_text(size = 15),
        legend.position = c(0.85, 0.9),
        legend.title = element_blank(),
        legend.box.background = element_rect(fill = "black", linewidth = 1),
        legend.key = element_rect(fill = "transparent"),
        strip.text.x = element_text(size = 18),
        strip.text.y = element_text(size = 18),
        strip.background = element_rect(colour = "black", fill = "bisque2"),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(pos = list("bottom", "bottom"),
                     dat = list(gsc2, gsc1),
                     abbrv = list(TRUE, FALSE),
                     center_end_labels = TRUE,
                     size = "auto",
                     height = unit(1, "line"),
                     clip = "off") +
  facet_wrap(.~rate_type)

# Save
ggsave("./figures/Figure_1/Figure1_bis.pdf",
       oriext,
       height = 170,
       width = 340,
       units = "mm")
