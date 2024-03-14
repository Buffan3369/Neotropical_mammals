################################################################################
# Name: 7-nb_occurrences_and_q_rates.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for representing cumulative number of occurrences and estimated
#       preservation rates in the same figure.
################################################################################

library(tidyverse)
library(deeptime)
library(ggpubr)
library(pammtools)
library(readxl)

gsc1 <- deeptime::epochs %>% filter(min_age <= 56)
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
gsc3 <- read_xlsx("./data_2023/time_bins/SALMA_EOT.xlsx")
gsc3 <- gsc3 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
gsc3$min_age <- sapply(gsc3$min_age, as.numeric)
gsc3$max_age <- sapply(gsc3$max_age, as.numeric)

## Function to assess number of occurrences through time -----------------------
occ_through_time <- function(data, what="occ"){ 
  #what="occ" => occurrence count
  #what="div_gen" => genus count
  #what="div_spec" => species count
  if(what == "div_gen"){
    data <- data %>%
      group_by(genus, min_ma, max_ma) %>%
      distinct(genus) %>% 
      ungroup()
  }
  else if(what == "div_spec"){
    data <- data %>%
      group_by(accepted_name, min_ma, max_ma) %>%
      distinct(accepted_name) %>% 
      ungroup()
  }
  max_ma_count <- data %>% count(max_ma)
  min_ma_count <- data %>% count(min_ma)
  
  time_ttl <- unique(sort(c(max_ma_count$max_ma, min_ma_count$min_ma), decreasing = TRUE))
  
  cumul_occ <- c(0)
  for(i in 1:length(time_ttl)){
    t <- time_ttl[i]
    N <- cumul_occ[i] #previous
    if(t %in% max_ma_count$max_ma == FALSE){ #necessarily in min_ma_count only
      idx <- which(min_ma_count$min_ma == t)
      cumul_occ <- c(cumul_occ, (N - min_ma_count$n[idx])) #counmin_mad negatively, min age of the occ(s)
    }
    else if(t %in% min_ma_count$min_ma == FALSE){ #necessarily in max_ma_count only
      idx <- which(max_ma_count$max_ma == t)
      cumul_occ <- c(cumul_occ, (N + max_ma_count$n[idx])) #counted positively, max age of the occ(s)
    }
    else{ #t both in min and max ages
      idx_min <- which(min_ma_count$min_ma == t)
      idx_max <- which(max_ma_count$max_ma == t)
      cumul_occ <- c(cumul_occ, rep((N + max_ma_count$n[idx_max] - min_ma_count$n[idx_min]), length(idx_max))) #birth - death
    }
  }
  return(list(time_ttl, cumul_occ))
}

## RAW DATA --------------------------------------------------------------------
occ_raw <- read.csv("./data_2023/SPECIES_LISTS/1-Raw_Cnz_SA_Mammals.csv", header = TRUE)
L <- occ_through_time(occ_raw)
cumul_occ <- data.frame(time = c(L[[1]][1], L[[1]]),
                        nb_occ = L[[2]],
                        salma = "raw")

## SALMA KEPT ------------------------------------------------------------------
occ_kept <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
L_kept <- occ_through_time(occ_kept)
cumul_occ <- rbind.data.frame(cumul_occ,
                              data.frame(time = c(L_kept[[1]][1], L_kept[[1]]),
                                         nb_occ = L_kept[[2]],
                                         salma = "kept"))

## SMOOTHED --------------------------------------------------------------------
occ_smoothed <- readRDS("./data_2023/SPECIES_LISTS/8-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS")
L_smoothed <- occ_through_time(data = occ_smoothed)

cumul_occ <- rbind.data.frame(cumul_occ,
                              data.frame(time = c(L_smoothed[[1]][1], L_smoothed[[1]], 23.2),
                                         nb_occ = c(L_smoothed[[2]], 610), #for plotting
                                         salma = "smoothed"))
## PLOT ------------------------------------------------------------------------
cumul_occ$salma <- factor(cumul_occ$salma, levels = c("raw", "kept", "smoothed"))
strip_labs <- c( "Raw PBDB data", "SALMA kept", "SALMA smoothed")
names(strip_labs) <- c( "raw", "kept", "smoothed")

  # Total cumulated occurrences
cumul_tot <- cumul_occ %>%
  filter(time <= 60 & time >= 16) %>% 
  ggplot(aes(x = time, y = nb_occ, colour = salma)) +
  scale_x_reverse() +
  scale_y_continuous(limits = c(0, 1630)) +
  geom_line(linewidth = 2) +
  geom_point(colour = "black") +
  scale_colour_manual(values = c( "#02818a", "#d95f0e", "#54278f")) +
  labs(x = "Time (Ma)",
       y = "Cumulative number of occurrences") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  coord_geo(pos = list("bottom", "bottom", "bottom"),
            dat = list(gsc3, gsc2, gsc1),
            abbrv = list(TRUE, TRUE, FALSE),
            height = unit(1.5, "line"),
            center_end_labels = TRUE,
            size = "auto") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  facet_wrap(.~salma,
             labeller = labeller(salma = strip_labs))
ggsave("./figures/supp_figs/Occurrence_q_rates/total_cumulative_occurrences.pdf",
       cumul_tot,
       height = 200,
       width = 450,
       units = "mm")
ggsave("./figures/supp_figs/Occurrence_q_rates/total_cumulative_occurrences.png",
       cumul_tot,
       height = 200,
       width = 450,
       units = "mm",
       dpi = 400)
  
  # restricted to the EOT and without raw
strip_labs <- c("SALMA kept", "SALMA smoothed")
names(strip_labs) <- c("kept", "smoothed")

cumul_plot_restricted <- cumul_occ %>% 
  filter(time >= 23.03 & time <= 56 & salma != "raw") %>%
  ggplot(aes(x = time, y = nb_occ, colour = salma)) +
  scale_x_reverse() +
  scale_y_continuous(limits = c(0, 650)) +
  geom_line(linewidth = 2) +
  scale_colour_manual(values = c("#d95f0e", "#54278f")) +
  labs(x = NULL,
       y = "Cumulative number of occurrences") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  coord_geo(pos = list("bottom", "bottom", "bottom"),
            dat = list(gsc3, gsc2, gsc1),
            abbrv = list(TRUE, TRUE, FALSE),
            height = unit(1.5, "line"),
            center_end_labels = TRUE,
            size = "auto") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  facet_wrap(.~salma,
             labeller = labeller(salma = strip_labs))
  
  # occ number relative to generic diversity
L_div_kept <- occ_through_time(occ_kept, what = "div_gen")
L_div_smoothed <- occ_through_time(occ_smoothed, what = "div_gen")

Div_tot <- c(L_div_kept[[2]], L_div_smoothed[[2]])
Occ_tot <- c(L_kept[[2]], L_smoothed[[2]])

Norm_tot <- sapply(X = 1:length(Div_tot), 
                   FUN = function(x){
                     occ <- Occ_tot[x]
                     div <- Div_tot[x]
                     if(div == 0){
                       return(0)
                     }
                     else{
                       return(occ / div)
                     }
                   })
cumul_occ_norm <- data.frame(time = c(L_kept[[1]][1], L_kept[[1]], L_smoothed[[1]][1], L_smoothed[[1]]),
                             norm_occ = Norm_tot,
                             salma = c(rep("kept", length(L_div_kept[[2]])), rep("smoothed", length(L_div_smoothed[[2]]))))
    #proper plot
cumul_diversity_restricted <- cumul_occ_norm %>% 
  filter(time >= 23.03 & time <= 56) %>%
  ggplot(aes(x = time, y = norm_occ, colour = salma)) +
  scale_x_reverse() +
#  scale_y_continuous(limits = c(0, 650)) +
  geom_line(linewidth = 2) +
  scale_colour_manual(values = c("#d95f0e", "#54278f")) +
  labs(x = NULL,
       y = "Cumulative nb. of occurrences / gen. richness") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  coord_geo(pos = list("bottom", "bottom", "bottom"),
            dat = list(gsc3, gsc2, gsc1),
            abbrv = list(TRUE, TRUE, FALSE),
            height = unit(1.5, "line"),
            center_end_labels = TRUE,
            size = "auto") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  facet_wrap(.~salma,
             labeller = labeller(salma = strip_labs))

cumul_diversity_restricted

## Q_rates ---------------------------------------------------------------------
kept_q <- read.table("./results/SALMA_kept/genus_level/1-Full/Q_SHIFTS/Parsed_Q_rates.csv", header = TRUE)
kept_q$salma <- "kept"
kept_q[nrow(kept_q)+1, ] <- kept_q[nrow(kept_q), ]
kept_q$Age[nrow(kept_q)] <- 23.03

smoothed_q <- read.table("./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/Q_SHIFTS/Parsed_Q_rates.csv", header = TRUE)
smoothed_q$salma <- "smoothed"
smoothed_q[nrow(smoothed_q)+1, ] <- smoothed_q[nrow(smoothed_q), ]
smoothed_q$Age[nrow(smoothed_q)] <- 23.03

Q_data <- rbind.data.frame(kept_q, smoothed_q)

q_plots <- Q_data %>%
  filter(Age <= 56) %>% 
  ggplot(aes(x = Age, y = mean_Q, fill = salma, colour = salma)) +
  scale_x_reverse() +
  geom_stepribbon(aes(x = Age, ymin = min_HPD, ymax = max_HPD),
                  colour = "white",
                  linewidth = 0,
                  alpha = 0.2) +
  geom_step(linewidth = 1) +
  scale_fill_manual(values = c("#d94801", "#807dba")) +
  scale_colour_manual(values = c("#7f2704", "#54278f")) +
  labs(x = "Time (Ma)",
       y = "Preservation rate (occ/lineage/My)") +
  theme(axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20),
        legend.position = "None",
        panel.background = element_blank()) +
  coord_geo(pos = list("bottom", "bottom", "bottom"),
            dat = list(gsc3, gsc2, gsc1),
            abbrv = list(TRUE, TRUE, FALSE),
            height = unit(1.5, "line"),
            center_end_labels = TRUE,
            size = "auto") +
  facet_wrap(.~salma,
             labeller = labeller(salma = strip_labs))

## arrange and save

p <- ggarrange(cumul_plot_restricted, q_plots, ncol = 1, labels = c("(A)", "(B)"), font.label = list(size = 18))
ggsave("./figures/supp_figs/Occurrence_q_rates/cumulative_occ_and_preservation.pdf",
       plot = p,
       height = 350,
       width = 450,
       unit = "mm")
ggsave("./figures/supp_figs/Occurrence_q_rates/cumulative_occ_and_preservation.png",
       plot = p,
       height = 350,
       width = 450,
       unit = "mm",
       dpi = 400)

p_norm <- ggarrange(cumul_diversity_restricted, q_plots, ncol = 1, labels = c("(A)", "(B)"), font.label = list(size = 18))
ggsave("./figures/supp_figs/Occurrence_q_rates/cumulative_norm_occ_and_preservation.pdf",
       plot = p_norm,
       height = 350,
       width = 450,
       unit = "mm")
ggsave("./figures/supp_figs/Occurrence_q_rates/cumulative_norm_occ_and_preservation.png",
       plot = p_norm,
       height = 350,
       width = 450,
       unit = "mm",
       dpi = 400)

