################################################################################
# Name: 12-Violin_ADE.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Violin plot for the Weibull shape parameter
################################################################################

library(tidyverse)

burnin <- 20

## Early dataset ---------------------------------------------------------------
pth_early <- "./results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_early/pyrate_mcmc_logs_mG/"
log_list_early <- list.files(pth_early, pattern = "KEEP_ADE_ADE_mcmc.log")
df_early <- read.table(paste0(pth_early, log_list_early[1]), header = TRUE)
df_early <- df_early[(burnin+1):nrow(df_early), c("it", "w_shape")]
for(file in log_list_early[2:length(log_list_early)]){
  tmp <- read.table(paste0(pth_early, file), header = TRUE)
  df_early <- rbind(df_early, tmp[(burnin+1):nrow(tmp), c("it", "w_shape")])
}
df_early$phase <- "Early"

mean(df_early$w_shape)

## Late dataset ----------------------------------------------------------------
pth_late <- "./results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_late/pyrate_mcmc_logs_mG/"
log_list_late <- list.files(pth_late, pattern = "KEEP_ADE_ADE_mcmc.log")
df_late <- read.table(paste0(pth_late, log_list_late[1]), header = TRUE)
df_late <- df_late[(burnin+1):nrow(df_late), c("it", "w_shape")]
for(file in log_list_late[2:length(log_list_late)]){
  tmp <- read.table(paste0(pth_late, file), header = TRUE)
  df_late <- rbind(df_late, tmp[(burnin+1):nrow(tmp), c("it", "w_shape")])
}
df_late$phase <- "Late"
mean(df_late$w_shape)

## Assemble and plot -----------------------------------------------------------
full <- rbind(df_early[, 2:3], df_late[, 2:3])
full$x <- "w_shape"
rm(df_early, df_late)

full %>% 
  ggplot(mapping = aes(x = x, y = w_shape, colour = phase)) +
  geom_violin(draw_quantiles = c(0.025, 0.5, 0.975)) +
  geom_hline(yintercept = 1) +
  coord_flip()
