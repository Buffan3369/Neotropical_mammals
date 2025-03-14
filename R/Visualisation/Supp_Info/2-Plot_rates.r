################################################################################
# Goal: Plot RTT, LTT and Q_rates in a fancy way
# Authors: Alexis Marion and Lucas Buffan (Lucas.L.Buffan@gmail.com)
# Description :
#   args[1] => type of analysis carried out
#   args[2] => path towards the RTT_plots.R script generated by PyRate after the -plot command
#   args[3] => path towards the directory where LTT per replicates are stored
#   args[4] => path towards the "Parse_Q_rates.csv" file storing the q values per time bin (TPP)
#   args[5] => output rate plot name and directory
#   args[6] => output freq rate shifts plot name and directory
#   args[7] => where are the accessory function scripts stored
# Note : ONLY RUN IN COMMAND LINES
################################################################################

library("hash")
library("DDD")
library("readxl")
library("tidyverse")

args <- commandArgs(trailingOnly=TRUE)

## Source accessory functions for plotting -------------------------------------
source(paste0(args[7], "/1-extract_param_from_PyRate_outputs.R"))
source(paste0(args[7], "/2-plotting_facilities.R"))

# First geoscale
gsc1 <- deeptime::epochs
gsc1 <- gsc1 %>% filter(min_age < 56)
# Set second geoscale
gsc2 <- read_xlsx("../../../../data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")
# Weird modifications for plotting
gsc1_bis <- gsc1
gsc1_bis$max_age[nrow(gsc1_bis)] <- 52
gsc1_bis$min_age[1] <- 24
gsc2_bis <- gsc2 %>% filter(max_age <= 56)
gsc2_bis$max_age[nrow(gsc2_bis)] <- 52
gsc2_bis$min_age[1] <- 24

ana <- args[1] #ana = 'RJMCMC' or 'BDS'

## Diversification rates -------------------------------------------------------
  # Get diversification rates table
rtt_tbl <- extract_rtt(args[2], ana = ana)
rtt_tbl <- rtt_tbl %>% filter(time > 24 & time < 52)
  # Origination and Extinction rates plot
sp_ex_all_in_one <- rtt_plot(data = rtt_tbl,
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
  annotate(geom = "segment", x = 46, xend = 49, y = 0.48, yend = 0.48, colour = "#08519c", linewidth = 1) +
  annotate(geom = "text", x = 43, y = 0.48, label = "Origination rate", size = 4.5) +
  annotate(geom = "segment", x = 46, xend = 49, y = 0.43, yend = 0.43, colour = "#a50f15", linewidth = 1) +
  annotate(geom = "text", x = 43, y = 0.43, label = "Extinction rate ", size = 4.5) +
  annotate(geom = "text", x = 32, y = 0.525, label = "EOT", size = 6, colour = "red") +
  geom_text(aes(x = 51.5, y = 0.35, label = "EECO"), angle = 90, colour = "bisque4") +
  geom_text(aes(x = 41.25, y = 0.35, label = "MECO"), angle = 90, colour = "bisque4") +
  annotate(geom = "text", x = 50, y = 0.33, label = "*", colour = "#08519c", size = 15) +
  annotate(geom = "text", x = 39, y = 0.33, label = "*", colour = "#08519c", size = 15) +
  annotate(geom = "text", x = 39, y = 0.28, label = "*", colour = "#a50f15", size = 15)

  # Net diversification rate plot
net_div_all_in_one <- rtt_plot(data = rtt_tbl,
                               type = "net",
                               x_lab = NULL,
                               y_lab = NULL,
                               y_breaks = seq(-0.2, 0.4, 0.1),
                               y_limits = c(-0.21, 0.45),
                               restrict_thr = 0.45,
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
  annotate(geom = "segment", x = 46, xend = 49, y = 0.35, yend = 0.35, colour = "#504A4B", linewidth = 1) +
  annotate(geom = "text", x = 42.5, y = 0.35, label = "Net diversification\n rate", size = 4.5)

## Lineages-through-time (LTT)--------------------------------------------------
  # LTT table
ltt_tbl <- read.table(args[3], sep = "\t", header = TRUE)
ltt_tbl <- ltt_tbl %>% 
  filter(time > 24 & time < 52) %>%
  rename("Age" = time, "Diversity" = diversity, "min_Diversity" = m_div, "max_Diversity" = M_div)
ltt_tbl$Age[1] <- 24
ltt_tbl$Age[nrow(ltt_tbl)] <- 52
  # LTT plot
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
                     several_gts = TRUE,
                     geoscale = gsc1_bis,
                     geoscale2 = gsc2_bis,
                     geoscale_height = unit(1, "line"),
                     geoscale_labelsize = 4,
                     abbr = list(TRUE, FALSE),
                     display_EECO_MECO = TRUE) +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + # EOT
  annotate(geom = "segment", x = 43.5, xend = 46, y = 105, yend = 105, colour = "#006d2c", linewidth = 1) +
  annotate(geom = "text", x = 41.5, y = 105, label = "Diversity", size = 4.5)


## Preservation (q) rates ------------------------------------------------------
  # q-rates table
omega <- read.table(args[4], sep = "\t", header = TRUE)
omega <- omega %>% filter(Age > 23.03 & Age <= 56)
if(56 %in% omega$Age){
  omega$Age[which(omega$Age == 56)] <- 52
}
  # q-rates plot
Q_plot <- q_plot(omega, 
               ltt_tbl,
               stage_x_breaks = FALSE,
               manual_x_breaks = seq(25, 50, 5),
               x_lim = c(52, 24),
               several_gts = TRUE,
               y_lab = NULL,
               geoscale = gsc1_bis,
               geoscale2 = gsc2_bis,
               geoscale_height = unit(1, "line"),
               geoscale_labelsize = 4,
               abbr = list(TRUE, FALSE))  +
  # Temporal bands
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey10", ymin = -Inf, ymax = Inf, alpha = 0.1, linewidth = 0) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.8) + # EOT
  annotate(geom = "segment", x = 46, xend = 49, y = 1, yend = 1, colour = "#260154", linewidth = 1) +
  annotate(geom = "text", x = 43.5, y = 1, label = "Preservation\n rate", size = 4.5)

## Combine all these plots and save the output ---------------------------------
p <- comb_ltt_rtt(sp_ex_all_in_one, net_div_all_in_one, ltt.plot, Q_plot, n_plots = 4)
ggsave(args[5],
           plot = p,
           height = 350,
           width = 450,
           units = "mm",
           dpi = 300)

## Frequency of rate shift -----------------------------------------------------
f_rate_shift_tbl <- extract_histo_tbl(args[2])
plot_list <- freq_rate_shift(data = f_rate_shift_tbl[[1]],
                             bf2 = f_rate_shift_tbl[[2]],
                             bf6 = f_rate_shift_tbl[[3]],
                             x_annots = 53.5,
                             y_annot_bf2 = 0.04,
                             y_annot_bf6 = 0.19,
                             x_breaks = c(27.82, 33.9, 37.71, 47.8),
                             x_limits = c(55.5, 23.53), #interesting to custom to avoid edge effects
                             y_limits = c(0, 0.5),
                             several_gts = TRUE,
                             geoscale = gsc1_bis,
                             geoscale2 = gsc2_bis,
                             abbr = list(TRUE, FALSE))
## Combine and save ------------------------------------------------------------
cb <- cowplot::plot_grid(plot_list[[1]], plot_list[[2]],
                         ncol = 2,
                         rel_widths = c(1/2, 1/2))
ggsave(args[6],
       plot = cb,
       height = 250,
       width = 450,
       units = "mm",
       dpi = 300)