################################################################################
# Title: 7-Process_envt_correlates.R
# Author: Lucas Buffan
# Date: 2024-03-28
# Aim: Process environmental correlates for MBD.
################################################################################

library(tidyverse)
library(readxl)
library(ggplot2)
library(deeptime)
library(ggpubr)
source("./R/useful/helper_functions.R")

## Plant diversity (from Jaramillo et al. (2006)) --------------------------------------------------------------------
plant_raw <- read.table("./data_2023/MBD/raw_environment_correlates/Cnz_Plant_diversity_Jaramillo_2006.txt", header = TRUE)
selected_indices <- sapply(X = seq(from = 23, to = 56, by = 0.5),
                           FUN = select_closer,
                           age_vect = plant_raw$Age)
plant_processed <- data.frame(Age = seq(from = 23, to = 56, by = 0.5),
                              Plant_diversity = plant_raw$Div[selected_indices])
### Verification ###
# par(mfrow = c(1,2))
# plot(x = plant_processed$Age, plant_processed$Plant_diversity, xlim = c(15, 90))
# plot(x = plant_raw$Age, y = plant_raw$Div)

# Full dataset
write.table.lucas(x = plant_processed,
                  file = "./data_2023/MBD/processed_predictors_full/1-Plant_Diversity_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = plant_processed %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/1-Plant_Diversity_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = plant_processed %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/1-Plant_Diversity_Oligocene_only_500ky_step.txt")


## Andean Uplift (from Boschman (2021)) -----------------------------------------------------------------------------
Uplift <- read.table("./data_2023/MBD/raw_environment_correlates/andean_uplift/Andes_mean_elevations_no_basins_ALL.txt",
                     sep = " ",
                     header = TRUE)
#Write and save a dataset of the covariate with a 100ky time step
average_elevation <- data.frame(Age = 0:66,
                                Altitude = sapply(X = 0:66, FUN = function(x){return(mean(Uplift$Altitude[which(Uplift$Age == x)]))}))
interpol_av_el <- approx(x = average_elevation$Age[1:2], y = average_elevation$Altitude[1:2], n=3)$y
for(i in 2:66){
  interpol_av_el <- c(interpol_av_el,
                      approx(x = average_elevation$Age[i:(i+1)], y = average_elevation$Altitude[i:(i+1)], n=3)$y[-c(1)])
}
### Verification ###
# par(mfrow = c(1,2))
# plot(x = average_elevation$Age, y = average_elevation$Altitude)
# title("Original data")
# plot(x = seq(from = 0, to = 66, by = 0.5), y = interpol_av_el)
# title("Interpolated data")
Andes <- data.frame(Age = seq(from = 0, to = 66, by = 0.5),
                    Altitude = interpol_av_el)
# Full dataset
write.table.lucas(Andes %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/2-Andes_mean_elevations_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = Andes %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/2-Andes_mean_elevations_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = Andes %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/2-Andes_mean_elevations_Oligocene_only_500ky_step.txt")


## Palaeotemperature (assembled by Boschman and Condamine 2022 using Cenozoic data from Westerhold et al. 2020) ----------------
Temp_Cnz <- read.table("./data_2023/MBD/raw_environment_correlates/palaeotemperature/merged_veizer_westerhold_Ts.txt",
                   sep = "\t",
                   header = TRUE)
Temp_Cnz <- Temp_Cnz[which(Temp_Cnz$Age <= 66), ]
#Write and save a dataset of the covariate with a 500ky time step
selected_indices <- sapply(X = seq(from = 0, to = 66, by = 0.5), FUN = select_closer, age_vect = Temp_Cnz$Age)
Temp_Cnz1 <- Temp_Cnz[selected_indices, ]
Temp_Cnz1$Age <- sapply(X = Temp_Cnz1$Age, FUN = round, digits = 1)
### Verification ###
# par(mfrow = c(1,2))
# plot(x = Temp_Cnz$Age, y = Temp_Cnz$Temperature)
# title("Original data")
# plot(x = Temp_Cnz1$Age, y = Temp_Cnz1$Temperature)
# title("Subsampled data")

# Full dataset
write.table.lucas(Temp_Cnz1 %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/3-Temperature_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = Temp_Cnz1 %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/3-Temperature_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = Temp_Cnz1 %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/3-Temperature_Oligocene_only_500ky_step.txt")

## Global sea level (from Miller et al. 2020) -----------------------------------------------------------------------------------
sea_lvl <- read.table("./data_2023/MBD/raw_environment_correlates/sea_level/Miller_2020_sea_level_data.txt",
                      sep = "\t",
                      header = TRUE)
sea_lvl <- sea_lvl %>% 
  mutate(age_calkaBP = sapply(X = sea_lvl$age_calkaBP, FUN = function(x){x/1000})) %>% 
  rename(age_MaBP = "age_calkaBP")
selected_indices <- sapply(X = seq(from = 0, to = 66, by = 0.5), FUN = select_closer, age_vect = sea_lvl$age_MaBP)
#there are some intervals with lacks
ages <- sapply(X = sea_lvl$age_MaBP[selected_indices], FUN = round, digits = 1)
sel_sea_lvl <- sea_lvl$sealevel[selected_indices]
udc <- ages[which(ages %in% seq(0,66,0.5) == FALSE)]
to_add <- seq(0,66,0.5)[which(seq(0,66,0.5) %in% ages == FALSE)]
# replace udc by to_add
ages[which(ages %in% udc)] <- to_add
# dataframe
slvl <- data.frame(Age = ages,
                        Sea_level = sel_sea_lvl)
### Verification ###
# par(mfrow = c(1,2))
# plot(x = sea_lvl$age_MaBP, y = sea_lvl$sealevel)
# title("Original data")
# plot(x = slvl$Age, y = slvl$Sea_level)
# title("Scaled data")

# Full dataset
write.table.lucas(x = slvl %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/4-sea_level_Eoc_Olig_500ky_step.txt")
# post_EECO dataset
write.table.lucas(x = slvl %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/4-sea_level_post_EECO_500ky_step.txt")
# Oligocene dataset
write.table.lucas(x = slvl %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/4-sea_level_Oligocene_only_500ky_step.txt")


## Temporal patterns on the relative abundance of open habitats in Patagonia (Solórzano et Nuñez 2021 from Strömberg et al. 2013) ------------
p_open <- read_xlsx("./data_2023/MBD/raw_environment_correlates/vegetation_openness.xlsx")
interpol_op <- approx(x = p_open$Age[1:2], y = p_open$P_open[1:2], n=3)$y
for(i in 2:49){
  interpol_op <- c(interpol_op,
                   approx(x = p_open$Age[i:(i+1)], y = p_open$P_open[i:(i+1)], n=3)$y[-c(1)])
}
p_op_int <- data.frame(Age = seq(0, 49, 0.5),
                       P_open = interpol_op)
# Full dataset
write.table.lucas(x = p_op_int %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/5-habitat_openness_Eoc_Olig_500ky.txt")
# post_EECO dataset
write.table.lucas(x = p_op_int %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/5-habitat_openness_post_EECO_500ky.txt")
# Oligocene dataset
write.table.lucas(x = p_op_int %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/5-habitat_openness_Oligocene_only_500ky.txt")

## Relative Leaf Area Index (Dunn et al. 2015) -----------------------------------------------------------------------
rLAI <- read_xlsx("./data_2023/MBD/raw_environment_correlates/rLAI.xlsx")
interpol_rlai <- approx(x = rLAI$Age[1:2], y = rLAI$rLAI[1:2], n=3)$y
for(i in 2:38){
  interpol_rlai <- c(interpol_rlai,
                     approx(x = rLAI$Age[i:(i+1)], y = rLAI$rLAI[i:(i+1)], n=3)$y[-c(1)])
}
rlai_int <- data.frame(Age = seq(11, 49, 0.5),
                       rLAI = interpol_rlai)
# Full dataset
write.table.lucas(x = rlai_int %>% filter(Age >= 23 & Age <= 56),
                  file = "./data_2023/MBD/processed_predictors_full/6-rLAI_Eoc_Olig.txt")
# post_EECO dataset
write.table.lucas(x = rlai_int %>% filter(Age <= 51 & Age >= 34),
                  file = "./data_2023/MBD/processed_predictors_post_EECO/6-rLAI_post_EECO.txt")
# Oligocene dataset
write.table.lucas(x = rlai_int %>% filter(Age <= 34 & Age >= 23),
                  file = "./data_2023/MBD/processed_predictors_Oligocene_only/6-rLAI_Oligocene_only.txt")

## Andes 38 zones --------------------------------------------------------------
full_andes <- read_xlsx("./data_2023/MBD/raw_environment_correlates/Andes_38_zones/Andes_mean_elevations.xlsx")
full_andes <- full_andes[seq(2, nrow(full_andes), by = 2),]
full_andes$Falcon <- as.numeric(full_andes$Falcon)
# Northern tectonic regions
North <- c("santa_marta_massif", "maracaibo", "merida_venezuelan", "EC.N", "Garzon", "Falcon", "Perija.Santander",
           "Venezuelan_coastal_ranges", "CC.N", "Quebradagrande", "WC.N", "onshore_forearc_N", "middle_magdalena_valley_basin",
           "San_Lucas", "coastal_cordillera.NC", "WC.NC", "EC.NC", "Subandes.NC", "coastal_cordillera.C")
# Southern tectonic regions
South <- c("WC.C", "Altiplano", "western_Puna", "eastern_Puna", "EC.C", "Subandes.C", "Santa_Barbara", "coastal_cordillera.SC",
           "Main_cordillera.SC", "Frontal_cordillera.SC", "Precordillera.SC", "Sierras_Pampeanas", "Longitudinal_valley.S", 
           "Main_Cordillera.S", "east_Patagonia_high", "San_Jorge_Gulf", "Austral", "Neuquen")
# Averaging
av_nth <- apply(full_andes[, North], MARGIN = 1, FUN = mean, na.rm = T)
av_sth <- apply(full_andes[, South], MARGIN = 1, FUN = mean, na.rm = T)

# Interpolating and saving
  # North
interpol_nth <- approx(x = full_andes$age[1:2], y = av_nth[1:2], n=3)$y
for(i in 2:length(av_nth)){
  interpol_nth <- c(interpol_nth,
                    approx(x = full_andes$age[i:(i+1)], y = av_nth[i:(i+1)], n=3)$y[-c(1)])
}
f_north <- data.frame(Age = seq(from = 0, to = 80, by = 0.5),
                      Elevation = interpol_nth)
f_north_EOT <- f_north %>% filter(Age >= 23 & Age <= 56)
write.table.lucas(f_north_EOT,
                  "./data_2023/MBD/NORTH_processed_predictors/2-Andes_mean_elev_LOWLAT_500ky_step.txt")
  # South
interpol_sth <- approx(x = full_andes$age[1:2], y = av_sth[1:2], n=3)$y
for(i in 2:length(av_sth)){
  interpol_sth <- c(interpol_sth,
                    approx(x = full_andes$age[i:(i+1)], y = av_sth[i:(i+1)], n=3)$y[-c(1)])
}
f_south <- data.frame(Age = seq(from = 0, to = 80, by = 0.5),
                      Elevation = interpol_sth)
f_south_EOT <- f_south %>% filter(Age >= 23 & Age <= 56)
write.table.lucas(f_south_EOT,
                  "./data_2023/MBD/SOUTH_processed_predictors/2-Andes_mean_elev_HIGHLAT_500ky_step.txt")

# Plotting
  # Base
# par(mfrow = c(1, 2))
# plot(full_andes$age, av_nth, type = "l", main = "North", col = "red")
# for(col in North){
#   lines(x = full_andes$age, y = full_andes[, col][[1]])
# }
# plot(full_andes$age, av_sth, type = "l", main = "South", col = "red")
# for(col in South){
#   lines(x = full_andes$age, y = full_andes[, col][[1]])
# }
  # ggplot2
north_data <- full_andes %>%
  select(age, all_of(North)) %>%
  pivot_longer(cols = -age, names_to = "Locality", values_to = "Elevation") %>%
  mutate(Region = "Low latitude") %>%
  filter(age >= 23 & age <= 56)

south_data <- full_andes %>%
  select(age, all_of(South)) %>%
  pivot_longer(cols = -age, names_to = "Locality", values_to = "Elevation") %>%
  mutate(Region = "High latitude") %>%
  filter(age >= 23 & age <= 56)

  # Combine north and south data
plot_data <- bind_rows(north_data, south_data)

  # Create a data frame for the mean values to overlay
mean_data <- data.frame(
  age = full_andes$age,
  Mean = c(av_nth, av_sth),
  Region = rep(c("Low latitude", "High latitude"), each = length(av_nth))
)
mean_data <- mean_data %>% filter(age >= 23 & age <= 56)

  # Plot
p <- ggplot(plot_data, aes(x = age, y = Elevation)) +
  scale_x_reverse() +
  geom_line(aes(group = Locality), color = "#3690c0", alpha = 0.5) +  # Lines for each locality
  geom_line(data = mean_data, aes(x = age, y = Mean), color = "#045a8d", linewidth = 1.7)+  # Mean line in red
  facet_wrap(~Region, ncol = 2) +  # Separate panels for North and South
  labs(x = "Time (Ma)", y = "Elevation (m)") +
  theme_lucas(strip.background = element_rect(colour = "black", fill = "bisque2")) +
  coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

ggsave("./figures/supp_figs/andes_geo_strat/elevation_panel.pdf", plot = p, height = 90, width = 140, units = "mm")

## Environment variable plot for SI Appendix ---------------------------------
# Temperature
temp <- Temp_Cnz1 %>% 
  filter(Age > 24 & Age < 56) %>%
  ggplot(aes(x = Age, y = Temperature)) +
  geom_line(linewidth = 1.5, colour = "#d95f0e") +
  labs(x = "Time (Ma)", y = "Temperature (°C)") +
  ggtitle("Paleotemperature") +
  scale_x_reverse(breaks = seq(25, 55, 5)) +
  scale_y_continuous(breaks = seq(15, 30, 3),
                     limits = c(12, 33)) +
  theme_lucas() +
  coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

# Andean uplift
upl <- Andes %>% 
  filter(Age < 56 & Age > 24) %>% 
  ggplot(aes(x = Age, y = Altitude)) +
  geom_line(linewidth = 1.5, colour = "purple3") +
  labs(x = "Time (Ma)", y = "Elevation (m)") +
  ggtitle("Average andean uplift") +
  scale_x_reverse(breaks = seq(25, 55, 5)) +
  scale_y_continuous(breaks = seq(500, 1000, 100),
                     limits = c(450, 1050)) +
  theme_lucas() +
  coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

# Sea level
slv <- slvl %>% 
    filter(Age < 56 & Age > 24) %>% 
    ggplot(aes(x = Age, y = Sea_level)) +
    geom_line(linewidth = 1.5, colour = "skyblue3") +
    labs(x = "Time (Ma)", y = "Sea level (m)") +
    ggtitle("Eustatic variations") +
    scale_x_reverse(breaks = seq(25, 55, 5)) +
    scale_y_continuous(breaks = seq(-25, 75, 25),
                       limits = c(-50, 80)) +
    theme_lucas() +
    coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

# Plants
plants <- plant_processed %>% 
  filter(Age < 56 & Age > 24) %>% 
  ggplot(aes(x = Age, y = Plant_diversity)) +
  geom_line(linewidth = 1.5, colour = "#238b45") +
  labs(x = "Time (Ma)", y = "Number of taxa") +
  ggtitle("Neotropical Plant Diversity") +
  scale_x_reverse(breaks = seq(25, 55, 5)) +
  scale_y_continuous(breaks = seq(200, 350, 30),
                     limits = c(215, 360)) +
  theme_lucas() +
  coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

# Temporal patterns of open habitats
h_op <- p_op_int %>% 
  filter(Age < 56 & Age > 24) %>% 
  ggplot(aes(x = Age, y = P_open)) +
  geom_line(linewidth = 1.5, colour = "grey40") +
  labs(x = "Time (Ma)", y = "Nb. grassland taxa") +
  ggtitle("Patterns of hab. openness") +
  scale_x_reverse(breaks = seq(25, 55, 5)) +
  theme_lucas() +
  coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

# Relative leaf area index
rlai_p <- rlai_int %>% 
  filter(Age < 56 & Age > 24) %>% 
  ggplot(aes(x = Age, y = rLAI)) +
  geom_line(linewidth = 1.5, colour = "darkred") +
  labs(x = "Time (Ma)", y = "rLAI") +
  ggtitle("Relative leaf area index") +
  scale_x_reverse(breaks = seq(25, 55, 5)) +
  scale_y_continuous(breaks = seq(0, 3, 0.5),
                     limits = c(0, 3)) +
  theme_lucas() +
  coord_geo(dat = "epochs", abbrv = FALSE, size = 2.5, height = unit(1, "line")) +
  annotate(geom = "rect", xmin = 47.8, xmax = Inf, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = 33.9, xmax = 37.71, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0) +
  annotate(geom = "rect", xmin = -Inf, xmax = 27.8, fill = "grey50", ymin = -Inf, ymax = Inf, alpha = 0.2, linewidth = 0)

# Assemble and plot
tot_plot <- ggarrange(temp, upl, slv,
                      plants, h_op, rlai_p,
                      nrow = 2,
                      ncol = 3,
                      labels = c("(A)", "(B)", "(C)", "(D)", "(E)", "(F)"))
ggsave("./figures/supp_figs/evt_vbl_plot.pdf",
       plot = tot_plot,
       height = 150,
       width = 210,
       units = "mm")


