################################################################################
################### Masterfile for RTT and LTT plotting ########################
################################################################################

## Source accessory functions for plotting -------------------------------------
source("./R/fancy_plots/extract_param_from_PyRate_outputs.R")
source("./R/fancy_plots/plotting_facilities.R")

## Full plots ------------------------------------------------------------------
  ### All in one
rtt_all_in_one <- extract_rtt("../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch_31-05/combined_logs/all_in_one/RTT_plots.r")
#Origination and Extinction rates
sp_ex_all_in_one <- rtt_plot(data = rtt_all_in_one, 
                             type = "SpEx",
                             y_breaks = seq(from = 0, to = 1.4, by = 0.2),
                             y_labels = seq(from = 0, to = 1.4, by = 0.2),
                             y_limits = c(0, 1.5))
#Net diversification rate
net_plot_all_in_one <- rtt_plot(data = rtt_all_in_one, type = "net")
#LTT
ltt_all_in_one <- extract_ltt("../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch_31-05/LTT/all_in_one/")
ltt_pl_all_in_one <- ltt_plot(ltt_all_in_one)
#Save
p <- comb_ltt_rtt(sp_ex_all_in_one, net_plot_all_in_one, ltt_pl_all_in_one)
ggsave("./figures/Full/Full_RTT_LTT.png",
       plot = p,
       height = 300,
       width = 400,
       units = "mm",
       dpi = 600)
#Free space
rm(list = ls(pattern = "*_all_in_one"))

  ### One place, one time, one occ
rtt_one_place_time_occ <- extract_rtt("../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch_31-05/combined_logs/one_place-one_time-one_occ/RTT_plots.r")
sp_ex_one_place_time_occ <- rtt_plot(data = rtt_one_place_time_occ, 
                             type = "SpEx",
                             y_breaks = seq(from = 0, to = 1.4, by = 0.2),
                             y_labels = seq(from = 0, to = 1.4, by = 0.2),
                             y_limits = c(0, 1.5))
net_plot_one_place_time_occ <- rtt_plot(data = rtt_one_place_time_occ, type = "net")
ltt_one_place_time_occ <- extract_ltt("../../PyRate_outputs/BDCS_RJMCMC_ICC_subepoch_31-05/LTT/one_place-one_time-one_occ/")
ltt_pl_one_place_time_occ <- ltt_plot(ltt_one_place_time_occ)
p <- comb_ltt_rtt(sp_ex_one_place_time_occ, net_plot_one_place_time_occ, ltt_pl_one_place_time_occ)
ggsave("./figures/Full/Spatially_scaled_RTT_LTT.png",
       plot = p,
       height = 300,
       width = 400,
       units = "mm",
       dpi = 600)
rm(list = ls(pattern = "*_one_place_time_occ"))


## Order-level plots -----------------------------------------------------------


## Eocene-Oligocene ------------------------------------------------------------
for(part in c("regular", "mindt_05", "singleton")){ #option of the code
  for(q in c("epochs", "stages", "5M")){ #preservation rate shift allowed
    if((part == "singleton") && (q == "stages")){
      break
    }
    rtt_eot <- extract_rtt(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_", part, "/combined_logs/q_",q,"/RTT_plots.r"))
    sp_ex_eot <- rtt_plot(data = rtt_eot_epochs,
                          type = "SpEx",
                          x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                          y_breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                          y_labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                          y_limits = c(-1.5, 1.5),
                          geoscale = deeptime::epochs[1:7, ],
                          abbr = FALSE)
    net_eot <- rtt_plot(data = rtt_eot_epochs,
                        type = "net",
                        x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                        y_breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                        y_labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                        y_limits = c(-1.5, 1.5),
                        geoscale = deeptime::epochs[5:6, ],
                        abbr = FALSE)
    ltt_eot <- extract_ltt(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_", part, "/LTT/q_", q, "/per_replicate/"))
    ltt_plot_eot <- ltt_plot(ltt_eot,
                             y_breaks = seq(0,120,20),
                             y_labels = seq(0,120,20),
                             y_limits = c(0, 125),
                             geoscale = deeptime::epochs[5:6, ],
                             abbr = FALSE)
    p <- comb_ltt_rtt(sp_ex_eot, net_eot, ltt_plot_eot)
    ggsave(paste0("./figures/EOT/", part, "/q_", q, "/ltt_rtt_q_", q, ".png"),
           plot = p,
           height = 300,
           width = 400,
           units = "mm",
           dpi = 600)
  }
}

