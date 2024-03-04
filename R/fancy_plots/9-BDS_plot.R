library(tidyverse)

gsc2 <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
gsc2 <- gsc2 %>% rename(min_age = "min_ma", max_age = "max_ma", name = "interval_name")

rtt_tbl <- extract_rtt(path = "./results/BDCS/SALMA_smoothed/genus-level/1-Full/combined_logs/TsTe_good_format_0__BDS_marginal_rates_RTT.r", ana = "BDS")
rtt_tbl <- rtt_tbl %>% filter(time > 24 & time <= 52)

rtt_plt <- rtt_plot(data = rtt_tbl,
                    type = "SpEx",
                    y_limits = c(0, 0.45),
                    y_breaks = seq(0, 0.4, 0.1),
                    x_lab = "Time (Ma)",
                    stage_x_breaks = FALSE,
                    manual_x_breaks = seq(25, 50, 5),
                    axes.labelsize=15,
                    ticks.labelsize = 12,
                    restrict_y = TRUE,
                    restrict_thr = 1.1,
                    ori_col="#08519c",
                    ext_col="#a50f15",
                    display_gts = TRUE,
                    xlim = NULL,
                    plot.border = FALSE,
                    x.axis = TRUE,
                    display_EECO_MECO = TRUE,
                    several_gts = TRUE,
                    geoscale2 = gsc2,
                    geoscale_height = unit(1, "line"),
                    abbr = list(TRUE, FALSE))
rtt_plt

net_plt <- rtt_plot(data = rtt_tbl,
                    type = "net",
                    y_limits = c(-0.45, 0.45),
                    y_breaks = seq(-0.4, 0.4, 0.1),
                    x_lab = "Time (Ma)",
                    stage_x_breaks = FALSE,
                    manual_x_breaks = seq(25, 50, 5),
                    axes.labelsize=15,
                    ticks.labelsize = 12,
                    restrict_y = TRUE,
                    restrict_thr = 1.1,
                    net_col="#252525",
                    display_gts = TRUE,
                    xlim = NULL,
                    plot.border = FALSE,
                    x.axis = TRUE,
                    display_EECO_MECO = TRUE,
                    several_gts = TRUE,
                    geoscale2 = gsc2,
                    geoscale_height = unit(1, "line"),
                    abbr = list(TRUE, FALSE))

net_plt

p <- ggarrange(rtt_plt, net_plt, )