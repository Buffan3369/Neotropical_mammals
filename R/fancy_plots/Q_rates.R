################################################################################
######################## Plot preservation rates ###############################
################################################################################

library(ggplot2)
library(pammtools)
library(deeptime)

## Set Cenozoic epochs dataset for plotting facilities -------------------------
cnz_epochs <- deeptime::epochs[1:7, ]
cnz_epochs$abbr <- c("H", "Ple", "Pli", "Miocene", "Oligocene", "Eocene", "Palaeocene")

## Full ------------------------------------------------------------------------
Q_rates <- read.csv("../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch/Q_shifts/all_in_one/Parsed_Q_rates.csv")
Q_rates$Age <- c(66, 56, 33.9, 23.03, 5.33, 2.58, 0.01)
  #restrict holocene preservation to 6.5 for plotting
Q_rates$mean_Q[7] <- 6.5
Q_rates$mean_Q[7] <- 6.5
Q_rates$mean_Q[7] <- 6.5

Q_plot <- ggplot(data = Q_rates, aes(x = Age, y = mean_Q))+
  scale_x_reverse(breaks = c(2.58, 5.33, 15.97, 23.03, 27.82, 33.9, 56, 66)) +
  scale_y_continuous(breaks = seq(from = 0, to = 6, by = 0.5),
                     limits = c(0, 6)) +
  annotate("rect", xmin = 56, xmax = 66, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
  annotate("rect", xmin = 23.03, xmax = 33.9, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
  annotate("rect", xmin = 2.58, xmax = 5.33, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
  geom_stepribbon(data = Q_rates, aes(x = Age, ymin = min_HPD, ymax = max_HPD),
                  fill = "#260154",
                  alpha = 0.2) +
  geom_step(aes(x = Age, y = mean_Q),
            linewidth = 1, colour = "#260154") +
  labs(x = "Time (Ma)",
       y = "Preservation rate (occurrence/lineage/Myr)") +
  theme(axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        axis.text = element_text(size = 18),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(dat = cnz_epochs, abbrv = TRUE, size = 4)

ggsave("./figures/Preservation_rates/Full_Q_rates.png",
       plot = Q_plot,
       height = 200,
       width = 300,
       units = "mm",
       dpi = 600)

rm(list = ls())
## Set Cenozoic epochs dataset (again...) for plotting facilities --------------
cnz_epochs <- deeptime::epochs[1:7, ]
cnz_epochs$abbr <- c("H", "Ple", "Pli", "Miocene", "Oligocene", "Eocene", "Palaeocene")

## Full ------------------------------------------------------------------------
Q_rates <- read.csv("../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch/Q_shifts/one_place-one_time-one_occ/Parsed_Q_rates.csv")
Q_rates$Age <- c(66, 56, 33.9, 23.03, 5.33, 2.58, 0.01)
#restrict holocene preservation to 2 for plotting
Q_rates$mean_Q[7] <- 2
Q_rates$mean_Q[7] <- 2
Q_rates$mean_Q[7] <- 2

Q_plot <- ggplot(data = Q_rates, aes(x = Age, y = mean_Q))+
  scale_x_reverse(breaks = c(2.58, 5.33, 15.97, 23.03, 27.82, 33.9, 56, 66)) +
  scale_y_continuous(breaks = seq(from = 0, to = 2, by = 0.2),
                     limits = c(0, 2)) +
  annotate("rect", xmin = 56, xmax = 66, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
  annotate("rect", xmin = 23.03, xmax = 33.9, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
  annotate("rect", xmin = 2.58, xmax = 5.33, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
  geom_stepribbon(data = Q_rates, aes(x = Age, ymin = min_HPD, ymax = max_HPD),
                  fill = "#260154",
                  alpha = 0.2) +
  geom_step(aes(x = Age, y = mean_Q),
            linewidth = 1, colour = "#260154") +
  labs(x = "Time (Ma)",
       y = "Preservation rate (occurrence/lineage/Myr)") +
  theme(axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        axis.text = element_text(size = 18),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_geo(dat = cnz_epochs, abbrv = TRUE, size = 4)

ggsave("./figures/Preservation_rates/Spatially_scaled_Q_rates.png",
       plot = Q_plot,
       height = 200,
       width = 300,
       units = "mm",
       dpi = 600)
