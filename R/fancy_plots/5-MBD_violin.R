################################################################################
# Name: 5-MBD_violin.R
# Author: Lucas Buffan
# Date: 2024-02-05
# Aim: Summarising MBD outputs as Violin plots
################################################################################

library(dplyr)
library(hash)
library(ggplot2)

## Dictionary containing the corresponding index of the covariates -------------
covar_idx <- hash("0" = "Self-diversity",
                "1" = "Plant_diversity",
                "2" = "Andes_elevation",
                "3" = "Temperature",
                "4" = "Atmospheric_carbon",
                "5" = "Organic_carbon",
                "6" = "Sea_level")

covar_idx_diet <- hash("0" = "Self-diversity",
                     "1" = "Plant_diversity",
                     "2" = "Andes_elevation",
                     "3" = "Temperature",
                     "4" = "Atmospheric_carbon",
                     "5" = "Organic_carbon",
                     "6" = "Sea_level",
                     "7" = "Carnivorous_diversity",
                     "8" = "Herbivorous_diversity",
                     "9" = "Insectivorous_diversity",
                     "10" = "Omnivorous_diversity")

## Different outputs to analyse ------------------------------------------------
# DIRS <- c("1-Full", "1-Full/Eocene_only", "1-Full/Oligocene_only", "4-Tropical_Extratropical/Tropical", "4-Tropical_Extratropical/Tropical/Eocene_only",
#           "4-Tropical_Extratropical/Tropical/Oligocene_only", "4-Tropical_Extratropical/Extratropical", 
#           "4-Tropical_Extratropical/Extratropical/Eocene_only", "4-Tropical_Extratropical/Extratropical/Oligocene_only", "5-Ecomorphotype/carnivore", 
#           "5-Ecomorphotype/herbivore", "5-Ecomorphotype/omnivore", "5-Ecomorphotype/insectivore")
DIRS <- c("1-Full", "1-Full/Eocene_only", "1-Full/Oligocene_only")

## Big loop --------------------------------------------------------------------
for(trt in DIRS){
  cat(paste0("\n Analysing ", trt, " outputs \n"))
  # Select right set of covariates
  if(strsplit(trt, "-")[[1]][1] == "5"){
    cov_idx <- covar_idx_diet
  }
  else{
    cov_idx <- covar_idx
  }
  # MCMC recap table
  recap_tbl <- read.table(paste0("./results/MBD/", trt, "/ESS_summary.txt"), 
                          sep = "\t", header = TRUE)
  #remove parameters that did not converge fomr recap_tbl
  if(length(which(recap_tbl$ESS_posterior < 200)) > 0){
    recap_tbl <- recap_tbl[-which(recap_tbl$ESS_posterior < 200), ]
  }
  n_conv <- nrow(recap_tbl) #number of runs that converged, useful as in the name of the combined mcmc log file
  #add the mean row in last position
  recap_tbl[nrow(recap_tbl)+1, ] <- apply(X = recap_tbl, MARGIN = 2, FUN = mean, na.rm = TRUE)
  #subset mean Shrinkage Weights (SW)
  mean_SW <- recap_tbl %>% select(starts_with("Mean_W"))
  
  #Open combined mcmc.log file and retain the distributions of the selected G
  mcmcLog <- read.table(paste0("./results/MBD/", trt, "/combined_", n_conv, "_KEEP.log"),
                        header = TRUE, sep = "\t")
  mcmcLog <- mcmcLog %>% select(starts_with("G")) #only retain correlation parameters
  
  ## 1) get column names of the SW > 0.5 ---------------------------------------
  ns_names <- colnames(mean_SW)[which(mean_SW[nrow(mean_SW), ] < 0.5)] #remember that the last one is the total
  mean_SW_sign <- mean_SW[, !(colnames(mean_SW) %in% ns_names)]
  #go back to the corresponding variable
  end_nm <- function(name){
    spl <- strsplit(name, split = "")[[1]]
    spl <- spl[(length(spl)-3):length(spl)]
    return(paste0("G", spl[1], spl[2], spl[3], spl[4])) #the "G" stands for the corr
  }
  corr_vbl <- sapply(X = colnames(mean_SW_sign),
                     FUN = end_nm)
  #subset
  if(length(corr_vbl) == 0){ # if no variable found with SW > 0.5, don't go further
    cat("\nNo significant correlation coefficient found.\n")
    recap_tbl_sign <- NULL
  }
  else{
    recap_tbl_sign <- recap_tbl %>% select(ends_with(corr_vbl))
    # 3) check if zero is in the 95% HPD
    zeros <- c()
    for(G in colnames(mcmcLog)){
      #5 and 95% quantiles of the distribution
      Q <- as.numeric(quantile(mcmcLog[, G], probs = c(0.025, 0.975)))
      if(length(unique(sign(Q))) > 1){ #if these boundaries have different signs, i.e. 0 is in 95% HPD
        zeros <- c(zeros, G)
      }
    }
    #remove variables including zero in their 95% HPD from the list of the significant variables
    if(length(zeros) > 0){
      corr_vbl <- corr_vbl[-which(corr_vbl %in% zeros)]
      if(length(corr_vbl) == 0){
        message("\nNo significant correlation coefficient found.\n")
        recap_tbl_sign <- NULL
      }
      else{
        recap_tbl_sign <- recap_tbl_sign %>% select(ends_with(corr_vbl))
      }
    }
  }

  # 4) reformat dataset for plotting
  value <- mcmcLog[, 1]
  param <- rep(0, nrow(mcmcLog))
  col <- rep(colnames(mcmcLog)[1], nrow(mcmcLog))
  if("l" %in% strsplit(colnames(mcmcLog)[1], "")[[1]]){ #lambda
    rate <- rep("Origination", length(mcmcLog[, 1]))
  }
  if("m" %in% strsplit(colnames(mcmcLog)[1], "")[[1]]){ #mu
    rate <- rep("Extinction", length(mcmcLog[, 1]))
  }
  #specify whether parameter associated to origination or extinction rate
  for(i in colnames(mcmcLog)[-1]){
    col <- c(col, rep(i, nrow(mcmcLog)))
    value <- c(value, mcmcLog[, i])
    p <- strsplit(i, split = "_")[[1]][2]
    param <- c(param, rep(as.numeric(p), nrow(mcmcLog)))
    if("l" %in% strsplit(i, "")[[1]]){ #lambda
      rate <- c(rate, rep("Origination", nrow(mcmcLog)))
    }
    else if("m" %in% strsplit(i, "")[[1]]){ #mu
      rate <- c(rate, rep("Extinction", nrow(mcmcLog)))
    }
  }
  plot_df <- data.frame(param = param, rate = rate, col = col, value = value)
  #significance dataframe
  if(length(corr_vbl) > 0){ #if we have significant correlation coefficients
    signif_df <- plot_df %>% 
      mutate(col = ifelse(col %in% corr_vbl, "*", NA)) %>% #if the correlation coefficient was found significant, we add a star
      group_by(param, rate, col) %>%
      summarise(max_val = max(density(value)[[1]]),
                min_val = min(density(value)[[1]])) %>% 
      #adjust star position
      mutate(star_pos = ifelse(abs(max_val) >= abs(min_val), 
                               max_val + sign(max_val)*0.5,
                               min_val + sign(min_val)*0.5))
  }
  else{ #if no coefficient was found significant
    signif_df <- plot_df %>% 
      mutate(col = NA) %>% #if the correlation coefficient was found significant, we add a star
      group_by(param, rate, col) %>%
      summarise(max_val = max(density(value)[[1]]),
                min_val = min(density(value)[[1]])) %>% 
      mutate(star_pos = ifelse(abs(max_val) >= abs(min_val), 
                               max_val + sign(max_val)*0.5,
                               min_val + sign(min_val)*0.5))
    
  }
  
  ## Plot ----------------------------------------------------------------------
  MBD_plot <- ggplot(data = plot_df, aes(x = factor(param), y = value)) +
    geom_violin(adjust = .75, draw_quantiles = c(0.025, 0.975), scale = "width", aes(fill = factor(rate))) +
    # geom_text(aes(label = signif), vjust = rep(c(0, 1.5), 7000), size = 10) +
    # stat_summary(fun=mean, geom="point", size=1, color = "black") +
    scale_fill_manual(values = c("#a50f15", "#08519c")) +
    scale_y_continuous(limits = c(min(signif_df$min_val-1), 
                                  max(signif_df$max_val+1))) +
    scale_x_discrete(breaks = seq(from = 0, to = length(cov_idx)-1, by = 1),
                     labels = c(values(cov_idx))) +
    geom_hline(yintercept = 0, linetype = "dashed", colour = "grey60") +
    labs(x = NULL,
         y = "Correlation coefficient",
         fill = NULL) +
    theme(axis.title = element_text(size = 18),
          axis.text = element_text(size = 18),
          legend.text = element_text(size = 12),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    geom_text(data = signif_df,
              aes(label = col,
                  y = star_pos,
                  x = param+0.75,
                  group = col),
              vjust = rep(c(0.7, #extinction star 
                            -0.95), #origination star
                          length(cov_idx)),
              size = 10) +
    coord_flip()
  # set the name of the plot and save
  spl <- strsplit(trt, "/")[[1]]
  nm <- c(spl[1])
  for(el in spl[2:length(spl)]){nm <- paste0(nm, "_", el)}
  ggsave(paste0("./figures/MBD_outputs/", nm, "_MBD_violin.png"),
         plot = MBD_plot,
         height = 200,
         width = 350,
         units = "mm",
         dpi = 300)
  cat("\nDone :)!\n")
}

