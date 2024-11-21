################################################################################
# Name: 10-Recap_tbl_MBD.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for summarising MBD outputs as tables.
################################################################################

source("./R/useful/4b-MBD_accessory.R")

library(hash)

## Define covariable names -----------------------------------------------------
covar_idx <- hash("0" = "Self-diversity",
                  "1" = "Plant Diversity",
                  "2" = "Andes Elevation",
                  "3" = "Global Temperature",
                  "4" = "Sea Level",
                  "5" = "Habitat Openness",
                  "6" = "Forest Density")

## Directories -----------------------------------------------------------------
dirs <- c("1-Full_stringent_partitioning", "1-Full_stringent_partitioning/post_EECO", "1-Full_stringent_partitioning/Oligocene_only")
## Loop for full-time panels ---------------------------------------------------
for(salma in c("SALMA_smoothed")){
  for(dir in dirs){
    rid <- paste0("./results_EXTENDED/MBD/", salma, "/genus_level/", dir, "/")
    # 2.5, 50 and 97.5% quantiles for G coefficients
    G_post <- get_post(rid, param = "G")
    mid_qG <- apply(G_post, MARGIN = 2, FUN = function(x){
      val <- as.numeric(quantile(x, probs = c(0.5)))
      return(round(val, digits = 3))
      })
    HPD_G <- apply(G_post, MARGIN = 2, FUN = function(x){
      q <- as.numeric(quantile(x, probs = c(0.025, 0.975)))
      return(paste0("[", round(q[1], digits = 3), "; ", round(q[2], digits = 3), "]"))
      })
    # 2.5, 50 and 97.5% quantiles for W coefficients
    W_post <- get_post(rid, param = "W")
    mid_qW <- apply(W_post, MARGIN = 2, FUN = function(x){
      val <- as.numeric(quantile(x, probs = c(0.5)))
      return(round(val, digits = 3))
    })    
    HPD_W <- apply(W_post, MARGIN = 2, FUN = function(x){
      q <- as.numeric(quantile(x, probs = c(0.025, 0.975)))
      return(paste0("[", round(q[1], digits = 3), "; ", round(q[2], digits = 3), "]"))
    })
    # merge all
    merged <- data.frame(Covar = values(covar_idx),
                         G_lamb = mid_qG[1:7],
                         G_lamb_95HPD = HPD_G[1:7],
                         W_G_lamb = mid_qW[1:7],
                         W_G_lamb_95HPD = HPD_W[1:7],
                         G_mu = mid_qG[8:14],
                         G_mu_95HPD = HPD_G[8:14],
                         W_G_mu = mid_qW[8:14],
                         W_G_mu_95HPD = HPD_W[8:14])
    suf <- strsplit(dir, split = "/")[[1]]
    # last adjustment for saving the output
    if(strsplit(dir, split = "-")[[1]][1] == "1"){
      if(length(suf) == 1){
        fix <- "complete"
      }
      else{
        fix <- suf[2]
      }
      write.table(merged, paste0("./figures/supp_figs/tables_MBD/", suf[1], "_", fix, ".txt"), sep = "\t", 
                  quote = FALSE, row.names = FALSE)
    }
    if(strsplit(dir, split = "-")[[1]][1] == "6"){
      if(length(suf) == 2){
        fix <- "complete"
      }
      else{
        fix <- suf[3]
      }
      write.table(merged, paste0("./figures/supp_figs/tables_MBD/", suf[2], "_", fix, ".txt"), sep = "\t", 
                  quote = FALSE, row.names = FALSE)
    }
  }
}
