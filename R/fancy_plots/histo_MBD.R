################################################################################
################## Summarising the output of the MBD model #####################
################################################################################

library(ggplot2)
library(rphylopic)
library(ggpubr)
library(psych)
library(hash)

phylopic_sp_names <- hash("Sparassodonta" = "Thylacosmilus atrox",
                          "Cingulata" = "Dasypus novemcinctus",
                          "Pilosa" = "Megatherium americanum",
                          "Notoungulata" = "Mixotoxodon larensis",
                          "Rodentia" = "Hydrochoerus hydrochaeris")
img_aest <- hash("Sparassodonta" = c(2.5, 0.5), # y, ysize
                 "Cingulata" = c(-2, 1.8),
                 "Pilosa" = c(-2, 1.3),
                 "Notoungulata" = c(2, 0.85),
                 "Rodentia" = c(2, 2.5)
                 )

## Computing Bayes factor to decide which of the linear or exponential model is the best 
order <- "Sparassodonta"
#Open MBD outputs
MBD_expo <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_exp_MBD.log"), header = TRUE)
MBD_lin <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_lin_MBD.log"), header = TRUE)
#Remove burn-in
burn_in <- 100
MBD_expo <- MBD_expo[burn_in:nrow(MBD_expo),]
MBD_lin <- MBD_lin[burn_in:nrow(MBD_lin),]

#Harmonic mean of likelihoods of the two models
LK_lin <- harmonic.mean(MBD_lin$likelihood)
LK_expo <- harmonic.mean(MBD_expo$likelihood)

#Bayes factor
BF <- 2*(LK_expo - LK_lin)






for(order in c("Sparassodonta", "Cingulata", "Pilosa", "Notoungulata", "Rodentia", "all_in_one", "one_place-one_time-one_occ")){
  MBD_lin <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_lin_MBD.log"), header = TRUE)
  MBD_expo <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_exp_MBD.log"), header = TRUE)
  #Remove burn-in
  burn_in <- 100
  MBD <- MBD[100:nrow(MBD),]
  #Mean marginal probabilities
  LK_lin <- mean(MBD_lin$)
}


## With fragmentation ----------------------------------------------------------
for(order in c("Sparassodonta", "Cingulata", "Pilosa", "Notoungulata", "Rodentia")){
  MBD <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_exp_MBD.log"), header = TRUE)
  #Remove burn-in
  burn_in <- 40
  MBD <- MBD[40:nrow(MBD),]
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
    speciation_r <- mean(MBD[, paste0("Gl0_",i)])
    extinction_r <- mean(MBD[, paste0("Gm0_",i)])
    #mean posterior estimate for shrinkage weights
    speciation_w <- mean(MBD[, paste0("Wl0_",i)])
    extinction_w <- mean(MBD[, paste0("Wm0_",i)])
    #add to plot dataset
    plot_df$correlation_parameter[(2*i+1):(2*i+2)] <- c(speciation_r, extinction_r)
    plot_df$shrinkage_weight[(2*i+1):(2*i+2)] <- c(speciation_w, extinction_w)
  }
  #Incorporate significance levels
  plot_df$signif <- NA
  plot_df$signif[which(plot_df$shrinkage_weight > 0.5)] <- "*"
  #Get corresponding image on phylopic
  uuid <- rphylopic::get_uuid(name = values(phylopic_sp_names[order]), n = 1)
  img <- rphylopic::get_phylopic(uuid = uuid)
  #Plot
  p <- ggplot(data = plot_df, aes(x = var, y = correlation_parameter, fill = rate_type)) +
    geom_bar(stat="identity", position=position_dodge()) +
    scale_fill_manual(values = c("#e34a33", "#4c4cec")) +
    labs(x = NULL,
         y = "Correlation parameter",
         fill = "Rate") +
    ggtitle(order) +
    geom_text(aes(label = signif), vjust = rep(c(0, 1.5), 7), size = 10) +
    theme(plot.margin = margin(5, 10, 5, 10, "mm"),
          axis.title.x = element_text(size = 14),
          axis.title.y = element_text(size = 14),
          axis.text = element_text(size = 12),
          plot.title = element_text(size = 15, hjust = 0.5),
          text = element_text(size = 10),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_flip() +
    add_phylopic(img = img,
                 x = 7,
                 y = values(img_aest[order])[1],
                 ysize = values(img_aest[order])[2]
                 )
  
  ggsave(paste0("./figures/MBD_outputs/", order, ".png"),
         plot = p,
         height = 200,
         width = 350,
         units = "mm",
         dpi = 600)
}

## Without fragmentation -------------------------------------------------------
for(order in c("Sparassodonta", "Cingulata", "Pilosa", "Notoungulata", "Rodentia")){
  MBD <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_exp_MBD.log"), header = TRUE)
  #Remove burn-in
  burn_in <- 40
  MBD <- MBD[40:nrow(MBD),]
  #Remove fragmentation
  MBD <- MBD[, !(colnames(MBD) %in% c("Gl0_1", "Gm0_1", "Wl0_1", "Wm0_1"))]
  #Prepare plot dataset
  plot_df <- data.frame(rate_type = rep(c("Speciation", "Extinction"), 6),
                        var = c("Self-diversity", "Self-diversity",
                                "Andean Uplift", "Andean Uplift", "Temperature", "Temperature",
                                "Atmospheric Carbon", "Atmospheric Carbon", "Organic Carbon", "Organic Carbon",
                                "Sea Level", "Sea Level"), #ordered in the same way as in the dataset
                        correlation_parameter = rep(NA, 12),
                        shrinkage_weight = rep(NA, 12))
  #Incorporate correlation parameter values and shrinkage weights
  for(i in c(0, 2:6)){
    #mean posterior estimate for correlation parameters
    speciation_r <- mean(MBD[, paste0("Gl0_",i)])
    extinction_r <- mean(MBD[, paste0("Gm0_",i)])
    #mean posterior estimate for shrinkage weights
    speciation_w <- mean(MBD[, paste0("Wl0_",i)])
    extinction_w <- mean(MBD[, paste0("Wm0_",i)])
    #add to plot dataset
    if(i > 0){
      j <- i-1
      plot_df$correlation_parameter[(2*j+1):(2*j+2)] <- c(speciation_r, extinction_r)
      plot_df$shrinkage_weight[(2*j+1):(2*j+2)] <- c(speciation_w, extinction_w)
    }
    else{
      plot_df$correlation_parameter[(2*i+1):(2*i+2)] <- c(speciation_r, extinction_r)
      plot_df$shrinkage_weight[(2*i+1):(2*i+2)] <- c(speciation_w, extinction_w)
    }
  }
  #Incorporate significance levels
  plot_df$signif <- NA
  plot_df$signif[which(plot_df$shrinkage_weight > 0.5)] <- "*"
  #Plot
  p <- ggplot(data = plot_df, aes(x = var, y = correlation_parameter, fill = rate_type)) +
    geom_bar(stat="identity", position=position_dodge()) +
    scale_fill_manual(values = c("#e34a33", "#4c4cec")) +
    labs(x = NULL,
         y = "Correlation parameter",
         fill = "Rate") +
    ggtitle(order) +
    geom_text(aes(label = signif), vjust = rep(c(0, 1.5), 6), size = 10) +
    theme(plot.margin = margin(5, 10, 5, 10, "mm"),
          axis.title.x = element_text(size = 14),
          axis.title.y = element_text(size = 14),
          axis.text = element_text(size = 12),
          plot.title = element_text(size = 15, hjust = 0.5),
          text = element_text(size = 10),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_flip()
  
  ggsave(paste0("./figures/MBD_outputs/", order, "_no_fragmentation.png"),
         plot = p,
         height = 200,
         width = 350,
         units = "mm",
         dpi = 600)
}
