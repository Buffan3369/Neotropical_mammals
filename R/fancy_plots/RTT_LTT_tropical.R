################################################################################
######################< Plotting tropical RTT and LTT ##########################
################################################################################

library(ggplot2)
library(deeptime)
library(rphylopic)
library(dplyr)

#RTT ---------------------------------------------------------------------------
for(order in c("Tropical_20M", "Tropical_50M", "Extra-tropical_20M", "Extra-tropical_50M")){}

## LTT -------------------------------------------------------------------------
for(order in c("Tropical_20M", "Tropical_50M", "Extra-tropical_20M", "Extra-tropical_50M")){
  dir <- paste0("../../PyRate_outputs/Tropical_analysis/LTT/", order, "/")
  files <- Sys.glob(paste0(dir, "*_ltt.txt"))
  ltt <- read.table(files[1], header = TRUE)
  ltt$time <- unlist(lapply(X = ltt$time, FUN = round, digits = 1))
  if(length(which(ltt$time > 66)) > 0){
    ltt <- ltt[-which(ltt$time > 66.0), ]
  }
  ltt <- ltt %>% rename(diversity_1 = "diversity")
  ltt <- ltt[, 1:2]
  
  i = 2
  for(file in files[2:length(files)]){
    f <- read.table(file, header = TRUE)
    if(length(which(f$time > 66.0)) > 0){
      f <- f[-which(f$time > 66.0), c("time", "diversity")]
    }
    else{
      f <- f[, c("time", "diversity")]
    }
    f$time <- unlist(lapply(X = f$time, FUN = round, digits = 1))
    colnames(f) <- c("time", paste0("diversity_", i))
    ltt <- merge(ltt, f, by = "time", all = T)
    i <- i+1
  }
  
  LTT <- data.frame(Age = ltt$time,
                    Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                      MARGIN = 1,
                                      FUN = mean,
                                      na.rm = TRUE),
                    min_Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                          MARGIN = 1,
                                          FUN = min,
                                          na.rm = TRUE),
                    max_Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                          MARGIN = 1,
                                          FUN = max,
                                          na.rm = TRUE))
  
  ltt_plot <- ggplot(data = LTT, aes(x = Age, y = Diversity)) +
    scale_x_reverse(breaks = c(2.58, 5.33, 11.63, 15.97, 23.03, 27.82, 33.9, 56, 66)) +
    # scale_y_continuous(breaks = seq(0,250,50),
    #                    limits = c(0,250)) +
    annotate("rect", xmin = 56, xmax = 65.43265, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
    annotate("rect", xmin = 23.03, xmax = 33.9, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
    annotate("rect", xmin = 2.58, xmax = 5.33, ymin = -Inf, ymax = Inf, alpha = 0.2, fill = "grey40") +
    geom_ribbon(aes(x = Age, ymin = min_Diversity, ymax = max_Diversity), 
                fill = "#a1d99b",
                alpha = 0.8) +
    geom_line(linewidth = 1, colour = "#329507") +
    ggtitle(order) +
    xlab("Time (Ma)") +
    ylab("Diversity (nb. lineages)") +
    theme(axis.title.x = element_text(size = 22),
          axis.title.y = element_text(size = 22),
          axis.text = element_text(size = 18),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
          plot.title = element_text(size = 25, hjust = 0.5)) +
    coord_geo(dat = cnz_epochs, abbrv = TRUE, size = 5)
  ggsave(paste0("./figures/LTT_Tropical/", order, "_LTT.png"),
         plot = ltt_plot,
         height = 200,
         width = 320,
         units = "mm",
         dpi = 600)
}

