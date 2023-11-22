################################################################################
################################ Simulated LTT #################################
################################################################################

library(dplyr)
library(ggplot2)
library(deeptime)
library(hash)
library(randomcoloR)

source("C:/Users/lucas/OneDrive/Documents/GitHub/CorsaiR/R/2-plotting_facilities.R")

div_dict <- hash()

for(j in 0:9){
  simul_lin <- read.table(paste0("./data_2023/simulated_data/All_lineages_TsTe/sim_", j, ".txt"),
                          sep = "\t",
                          header = TRUE)
  time_ttl <- true_ltt(simul_lin)[[1]]
  cumul_occ <- true_ltt(simul_lin)[[2]]
  div_dict[paste0("time_", j)] <- time_ttl
  div_dict[paste0("div_", j)] <- cumul_occ
}


plot(x = c(66.5, values(div_dict["time_0"])), 
     y = values(div_dict["div_0"]),
     type = "l", 
     col = randomColor(),
     xlab = "Time (MyBP)",
     ylab = "Diversity")

for(i in 1:9){
  lines(x = c(66.5, values(div_dict[paste0("time_", i)])), 
        y = values(div_dict[paste0("div_", i)]),
        type = "l",
        col = randomColor())
}
