################################################################################
# Name: 6-Figure4.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 4 (MBD results full Eocene post-EOT + Oligocene, 
#      and probaly herbivores).
################################################################################

library(tidyverse)
library(hash)
library(ggplot2)
library(stringr)

cov_idx <- hash("0" = "Self-diversity",
                "1" = "Plant_diversity",
                "2" = "Andes_elevation",
                "3" = "Temperature",
                "4" = "Atmospheric_carbon",
                "5" = "Organic_carbon",
                "6" = "Sea_level")

dirs <- c("1-Full/post_EECO", "1-Full/Oligocene_only")
intervals <- c("Eocene", "Oligocene")

#initialise big tables
PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA)
SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA)
j <- 1
for(dir in dirs){
  # MCMC recap table
  recap_tbl <- read.table(paste0("./results/MBD/", dir, "/ESS_summary.txt"), 
                          sep = "\t", header = TRUE)
  #remove runs that did not converge fomr recap_tbl
  if(length(which(recap_tbl$ESS_posterior < 200)) > 0){
    recap_tbl <- recap_tbl[-which(recap_tbl$ESS_posterior < 200), ]
  }
  n_conv <- nrow(recap_tbl) #number of runs that converged, useful as in the name of the combined mcmc log file
  #add the mean row in last position
  recap_tbl[nrow(recap_tbl)+1, ] <- apply(X = recap_tbl, MARGIN = 2, FUN = mean, na.rm = TRUE)
  #subset mean Shrinkage Weights (SW)
  mean_SW <- recap_tbl %>% select(starts_with("Mean_W"))
  
  #Open combined mcmc.log file and retain the distributions of the selected G
  mcmcLog <- read.table(paste0("./results/MBD/", dir, "/combined_", n_conv, "_KEEP.log"),
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
  if(length(corr_vbl) > 0){
    mcmcLog_sign <- mcmcLog %>% select(all_of(corr_vbl))
    # 3) check if zero is in the 95% HPD
    zeros <- c()
    for(G in colnames(mcmcLog_sign)){
      #5 and 95% quantiles of the distribution
      Q <- as.numeric(quantile(mcmcLog_sign[, G], probs = c(0.025, 0.975)))
      if(length(unique(sign(Q))) > 1){ #if these boundaries have different signs, i.e. 0 is in 95% HPD
        small_abs <- min(abs(Q))
        #in case the distribution is skewed and only a TINY part of the 95% HPD includes 0
        if(small_abs >= 0.01){ #we consider small_abs small enough if smaller than 1e-2
          zeros <- c(zeros, G)
        }
      }
    }
    #remove variables including zero in their 95% HPD from the list of the significant variables
    if(length(zeros) > 0){
      zeros <- str_replace(zeros, "Mean_W", "G") #otherwise names don't match
      corr_vbl <- corr_vbl[-which(corr_vbl %in% zeros)]
      if(length(corr_vbl) == 0){
        message("\nNo significant correlation coefficient found.\n")
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
  if(length(corr_vbl) == 0){ #if no coefficient was found significant
    signif_df <- plot_df %>% 
      mutate(col = NA) %>% #if the correlation coefficient was found significant, we add a star
      group_by(param, rate, col) %>%
      summarise(max_val = max(density(value)[[1]]),
                min_val = min(density(value)[[1]])) %>% 
      mutate(star_pos = ifelse(abs(max_val) >= abs(min_val), 
                               max_val + sign(max_val)*0.5,
                               min_val + sign(min_val)*0.5))
    
  }
  signif_df <- signif_df %>% add_column(interval = rep(intervals[j], nrow(signif_df)))
  # Create a column indicating (or not) significance of each coefficient (for colour attribution)
  attrib_sign <- function(idx){
    corr_idx <- which(signif_df$rate == plot_df$rate[idx] &
                        signif_df$param == plot_df$param[idx])
    type <- signif_df$rate[corr_idx] # Extinction or Origination
    signif <- signif_df$col[corr_idx] # "*" or NA
    if(is.na(signif)){
      return("ns")
    }
    else if(type == "Extinction" & signif == "*"){
      return("Ext_signif")
    }
    else if(type == "Origination" & signif == "*"){
      return("Ori_signif")
    }
  }
  
  sign_col <- sapply(X = 1:nrow(plot_df), FUN = attrib_sign)
  plot_df <- plot_df %>% add_column(signif_col = sign_col, 
                                    interval = rep(intervals[j], nrow(plot_df)),
                                    .after = "col")
  # Extend the big berthas
  PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
  SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
  j <- j+1
}
rm(plot_df)
PLOT_DF <- PLOT_DF[-c(1), ]
SIGNIF_DF <- SIGNIF_DF[-c(1), ]
## PLOT ------------------------------------------------------------------------
  # Set strip labels
rate.labs <- c("Extinction rate", "Origination rate")
names(rate.labs) <- c("Extinction", "Origination")
int.labs <- intervals
names(int.labs) <- intervals

fig4 <- ggplot(data = PLOT_DF, aes(x = factor(param), y = value)) +
  # Axes
  scale_y_continuous(limits = c(min(signif_df$min_val-1), 
                                max(signif_df$max_val+1))) +
  scale_x_discrete(breaks = seq(from = 0, to = length(cov_idx)-1, by = 1),
                   labels = c(values(cov_idx))) +
  labs(x = NULL,
       y = "Correlation coefficient",
       fill = NULL) +
  # bands
  # annotate(geom = "rect", xmin = -Inf, xmax = 1.5, ymin = -Inf, ymax = Inf, fill = "grey") +
  # annotate(geom = "rect", xmin = 2.5, xmax = 3.5, ymin = -Inf, ymax = Inf, fill = "grey") +
  # annotate(geom = "rect", xmin = 4.5, xmax = 5.5, ymin = -Inf, ymax = Inf, fill = "grey") +
  # annotate(geom = "rect", xmin = 6.5, xmax = Inf, ymin = -Inf, ymax = Inf, fill = "grey") +
  # violins
  geom_violin(adjust = .75, draw_quantiles = c(0.025, 0.5, 0.975), scale = "width", aes(fill = factor(signif_col))) +
  scale_fill_manual(values = c("#a50f15", "grey90", "#08519c")) + # non-significant correlation coefficients are displayed in light grey
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey60") +

  geom_text(data = SIGNIF_DF,
            aes(label = col,
                y = star_pos,
                x = param+0.75,
                group = col),
            vjust = rep(c(0.1, #extinction star
                          0.08), #origination star
                       nrow(signif_df)),
            size = 10) +
  theme(axis.title = element_text(size = 18),
        axis.text = element_text(size = 18),
        legend.position = "none",
        strip.text.x = element_text(size = 18),
        strip.text.y = element_text(size = 18),
        strip.background = element_rect(colour = "black", fill = "bisque2"),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_flip() +
  facet_grid(interval~rate, labeller = labeller(rate = rate.labs, interval = int.labs))

## SAVE ------------------------------------------------------------------------
ggsave("./figures/Figure_4/Figure4_noband.pdf",
       plot = fig4,
       height = 300,
       width = 400,
       units = "mm")
ggsave("./figures/Figure_4/Figure4_noband.png",
       plot = fig4,
       height = 300,
       width = 400,
       units = "mm",
       dpi = 400)
