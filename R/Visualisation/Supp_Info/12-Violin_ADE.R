################################################################################
# Name: 12-Violin_ADE.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Violin plot for the Weibull shape parameter
################################################################################

library(tidyverse)
library(ggpubr)

burnin <- 20

## Early dataset ---------------------------------------------------------------
pth_early <- "./results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_early/pyrate_mcmc_logs/"
log_list_early <- list.files(pth_early, pattern = "ADE_ADE_mcmc.log")
df_early <- read.table(paste0(pth_early, log_list_early[1]), header = TRUE)
df_early <- df_early[(burnin+1):nrow(df_early), c("it", "w_shape")]
for(file in log_list_early[2:length(log_list_early)]){
  tmp <- read.table(paste0(pth_early, file), header = TRUE)
  df_early <- rbind(df_early, tmp[(burnin+1):nrow(tmp), c("it", "w_shape")])
}
df_early$Phase <- "Early"

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
df_late$Phase <- "Late"

## Write and save recap table --------------------------------------------------
HPD <- function(distrib, lvl=.95){
  alpha = (1-lvl)/2
  q <- as.numeric(quantile(distrib, probs = c(alpha, 1-alpha)))
  return(paste0("[", round(q[1], digits = 5), "; ", round(q[2], digits = 5), "]"))
}

recap_tbl <- data.frame(Phase=NA, Median_estimate=NA, HPD95=NA, HPD90=NA)
recap_tbl[1,] <- c("Early", round(quantile(df_early$w_shape, probs=(0.5)), digits = 5), HPD(df_early$w_shape, lvl = .95), HPD(df_early$w_shape, lvl = .90))
recap_tbl[2,] <- c("Late", round(quantile(df_late$w_shape, probs=(0.5)), digits = 5), HPD(df_late$w_shape, lvl = .95), HPD(df_late$w_shape, lvl = .90))
write.table(recap_tbl, "./figures/supp_figs/ADE/recap_tbl_w_shape.txt", row.names = F, sep = "\t", quote = F)

## Assemble and plot -----------------------------------------------------------
full <- rbind(df_early[, 2:3], df_late[, 2:3])
full$x <- "w_shape"
rm(df_early, df_late)

violin_ADE <- full %>% 
  ggplot(mapping = aes(x = x, y = w_shape, colour = Phase)) +
  geom_violin(draw_quantiles = c(0.025, 0.5, 0.975), scale = "width", colour = "black", aes(fill = Phase), adjust = 1.5) +
  scale_fill_manual(values = c("#006d2c", "#0868ac")) +
  scale_y_continuous(breaks = c(-2, 0, 1, 2, 4)) +
  geom_hline(yintercept = 1, linetype = "dashed", colour = "grey") +
  labs(y = "Weibull shape") +
  theme(axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_text(size = 18),
        axis.text.y = element_text(size = 15),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5))

ggsave("./figures/supp_figs/ADE/ADE_violin.pdf",
       plot = violin_ADE,
       height = 200,
       width = 200,
       units = "mm")

## Plot Extinction rate through time -------------------------------------------
library(deeptime)
source("../../CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("../../CorsaiR/R/2-plotting_facilities.R")
source("./R/useful/load_gts.R")


rtt_tbl <- extract_rtt(path = paste0( "./results_EXTENDED/SALMA_smoothed/genus_level/1-Full/MH_sampler/combined_logs/RTT_plots.r"), 
                       ana = "RJMCMC")
# restrict plotting window
rtt_tbl <- rtt_tbl %>% filter(time > 24.6 & time <= 52)
# adjustments for plotting window
rtt_tbl$time[1] <- 24.6
rtt_tbl$time[nrow(rtt_tbl)] <- 52

ex_plt <- rtt_plot(data = rtt_tbl,
                    type = "ex",
                    y_limits = c(0, 0.5),
                    x_lab = "Time (Ma)",
                    y_lab = "Extinction rate",
                    stage_x_breaks = FALSE,
                    manual_x_breaks = sort(c(seq(25, 50, 5), 39)),
                    axes.labelsize=15,
                    ticks.labelsize = 10,
                    restrict_y = TRUE,
                    restrict_thr = 0.5,
                    ext_col="#a50f15",
                    display_gts = TRUE,
                    xlim = c(52, 24),
                    plot.border = FALSE,
                    display_EECO_MECO = FALSE,
                    several_gts = TRUE,
                    geoscale = gsc1_bis,
                    geoscale2 = gsc2_bis,
                    geoscale_height = unit(1, "line"),
                    abbr = list(TRUE, FALSE)) +
  geom_vline(xintercept = 39, linetype="dashed", color = "grey20", linewidth = 0.8) +
  annotate(geom = "rect", xmin = 40, xmax = 51.5, ymin = 0.41, ymax = 0.45, colour = NA, fill = "#006d2c") +
  annotate(geom = "text", x = 45.5, y = 0.43, colour = "white", label = "Early") +
  annotate(geom = "rect", xmin = 25.5, xmax = 38, ymin = 0.41, ymax = 0.45, colour = NA, fill = "#0868ac") +
  annotate(geom = "text", x = 32, y = 0.43, colour = "white", label = "Late") +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

p <- ggarrange(violin_ADE, ex_plt, nrow = 2)

ggsave("./figures/supp_figs/ADE/Fig_s41.pdf",
       plot = p,
       height = 185,
       width = 135,
       units = "mm")
