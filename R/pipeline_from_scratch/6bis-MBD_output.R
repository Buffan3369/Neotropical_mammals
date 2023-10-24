################################################################################
############################# Treat MBD outputs ################################
################################################################################

library(dplyr)
library(hash)
library(ggplot2)
library(rempsyc)

## Dictionary containing the corresponding index of the covariates -------------
cov_idx <- hash("0" = "Self-diversity",
                "1" = "Plant_diversity",
                "2" = "Andes_elevation",
                "3" = "Temperature",
                "4" = "Atmospheric_carbon",
                "5" = "Organic_carbon",
                "6" = "Sea_level")

## Hand scaling ----------------------------------------------------------------
recap_tbl <- read.table("../../MBD/EOCENE_OLIGOCENE/model_scaling/Full/ESS_summary.txt", 
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
# 3) open the combined mcmc.log file and retain the distributions of the selected G
mcmcLog <- read.table("../../MBD/EOCENE_OLIGOCENE/model_scaling/Full/combined_4MBD.log",
                      header = TRUE, sep = "\t")
#only retain significant correlation parameters and subsample to make it lighter
mcmcLog <- mcmcLog %>% select(any_of(corr_vbl))
mcmcLog1 <- data.frame(apply(X = mcmcLog, FUN = sample, MARGIN = 2, size = 1000))
colnames(mcmcLog1) <- colnames(mcmcLog)
#reformat dataset for plotting
equiv_param <- hash("Gl0_0"=1, "Gm0_0"=2, "Gm0_2"=3, "Gm0_3"=4, "Gm0_4"=5)
value <- mcmcLog1[, 1]
param <- rep(1, length(mcmcLog1[, 1]))
if("l" %in% strsplit(colnames(mcmcLog1)[1], "")[[1]]){ #lambda
  rate <- rep("Origination", length(mcmcLog1[, 1]))
}
if("m" %in% strsplit(colnames(mcmcLog1)[1], "")[[1]]){ #lambda
  rate <- rep("Extinction", length(mcmcLog1[, 1]))
}

for(i in colnames(mcmcLog1)[-1]){
  value <- c(value, mcmcLog1[, i])
  param <- c(param, rep(which(colnames(mcmcLog1) == i), length(mcmcLog1[, i])))
  if("l" %in% strsplit(i, "")[[1]]){ #lambda
    rate <- c(rate, rep("Origination", length(mcmcLog1[, i])))
  }
  else if("m" %in% strsplit(i, "")[[1]]){ #mu
    rate <- c(rate, rep("Extinction", length(mcmcLog1[, i])))
  }
}
plot_df <- data.frame(value = value, param = param, rate = rate)
#plot

ggplot(data = plot_df, aes(x = factor(param), y = value)) +
  geom_violin(adjust = .75, draw_quantiles = c(0.025, 0.975), scale = "width", aes(fill = factor(rate))) +
  stat_summary(fun.y=mean, geom="point", size=1, color = "black") +
  scale_color_manual(values = c("#4c4cec", "#e34a33")) +
  scale_y_continuous(limits = c(-8, 3)) +
  scale_x_discrete(breaks = 1:5,
                     labels = c(keys(equiv_param))) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey60") +
  labs(x = NULL,
       y = "Correlation coefficient",
       fill = NULL) +
  theme(axis.title = element_text(size = 18),
        axis.text = element_text(size = 18),
        legend.text = element_text(size = 12),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_flip()


