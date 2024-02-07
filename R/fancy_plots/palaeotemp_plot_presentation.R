################################################################################
# Name: palaeotemp_plot_presentation.R
# Author: Lucas Buffan
# Date: 2024-02-07
# Aim: Fancy palaeotemperature plot for Lisbon presentation
################################################################################

library(tidyverse)
library(deeptime)

Temp <- read.table("./data_2023/MBD/raw_environment_correlates/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                   sep = "\t",
                   header = TRUE)

p <- Temp %>% 
  filter(Age < 60 & Age > 20) %>% 
  ggplot(aes(x = Age, y = Temperature)) +
  geom_line(linewidth = 1, colour = "bisque2") +
  scale_x_reverse() +
  labs(x = "Time (Ma)",
       y = "Average palaeotemperature (°C)") +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) +
  annotate(geom = "text", x = 32.5, y = 35, label = "EOT", size = 10, colour = "red") +
  coord_geo(dat = "epochs", size = 6, color = "grey85", abbr = FALSE, center_end_labels = TRUE) +
  theme(axis.title = element_text(size = 18, colour = "grey85"),
        axis.line = element_line(colour = "grey85"),
        axis.ticks = element_line(colour = "grey85"),
        axis.text = element_text(size = 18, colour = "grey85"),
        panel.background = element_rect(fill='transparent'), #transparent panel bg
        plot.background = element_rect(fill='transparent', color=NA), #transparent plot bg
        panel.grid.major = element_blank(), #remove major gridlines
        panel.grid.minor = element_blank(), #remove minor gridlines
        panel.border = element_blank())

ggsave("./figures/palaeotemp.png", plot = p, width = 15, height = 7.5)
