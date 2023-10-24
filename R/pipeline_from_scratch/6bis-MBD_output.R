################################################################################
############################# Treat MBD outputs ################################
################################################################################

library(EvoPhylo)
library(dplyr)

## Hand scaling ----------------------------------------------------------------
recap_tbl <- read.table("../../MBD/EOCENE_OLIGOCENE/hand.scale_only/Full/ESS_summary.txt", 
                        sep = "\t", header = TRUE)
if(length(which(recap_tbl$ESS_posterior < 200)) > 0){
  recap_tbl <- recap_tbl[-which(recap_tbl$ESS_posterior < 200), ]
}
#add the mean row in last position
recap_tbl[nrow(recap_tbl)+1, ] <- apply(X = recap_tbl, MARGIN = 2, FUN = mean, na.rm = TRUE)
#subset mean Shrinkage Weights (SW)
mean_SW <- recap_tbl %>% select(starts_with("Mean_W"))
# 1) get column names of the SW > 0.5
ns_names <- colnames(mean_SW)[which(mean_SW[5, ] < 0.5)]
mean_SW_sign <- mean_SW[, !(colnames(mean_SW) %in% ns_names)]
#go back to the corresponding variable
end_nm <- function(name){
  spl <- strsplit(name, split = "")[[1]]
  spl <- spl[(length(spl)-3):length(spl)]
  return(paste0("G", spl[1], spl[2], spl[3], spl[4])) #the "G" stands for the corr
}
corr_vbl <- unlist(lapply(X = colnames(mean_SW_sign),
                          FUN = end_nm))
#subset
recap_tbl_sign <- recap_tbl %>% select(ends_with(corr_vbl))
# 2) check if zero is in the 94% HPD
zeros <- c() #will contain the names of the coefficients with 0 in 94% HPD
for(vbl in corr_vbl){
  tmp <- recap_tbl_sign %>% select(ends_with(vbl))
  if(sign(tmp[5, paste0("min_HPD_", vbl)]) != sign(tmp[5, paste0("min_HPD_", vbl)]) ){
    zeros <- c(zeros, vbl)
  }
}
if(length(zeros) > 0){
  corr_vbl <- corr_vbl[-which(corr_vbl %in% zeros)]
  recap_tbl_sign <- recap_tbl_sign %>% select(ends_with(corr_vbl))
}
if(length(mean_SW_sign) == 0){
  next
}
# 3) open the mcmc.log file and retain the distributions of the selected G
mcmcLog <- combine_log("../../MBD/EOCENE_OLIGOCENE/hand.scale_only/Full/", burnin = recap_tbl$burnin[5], downsample = 1)


