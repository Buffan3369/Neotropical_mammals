################################################################################
################################ Simulated LTT #################################
################################################################################

library(dplyr)
library(ggplot2)
library(deeptime)
library(hash)
library(randomcoloR)

source("~/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")

div_dict <- hash()


for(j in 0:12){
  simul_lin <- read.table(paste0("./data_2023/simulated_data/All_lineages_TsTe/100_replicates/sim_", j, ".txt"),
                          sep = "\t",
                          header = TRUE)
  time_ttl <- true_ltt(simul_lin)[[1]]
  cumul_occ <- true_ltt(simul_lin)[[2]]
  div_dict[paste0("time_", j)] <- time_ttl
  div_dict[paste0("div_", j)] <- cumul_occ
}

png("./figures/simulations/100_replicates/13_simulated_LTT.png", width = 1000, height = 1000)
plot(x = c(66.5, values(div_dict["time_0"])), 
     y = values(div_dict["div_0"]),
     type = "l", 
     col = randomColor(),
     xlab = "Time (MyBP)",
     ylab = "Diversity",
     xlim = c(56, 23),
     ylim = c(0, 180))

for(i in 1:12){
  lines(x = c(66.5, values(div_dict[paste0("time_", i)])), 
        y = values(div_dict[paste0("div_", i)]),
        type = "l",
        col = randomColor())
}
dev.off()
