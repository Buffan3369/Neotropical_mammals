################################################################################
################### Masterfile for RTT and LTT plotting ########################
################################################################################

library(hash)

## Source accessory functions for plotting -------------------------------------
source("./R/fancy_plots/1-extract_param_from_PyRate_outputs.R")
source("./R/fancy_plots/2-plotting_facilities.R")

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

## Tropical/non-tropical plots -------------------------------------------------
y_max_rtt <- hash("Tropical"=2, "Extra-tropical"=1.4)
increment_rtt <- hash("Tropical"=0.5, "Extra-tropical"=0.2)
y_max_ltt <- hash("Tropical"=160, "Extra-tropical"=120)
for(order in c("Tropical_20M", "Tropical_50M", "Extra-tropical_20M", "Extra-tropical_50M")){
  W <- strsplit(order, split="_")[[1]][1]
  #RTT
  rtt <- extract_rtt(paste0("../../PyRate_outputs/Tropical_analysis/combined_logs/", order, "/RTT_plots.r"))
  SpEx.plot <- rtt_plot(rtt, 
                        type = "SpEx",
                        restrict_thr = values(y_max_rtt[W]),
                        x_breaks = c(2.58, 5.33, 23.03, 33.9, 56, 66),
                        y_breaks = seq(from = 0, to = values(y_max_rtt[W]), by = values(increment_rtt[W])),
                        y_labels = seq(from = 0, to = values(y_max_rtt[W]), by = values(increment_rtt[W])),
                        y_limits = c(0,values(y_max_rtt[W])+0.1))
  net.plot <- rtt_plot(rtt, 
                       type = "net",
                       restrict_thr = values(y_max_rtt[W]),
                       x_breaks = c(2.58, 5.33, 23.03, 33.9, 56, 66),
                       y_breaks = seq(from = -values(y_max_rtt[W]), to = values(y_max_rtt[W]), by = values(increment_rtt[W])),
                       y_labels = seq(from = -values(y_max_rtt[W]), to = values(y_max_rtt[W]), by = values(increment_rtt[W])),
                       y_limits = c(-(values(y_max_rtt[W])+0.1),values(y_max_rtt[W])+0.1))
  #LTT
  ltt <- extract_ltt(paste0("../../PyRate_outputs/Tropical_analysis/LTT/", order, "/"))
  ltt.plot <- ltt_plot(ltt,
                      y_breaks = seq(0,values(y_max_ltt[W]),40),
                      y_labels = seq(0,values(y_max_ltt[W]),40),
                      y_limits = c(0, values(y_max_ltt[W])+15))
  #Combine and save
  p <- comb_ltt_rtt(SpEx_plot = SpEx.plot, net_plot = net.plot, ltt_plot = ltt.plot)
  ggsave(paste0("./figures/Tropical_analysis/", W, "/", order, "_RTT_LTT.png"),
         plot = p,
         height = 300,
         width = 400,
         units = "mm",
         dpi = 600)
  
}
rm(SpEx.plot, net.plot, p, rtt, ltt, y_max_ltt, ymax_rtt, increment_rtt)

## Eocene-Oligocene ------------------------------------------------------------
  # Full dataset
for(part in c("regular", "mindt_05", "singleton", "spatially_scaled", "spatially_scaled_singleton")){ #option of the code
  for(q in c("epochs", "stages", "5M")){ #preservation rate shift allowed
    if((part %in% c("spatially_scaled", "spatially_scaled_singleton")) & (q == "epochs")){
      next
    }
    rtt_eot <- extract_rtt(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_", part, "/combined_logs/q_",q,"/RTT_plots.r"))
    sp_ex_eot <- rtt_plot(data = rtt_eot,
                          type = "SpEx",
                          x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                          y_breaks = seq(from = 0, to = 1.4, by = 0.2),
                          y_labels = c(0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                          y_limits = c(0, 1.5),
                          geoscale = deeptime::epochs[1:7, ],
                          abbr = FALSE)
    net_eot <- rtt_plot(data = rtt_eot,
                        type = "net",
                        x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                        y_breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                        y_labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                        y_limits = c(-1.5, 1.5),
                        geoscale = deeptime::epochs[5:6, ],
                        abbr = FALSE)
    ltt_eot <- extract_ltt(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_", part, "/LTT/q_", q, "/per_replicate/"))
    ltt_plot_eot <- ltt_plot(ltt_eot,
                             x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                             y_breaks = seq(0,120,20),
                             y_labels = seq(0,120,20),
                             y_limits = c(0, 125),
                             geoscale = deeptime::epochs[5:6, ],
                             abbr = FALSE)
    # p <- comb_ltt_rtt(sp_ex_eot, net_eot, ltt_plot_eot, n_plots = 3)
    # ggsave(paste0("./figures/EOT/", part, "/q_", q, "/ltt_rtt_q_", q, ".png"),
    #        plot = p,
    #        height = 300,
    #        width = 400,
    #        units = "mm",
    #        dpi = 600)
    Q_rates <- read.csv(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_",
                               part,
                               "/Q_SHIFTS/q_",
                               q, "/Parsed_Q_rates.csv"))
    if(q == "epochs"){
      Q_rates$Age <- c(56, 33.9, 23.03)
    }
    else if(q == "stages"){
      Q_rates$Age <- c(56, 47.8, 41.2, 37.71, 33.9, 27.82, 23.03)
    }
    else if(q == "5M"){
      Q_rates$Age <- c(56, 51, 46, 41, 36, 31, 26, 23.03)
    }
    Q_plot <- q_plot(data = Q_rates,
                     x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                     geoscale = deeptime::epochs[5:6, ])
    p <- comb_ltt_rtt(sp_ex_eot, net_eot, ltt_plot_eot, Q_plot, n_plots = 4)
    ggsave(paste0("./figures/EOT/", part, "/q_", q, "/ltt_preservation_rtt_q_", q, ".png"),
           plot = p,
           height = 300,
           width = 400,
           units = "mm",
           dpi = 300)
    
  }
}

  #order level (toggle-on or off singleton with comment)
singleton <- TRUE
#singleton <- FALSE
for(order in c("Xenarthra", "Metatheria", "SANU", "Rodentia")){ #option of the code
  for(q in c("stages", "5M")){ #preservation rate shift allowed
    if(singleton){
      if((order == "SANU") & (q == "5M")){
        next
      }
      beg <- "../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_order_singleton/"
      fig_tag <- "singleton_"
    }
    else{
      beg <- "../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_order"
      fig_tag <- NULL
    }
    rtt_eot <- extract_rtt(paste0(beg, "/combined_logs/", order, "/q_",q,"/RTT_plots.r"))
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
                             y_breaks = seq(0,60,10),
                             y_labels = seq(0,60,10),
                             y_limits = c(0, 65),
                             geoscale = deeptime::epochs[5:6, ],
                             abbr = FALSE)
    Q_rates <- read.csv(paste0(beg, "/Q_SHIFTS/",
                               order, "/q_",q, "/Parsed_Q_rates.csv"))
    if(q == "stages"){
      ages <- c(56, 47.8, 41.2, 37.71, 33.9, 27.82, 23.03)
      if(nrow(Q_rates) < length(ages)){ #in case the group appeared later than Early Eocene
        ages <- ages[(length(ages)-nrow(Q_rates)+1): length(ages)]
      }
      else if(nrow(Q_rates) > length(ages)){ #stretching below 23.03 Ma
        Q_rates <- Q_rates[1:length(ages)]
      }
      Q_rates$Age <-  ages
    }
    if(q == "5M"){
      ages <- c(56, 51, 46, 41, 36, 31, 26, 23.03)
      if(nrow(Q_rates) < length(ages)){ #in case the group appeared later than Early Eocene
        ages <- ages[(length(ages)-nrow(Q_rates)+1): length(ages)]
      }
      else if(nrow(Q_rates) > length(ages)){ #stretching below 23.03 Ma
        Q_rates <- Q_rates[1:length(ages)]
      }
      Q_rates$Age <-  ages
    }
    
    Q_plot <- q_plot(data = Q_rates,
                     x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                     geoscale = deeptime::epochs[5:6, ])
    p <- comb_ltt_rtt(sp_ex_eot, net_eot, ltt_plot_eot, Q_plot, n_plots = 4)
    ggsave(paste0("./figures/EOT/order/", order, "/ltt_rtt_", order, "_preservation_", fig_tag, "q_", q, ".png"),
           plot = p,
           height = 300,
           width = 400,
           units = "mm",
           dpi = 300)
  }
}
  #Latitudinal partitioning
for(zn in c("Tropical", "Extra.tropical")){ #option of the code
  for(q in c("stages", "5M")){ #preservation rate shift allowed
    #RTT
    rtt_eot <- extract_rtt(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_LAT_PARTITIONING/combined_logs/",
                                  zn, "/q_", q, "/RTT_plots.r"))
    sp_ex_eot <- rtt_plot(data = rtt_eot,
                          type = "SpEx",
                          x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                          y_breaks = seq(from = 0, to = 1.4, by = 0.2),
                          y_labels = c(0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                          y_limits = c(0, 1.5),
                          geoscale = deeptime::epochs[1:7, ],
                          abbr = FALSE)
    net_eot <- rtt_plot(data = rtt_eot,
                        type = "net",
                        x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                        y_breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                        y_labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                        y_limits = c(-1.6, 1.5),
                        geoscale = deeptime::epochs[5:6, ],
                        abbr = FALSE)
    # LTT
    ltt_eot <- extract_ltt(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_LAT_PARTITIONING/LTT/",
                                  zn, "/q_", q, "/per_replicate/"))
    if(zn=="Tropical"){
      yrange <- seq(0, 50, 10)
    }
    else{
      yrange <- seq(0, 80, 20)
    }
    ltt_plot_eot <- ltt_plot(ltt_eot,
                             x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                             y_breaks = yrange,
                             y_labels = yrange,
                             y_limits = c(0, max(yrange)+10),
                             geoscale = deeptime::epochs[5:6, ],
                             abbr = FALSE)
    #Q_rate
    Q_rates <- read.csv(paste0("../../PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_LAT_PARTITIONING/Q_SHIFTS/",
                               zn, "/q_",q, "/Parsed_Q_rates.csv"))
    if(q == "stages"){
      ages <- c(56, 47.8, 41.2, 37.71, 33.9, 27.82, 23.03)
      if(nrow(Q_rates) < length(ages)){ #in case the group appeared later than Early Eocene
        ages <- ages[(length(ages)-nrow(Q_rates)+1): length(ages)]
      }
      else if(nrow(Q_rates) > length(ages)){ #stretching below 23.03 Ma
        Q_rates <- Q_rates[1:length(ages)]
      }
      Q_rates$Age <-  ages
    }
    if(q == "5M"){
      ages <- c(56, 51, 46, 41, 36, 31, 26, 23.03)
      if(nrow(Q_rates) < length(ages)){ #in case the group appeared later than Early Eocene
        ages <- ages[(length(ages)-nrow(Q_rates)+1): length(ages)]
      }
      else if(nrow(Q_rates) > length(ages)){ #stretching below 23.03 Ma
        Q_rates <- Q_rates[1:length(ages)]
      }
      Q_rates$Age <-  ages
    }
    
    Q_plot <- q_plot(data = Q_rates,
                     x_breaks = c(23.03, 27.82, 33.9, 37.71, 41.2, 47.8, 56),
                     geoscale = deeptime::epochs[5:6, ])
    p <- comb_ltt_rtt(sp_ex_eot, net_eot, ltt_plot_eot, Q_plot, n_plots = 4)
    ggsave(paste0("./figures/EOT/lat_binning/", zn, "/ltt_rtt_preservation_", zn, "_q_", q, "_EOT.png"),
           plot = p,
           height = 300,
           width = 400,
           units = "mm",
           dpi = 300)
  }
}
