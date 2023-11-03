################################################################################
################### Masterfile for RTT and LTT plotting ########################
################################################################################

library(hash)

## Source accessory functions for plotting -------------------------------------
source("./R/fancy_plots/1-extract_param_from_PyRate_outputs.R")
source("./R/fancy_plots/2-plotting_facilities.R")

data <- "entire"

## Plots -----------------------------------------------------------------------
for(order in c("full")){ #taxonomic specification
  for(q in c("stages")){ #preservation rate shift allowed
    beg <- paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/SPECIES_LEVEL/", data)
    fig_tag <- NULL
    rtt_eot <- extract_rtt(paste0(beg, "/combined_logs/", order, "/q_", q, "/RTT_plots.r"))
    sp_ex_eot <- rtt_plot(data = rtt_eot,
                          type = "SpEx",
                          x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                          y_breaks = seq(from = 0, to = 1.4, by = 0.2),
                          y_labels = c(0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                          y_limits = c(0, 1.5),
                          geoscale = deeptime::epochs[5:6, ],
                          abbr = FALSE)
    net_eot <- rtt_plot(data = rtt_eot,
                        type = "net",
                        x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                        y_breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                        y_labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                        y_limits = c(-1.5, 1.5),
                        geoscale = deeptime::epochs[5:6, ],
                        abbr = FALSE)
    ltt_eot <- extract_ltt(paste0(beg, "/LTT/", order, "/q_", q, "/per_replicate/"))
    ltt_plot_eot <- ltt_plot(ltt_eot,
                             x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                             y_breaks = seq(0,150,25),
                             y_labels = seq(0,150,25),
                             y_limits = c(0, 160),
                             geoscale = deeptime::epochs[5:6, ],
                             abbr = FALSE)
    p <- comb_ltt_rtt(sp_ex_eot, net_eot, ltt_plot_eot, Q_plot, n_plots = 3)
    ggsave(paste0("./figures/EOT/species_level/", order, "/ltt_rtt_", order, "_preservation_q_", q, ".png"),
           plot = p,
           height = 300,
           width = 400,
           units = "mm",
           dpi = 300)
  }
}
