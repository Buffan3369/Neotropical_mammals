################################################################################
############################# Treat MBD outputs ################################
################################################################################

library(dplyr)
library(hash)
library(ggplot2)

## Useful param for plotting ---------------------------------------------------
treatment <- "model_scaling"
#treatment <- "hand.scale_only"
kew <- "q_stages"

## Dictionary containing the corresponding index of the covariates -------------
cov_idx <- hash("0" = "Self-diversity",
                "1" = "Plant_diversity",
                "2" = "Andes_elevation",
                "3" = "Temperature",
                "4" = "Atmospheric_carbon",
                "5" = "Organic_carbon",
                "6" = "Sea_level")

## Big loop ----------------------------------------------------------------
for(initial_data in c("singleton", "entire", "spatially_scaled")){
  for(odr in c("Full", "Rodentia", "SANU", "Xenarthra", "Metatheria")){
    message(paste0("Analysing ", odr, " outputs..."))
    recap_tbl <- read.table(paste0("../../MBD/EOCENE_OLIGOCENE/", treatment, "/", odr, "/ESS_summary.txt"), 
                            sep = "\t", header = TRUE)
    if(length(which(recap_tbl$ESS_posterior < 200)) > 0){
      recap_tbl <- recap_tbl[-which(recap_tbl$ESS_posterior < 200), ]
    }
    #add the mean row in last position
    recap_tbl[nrow(recap_tbl)+1, ] <- apply(X = recap_tbl, MARGIN = 2, FUN = mean, na.rm = TRUE)
    #subset mean Shrinkage Weights (SW)
    mean_SW <- recap_tbl %>% select(starts_with("Mean_W"))
    # 1) get column names of the SW > 0.5
    ns_names <- colnames(mean_SW)[which(mean_SW[nrow(mean_SW), ] < 0.5)] #remember that the last one is the total
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
    if(is.null(corr_vbl)){
      message("No significant correlation coefficient found.")
    }
    else{
      recap_tbl_sign <- recap_tbl %>% select(ends_with(corr_vbl))
      # 2) check if zero is in the 94% HPD
      zeros <- c() #will contain the names of the coefficients with 0 in 94% HPD
      for(vbl in corr_vbl){
        tmp <- recap_tbl_sign %>% select(ends_with(vbl))
        if(sign(tmp[nrow(tmp), paste0("min_HPD_", vbl)]) != sign(tmp[nrow(tmp), paste0("min_HPD_", vbl)]) ){
          zeros <- c(zeros, vbl)
        }
      }
      if(length(zeros) > 0){
        corr_vbl <- corr_vbl[-which(corr_vbl %in% zeros)]
        if(length(corr_vbl == 0)){
          message("No significant correlation coefficient found.")
          recap_tbl_sign <- NULL
        }
        else{
          recap_tbl_sign <- recap_tbl_sign %>% select(ends_with(corr_vbl))
        }
      }
    }
    # 3) open the combined mcmc.log file and retain the distributions of the selected G
    mcmcLog <- read.table(paste0("../../MBD/EOCENE_OLIGOCENE/", treatment, "/", odr, "/combined_MBD.log"),
                          header = TRUE, sep = "\t")
    #only retain correlation parameters and subsample to make it lighter
    mcmcLog <- mcmcLog %>% select(starts_with("G"))
    mcmcLog1 <- data.frame(apply(X = mcmcLog, FUN = sample, MARGIN = 2, size = 1000))
    colnames(mcmcLog1) <- colnames(mcmcLog)
    #reformat dataset for plotting
    value <- mcmcLog1[, 1]
    param <- rep(0, 1000)
    col <- rep(colnames(mcmcLog1)[1], 1000)
    if("l" %in% strsplit(colnames(mcmcLog1)[1], "")[[1]]){ #lambda
      rate <- rep("Origination", length(mcmcLog1[, 1]))
    }
    if("m" %in% strsplit(colnames(mcmcLog1)[1], "")[[1]]){ #mu
      rate <- rep("Extinction", length(mcmcLog1[, 1]))
    }
    
    for(i in colnames(mcmcLog1)[-1]){
      col <- c(col, rep(i, 1000))
      value <- c(value, mcmcLog1[, i])
      p <- strsplit(i, split = "_")[[1]][2]
      param <- c(param, rep(as.numeric(p), 1000))
      if("l" %in% strsplit(i, "")[[1]]){ #lambda
        rate <- c(rate, rep("Origination", 1000))
      }
      else if("m" %in% strsplit(i, "")[[1]]){ #mu
        rate <- c(rate, rep("Extinction", 1000))
      }
    }
    plot_df <- data.frame(param = param, rate = rate, col = col, value = value)
    #significance dataframe
    if(length(corr_vbl) > 0){ #if we have significant correlation coefficients
      signif_df <- plot_df %>% 
        mutate(col = ifelse(col %in% corr_vbl, "*", NA)) %>% #if the correlation coefficient was found significant, we add a star
        group_by(param, rate, col) %>%
        summarise(max_val = max(density(value)[[1]]),
                  min_val = min(density(value)[[1]]))
    }
    else{ #if no coefficient was found significant
      signif_df <- plot_df %>% 
        mutate(col = NA) %>% #if the correlation coefficient was found significant, we add a star
        group_by(param, rate, col) %>%
        summarise(max_val = max(density(value)[[1]]),
                  min_val = min(density(value)[[1]]))
      
    }
    #plot
    MBD_plot <- ggplot(data = plot_df, aes(x = factor(param), y = value)) +
      geom_violin(adjust = .75, draw_quantiles = c(0.03, 0.5, 0.97), scale = "width", aes(fill = factor(rate))) +
      # geom_text(aes(label = signif), vjust = rep(c(0, 1.5), 7000), size = 10) +
      # stat_summary(fun=mean, geom="point", size=1, color = "black") +
      scale_color_manual(values = c("#4c4cec", "#e34a33")) +
      scale_y_continuous(limits = c(min(signif_df$min_val-1), 
                                    max(signif_df$max_val+1))) +
      scale_x_discrete(breaks = 0:6,
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
                    y = max_val+0.5,
                    x = param+0.75,
                    group = col),
                vjust = rep(c(0.7, #extinction star 
                              -0.85) #origination star
                            , 7),
                size = 10) +
      coord_flip()
    
    ggsave(paste0("./figures/MBD_outputs/EOCENE_OLIGOCENE/", initial_data,
                  "/", kew, "/", treatment, "/", odr, "_MBD_violin.png"),
           plot = MBD_plot,
           height = 200,
           width = 350,
           units = "mm",
           dpi = 300)
    message("Done :)!")
  }
}

