################################################################################
################## Summarising the output of the MBD model #####################
################################################################################

library(ggplot2)
library(ggpubr)

SparassoMBD <- read.table("../../MBD/Sparassodonta/Sparassodonta_combined_se_est_0_exp_MBD.log", header = TRUE)
#Remove burn-in
burn_in <- 40
SparassoMBD <- SparassoMBD[40:nrow(SparassoMBD),]
#Prepare plot dataset
plot_df <- data.frame(rate_type = rep(c("Speciation", "Extinction"), 7),
                      var = c("Self-diversity", "Self-diversity", "Fragmentation", "Fragmentation",
                              "Andean Uplift", "Andean Uplift", "Temperature", "Temperature",
                              "Atmospheric Carbon", "Atmospheric Carbon", "Organic Carbon", "Organic Carbon",
                              "Sea Level", "Sea Level"), #ordered in the same way as in the dataset
                      correlation_parameter = rep(NA, 14),
                      shrinkage_weight = rep(NA, 14))
#Incorporate correlation parameter values and shrinkage weights
for(i in 0:6){
  #mean posterior estimate for correlation parameters
  speciation_r <- mean(SparassoMBD[, paste0("Gl0_",i)])
  extinction_r <- mean(SparassoMBD[, paste0("Gm0_",i)])
  #mean posterior estimate for shrinkage weights
  speciation_w <- mean(SparassoMBD[, paste0("Wl0_",i)])
  extinction_w <- mean(SparassoMBD[, paste0("Wm0_",i)])
  #add to plot dataset
  plot_df$correlation_parameter[(2*i+1):(2*i+2)] <- c(speciation_r, extinction_r)
  plot_df$shrinkage_weight[(2*i+1):(2*i+2)] <- c(speciation_w, extinction_w)
}
# Incorporate significance levels
plot_df$signif <- NA
plot_df$signif[which(plot_df$shrinkage_weight > 0.5)] <- "*"
#plot
p <- ggplot(data = plot_df, aes(x = var, y = correlation_parameter, fill = rate_type)) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_fill_manual(values = c("#e34a33", "#4c4cec")) +
  labs(x = NULL,
       y = "Correlation parameter",
       fill = "Rate") +
  ggtitle("Sparassodonta") +
  geom_text(aes(label = signif), vjust = rep(c(0, 1.5), 7), size = 10) +
  theme(plot.margin = margin(5, 10, 5, 10, "mm"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 15, hjust = 0.5),
        text = element_text(size = 10),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_flip()

ggsave("./figures/MBD_outputs/Sarassodonta.png",
       plot = p,
       height = 200,
       width = 350,
       units = "mm",
       dpi = 600)
