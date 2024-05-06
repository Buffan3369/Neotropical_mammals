################################################################################
# Name: Frequency of rate shift figure (for RJMCMC outputs)
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for Ts/Te plots Metatheria
################################################################################
source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")

## Geoscales
# Set second geoscale
gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

## SALMA kept
f_rate_shift_tbl_k <- extract_histo_tbl("./results_EXTENDED/SALMA_kept/genus_level/1-Full/MH_sampler/combined_logs/RTT_plots.r")
plot_list_kept <- freq_rate_shift(data = f_rate_shift_tbl_k[[1]],
                                      bf2 = f_rate_shift_tbl_k[[2]],
                                      bf6 = f_rate_shift_tbl_k[[3]],
                                      x_annots = 33,
                                      y_annot_bf2 = 0.06,
                                      y_annot_bf6 = 0.225,
                                      x_breaks = seq(50, 25, -5),
                                      x_limits = c(52, 24),
                                      y_limits = c(0, 0.8),
                                      several_gts = TRUE,
                                      geoscale2 = gsc2,
                                      abbr = list(TRUE, FALSE))
plot_list_kept[[2]]

## SALMA smoothed
f_rate_shift_tbl_s <- extract_histo_tbl("./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/combined_logs/RTT_plots.r")
plot_list_smoothed <- freq_rate_shift(data = f_rate_shift_tbl_s[[1]],
                                      bf2 = f_rate_shift_tbl_s[[2]],
                                      bf6 = f_rate_shift_tbl_s[[3]],
                                      x_annots = 33,
                                      y_annot_bf2 = 0.06,
                                      y_annot_bf6 = 0.225,
                                      x_breaks = seq(50, 25, -5),
                                      x_limits = c(52, 24),
                                      y_limits = c(0, 0.8),
                                      several_gts = TRUE,
                                      geoscale2 = gsc2,
                                      abbr = list(TRUE, FALSE))
plot_list_smoothed[[2]]
