################################################################################
################## Summarising the output of the MBD model #####################
################################################################################

library(ggplot2)
library(ggpubr)
library(hash)
library(psych)
library(rphylopic)
library(vctrs)

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
  #Function to assess the level of support of one model against the other one based on Bayes Factor table
assess_support <- function(BF){ #BF has to be absolute
  if((BF > 0)&(BF <= 1/2)){
    return("Almost not worth mentioning")
  }
  else if((BF>1/2)&(BF<=1)){
    return("Substantial support")
  }
  else if((BF>1)&(BF<=2)){
    return("Strong support")
  }
  else{
    return("Decisive support")
  }
}

#Additional parameters
params <- hash("BF_test" = TRUE, #If set to TRUE => perform the Bayes factor test and select best between linear and expo
               "burn_in" = 100,
               "show.fragmentation" = FALSE #If set to TRUE, fragmentation is displayed on the plots
               )
#Loop
for(order in c("Sparassodonta", "Cingulata", "Pilosa", "Notoungulata", "Rodentia", "all_in_one", "one_place-one_time-one_occ")){
  print(order)
  if(params$BF_test == TRUE){
    MBD_lin <- read.table(paste0("../../MBD/June_2023/", order, "/", order, "_combined_se_est_0_lin_MBD.log"), header = TRUE)
    MBD_expo <- read.table(paste0("../../MBD/June_2023/", order, "/", order, "_combined_se_est_0_exp_MBD.log"), header = TRUE)
    #Remove burn-in
    MBD_expo <- MBD_expo[params$burn_in:nrow(MBD_expo),]
    MBD_lin <- MBD_lin[params$burn_in:nrow(MBD_lin),]
    #Harmonic mean of likelihoods of the two models
    LK_lin <- harmonic.mean(MBD_lin$likelihood)
    LK_expo <- harmonic.mean(MBD_expo$likelihood)
    #Bayes Factor (exponential v.s. linear)
    BF <- 2*(LK_expo - LK_lin)
    if(BF > 0){
      print(paste0(assess_support(abs(BF)), " for exponential model"))
      MBD <- MBD_expo
      type <- "expo"
    }
    else{
      print(paste0(assess_support(abs(BF)), " for linear model"))
      MBD <- MBD_lin
      type <- "lin"
    }
  }
  else{
    MBD <- read.table(paste0("../../MBD/", order, "/", order, "_combined_se_est_0_exp_MBD.log"), header = TRUE)
    MBD <- MBD[params$burn_in:nrow(MBD),]
    type <- "expo"
  }
  # Match predictor names
  cor_col <- colnames(MBD)[grep(pattern = "Gl0_", colnames(MBD))]
  var_nb <- unlist(lapply(X = cor_col, 
                          FUN = function(x){
                            spl <- strsplit(x, "_")[[1]][2]
                            return(as.numeric(spl))
                            }
                          ))
  if(params$show.fragmentation == TRUE){
    var <- c("Self-diversity", "Self-diversity", "Fragmentation", "Fragmentation",
             "Andean Uplift", "Andean Uplift", "Temperature", "Temperature",
             "Atmospheric Carbon", "Atmospheric Carbon", "Organic Carbon", "Organic Carbon",
             "Sea Level", "Sea Level") #ordered in the same way as in the dataset
    tag_frag <- "frag"
  }
  else{
    var_nb <- var_nb[-which(var_nb == 1)]
    var <- c("Self-diversity", "Self-diversity",
             "Andean Uplift", "Andean Uplift", "Temperature", "Temperature",
             "Atmospheric Carbon", "Atmospheric Carbon", "Organic Carbon", "Organic Carbon",
             "Sea Level", "Sea Level") #ordered in the same way as in the dataset
    tag_frag <- "no_frag"
  }
  
  if(length(var_nb) > length(var)/2){ #The 6 abiotic (5 if fragmentation removed) var + self-diversity, minimal nb of var
    #pick diversity-related predictors among all
    files <- Sys.glob(paste0("../../MBD/", order, "/predictors/", "*_ltt_500ky_step.txt"))
    div_related <- unlist(lapply(X = files,
                                 FUN = function(x){
                                   spl <- strsplit(x, "/")[[1]]
                                   return(spl[length(spl)])
                                 }))
    #Extract related order names
    orders <- unlist(lapply(X = div_related,
                            FUN = function(x){
                              spl <- strsplit(x, split = "_")[[1]]
                              return(spl[1])
                            }))
    orders <- vec_rep_each(sort(orders), 2)
    var <- c(var, orders)
  }
  plot_df <- data.frame(rate_type = rep(c("Origination", "Extinction"), length(var_nb)),
                        var = var,
                        correlation_parameter = rep(NA, 2*length(var_nb)),
                        shrinkage_weight = rep(NA, 2*length(var_nb)))
  #Incorporate correlation parameter values and shrinkage weights
  for(i in var_nb){
    #mean posterior estimate for correlation parameters
    Origination_r <- mean(MBD[, paste0("Gl0_",i)])
    extinction_r <- mean(MBD[, paste0("Gm0_",i)])
    #mean posterior estimate for shrinkage weights
    Origination_w <- mean(MBD[, paste0("Wl0_",i)])
    extinction_w <- mean(MBD[, paste0("Wm0_",i)])
    #add to plot dataset
    if((params$show.fragmentation == FALSE) & (i>1)){
      plot_df$correlation_parameter[(2*(i-1)+1):(2*(i-1)+2)] <- c(Origination_r, extinction_r)
      plot_df$shrinkage_weight[(2*(i-1)+1):(2*(i-1)+2)] <- c(Origination_w, extinction_w)
    }
    else{
      plot_df$correlation_parameter[(2*i+1):(2*i+2)] <- c(Origination_r, extinction_r)
      plot_df$shrinkage_weight[(2*i+1):(2*i+2)] <- c(Origination_w, extinction_w)
    }
  }
  #Incorporate significance levels
  plot_df$signif <- NA
  plot_df$signif[which(plot_df$shrinkage_weight > 0.5)] <- "*"
  # #Get corresponding image on phylopic
  # uuid <- rphylopic::get_uuid(name = values(phylopic_sp_names[order]), n = 1)
  # img <- rphylopic::get_phylopic(uuid = uuid)
  #Plot
  p <- ggplot(data = plot_df, aes(x = var, y = correlation_parameter, fill = rate_type)) +
    geom_bar(stat="identity", position=position_dodge()) +
    scale_fill_manual(values = c("#e34a33", "#4c4cec")) +
    labs(x = NULL,
         y = "Correlation parameter",
         fill = "Rate") +
    ggtitle(order) +
    geom_text(aes(label = signif), vjust = rep(c(0, 1.5), length(var_nb)), size = 10) +
    theme(plot.margin = margin(5, 10, 5, 10, "mm"),
          axis.title.x = element_text(size = 14),
          axis.title.y = element_text(size = 14),
          axis.text = element_text(size = 12),
          plot.title = element_text(size = 15, hjust = 0.5),
          text = element_text(size = 10),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_flip() 
  # +
  #   add_phylopic(img = img,
  #                x = 7,
  #                y = values(img_aest[order])[1],
  #                ysize = values(img_aest[order])[2])
  
  ggsave(paste0("./figures/MBD_outputs/", order, "/", order, "_", type, "_", tag_frag, "_",".png"),
         plot = p,
         height = 200,
         width = 350,
         units = "mm",
         dpi = 600)
}
