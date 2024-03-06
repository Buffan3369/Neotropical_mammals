########### Plot and save origination rates for pipeline figure ################

source("~/Documents/GitHub/CorsaiR/R/1-extract_param_from_PyRate_outputs.R")
source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")
library(tidyverse)

## BDCS ------------------------------------------------------------------------
rtt_tbl <- extract_rtt(path = "./results/BDCS/SALMA_smoothed/genus-level/1-Full/combined_logs/TsTe_good_format_0__BDS_marginal_rates_RTT.r", ana = "BDS")
rtt_tbl <- rtt_tbl %>% filter(time > 24 & time <= 52)

rtt_plt <- rtt_plot(data = rtt_tbl,
                    type = "sp",
                    y_limits = c(0, 0.32),
                    y_breaks = seq(0, 0.3, 0.1),
                    x_lab = "Time (Ma)",
                    y_lab = "Origination rate",
                    stage_x_breaks = FALSE,
                    lwd = 0.3,
                    manual_x_breaks = seq(25, 50, 5),
                    axes.labelsize=5,
                    ticks.labelsize = 4,
                    restrict_y = TRUE,
                    restrict_thr = 1.1,
                    ori_col="#08519c",
                    display_gts = TRUE,
                    xlim = NULL,
                    plot.border = FALSE,
                    x.axis = TRUE,
                    several_gts = FALSE,
                    geoscale_height = unit(0.3, "line"),
                    geoscale_labelsize = 1,
                    abbr = FALSE) +
  theme(panel.border = element_rect(colour = "black", fill = "transparent", linewidth = 0.3),
        axis.ticks = element_line(linewidth = 0.3)) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.3)

ggsave("./figures/Fig_pipeline/BDCS_lambda.pdf", rtt_plt, height = 38, width = 38, units = "mm")


## RJMCMC ----------------------------------------------------------------------
pth <- "./results/SALMA_smoothed/genus_level/1-Full/combined_logs/RTT_plots.r"
rtt_tbl1 <- extract_rtt(path = pth, ana = "RJMCMC")
# restrict plotting window
rtt_tbl1 <- rtt_tbl1 %>% filter(time > 24 & time <= 52)
# adjustments for plotting window
rtt_tbl1$time[1] <- 24
rtt_tbl1$time[nrow(rtt_tbl1)] <- 52
rtt_plt1 <- rtt_plot(data = rtt_tbl1,
                    type = "sp",
                    y_limits = c(0, 0.83),
                    stage_x_breaks = FALSE,
                    manual_x_breaks = seq(25, 50, 5),
                    axes.labelsize=5,
                    lwd = 0.3,
                    ticks.labelsize = 4,
                    x_lab = "Time (Ma)",
                    y_lab = "Origination rate",
                    restrict_y = TRUE,
                    restrict_thr = 0.83,
                    ori_col="#08519c",
                    display_gts = TRUE,
                    xlim = c(52, 24),
                    plot.border = FALSE,
                    several_gts = FALSE,
                    geoscale_height = unit(0.3, "line"),
                    abbr = FALSE,
                    geoscale_labelsize = 1) +
  theme(panel.border = element_rect(colour = "black", fill = "transparent", linewidth = 0.3),
        axis.ticks = element_line(linewidth = 0.3)) +
  geom_vline(xintercept = 33.9, linetype="dashed", color = "red", linewidth = 0.3)
ggsave("./figures/Fig_pipeline/RJMCMC_lambda.pdf", rtt_plt1, height = 38, width = 38, units = "mm")

## MBD -------------------------------------------------------------------------

covar <- data.frame(value = c(rnorm(n = 1000, mean = 2, sd = 0.4), rnorm(n = 1000, mean = 0.3, sd = 0.5), rnorm(n = 1000, mean = -0.05, sd = 0.06)),
                    param = c(rep("Temperature", 1000), rep("Sea_level", 1000), rep("Andes_elevation", 1000)))

MBD_violin <- covar %>% ggplot(aes(x = factor(param), y = value)) +
  scale_fill_manual(values = c("#9ecae1", "#9ecae1", "#08519c")) +
  scale_y_continuous(limits = c(-2, 5)) +
  scale_x_discrete() +
  annotate(geom = "rect", xmin = -Inf, xmax = 1.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  annotate(geom = "rect", xmin = 2.5, xmax = 3.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  labs(x = " ", y = "Correlation coefficient for origination") +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey60", linewidth = 0.2) +
  geom_violin(adjust = .85, draw_quantiles = c(0.025, 0.5, 0.975), scale = "width", aes(fill = factor(param)), size = 0.05) +
  geom_text(label = c("*"), aes(x = 3, y = 4.1), size = 3, vjust = 0.8) +
  theme(axis.title = element_text(size = 5),
        axis.text = element_text(size = 5),
        legend.position = "none",
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_line(linewidth = 0.15)) +
  coord_flip()

ggsave("./figures/Fig_pipeline/MBD_violin.pdf", MBD_violin, height = 38, width = 47, units = "mm")
