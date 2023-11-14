################################################################################
################################ Simulated LTT #################################
################################################################################

library(dplyr)
library(ggplot2)
library(deeptime)
library(hash)
library(randomcoloR)

div_dict <- hash()

for(j in 0:9){
  simul_lin <- read.table(paste0("./data_2023/simulated_data/All_lineages_TsTe/sim_", j, ".txt"),
                          sep = "\t",
                          header = TRUE)
  ts_count <- simul_lin %>% count(ts)
  te_count <- simul_lin %>% count(te)
  
  time_ttl <- unique(sort(c(ts_count$ts, te_count$te), decreasing = TRUE))
  
  cumul_occ <- c(0)
  for(i in 1:length(time_ttl)){
    t <- time_ttl[i]
    N <- cumul_occ[i] #previous
    if(t %in% ts_count$ts == FALSE){ #necessarily in te_count
      idx <- which(te_count$te == t)
      cumul_occ <- c(cumul_occ, (N - te_count$n[idx])) #counted negatively, min age of the occ(s)
    }
    else if(t %in% te_count$te == FALSE){ #necessarily in ts_count
      idx <- which(ts_count$ts == t)
      cumul_occ <- c(cumul_occ, (N + ts_count$n[idx])) #counted positively, max age of the occ(s)
    }
    else{ #t both in min and max ages
      idx_min <- which(te_count$te == t)
      idx_max <- which(ts_count$ts == t)
      cumul_occ <- c(cumul_occ, (N + ts_count$n[idx_max] - te_count$n[idx_min])) #birth - death
    }
  }
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
