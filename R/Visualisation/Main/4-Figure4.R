################################################################################
# Name: 4-Figure4.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Script for figure 4 (MBD results full Eocene post-EOT + Oligocene).
################################################################################

library(hash)

## Source MBD accessory function -----------------------------------------------
source("./R/useful/4b-MBD_accessory.R")

## Define covariable names -----------------------------------------------------
covar_idx <- hash("0" = "Self-diversity",
                "1" = "Plant_diversity",
                "2" = "Andes_elevation",
                "3" = "Temperature",
                "4" = "Atmospheric_carbon",
                "5" = "Organic_carbon",
                "6" = "Sea_level")

# Set strip labels for plots ---------------------------------------------------
rate.labs <- c("Extinction rate", "Origination rate")
names(rate.labs) <- c("Extinction", "Origination")
int.labs <- intervals[1:2]
names(int.labs) <- intervals[1:2]

## BIG ASS LOOP for EOT-panels -------------------------------------------------
dirs <- c("1-Full/", "6-Order_level/")
intervals <- hash("post_EECO/" = "Eocene",
                  "Oligocene_only/" = "Oligocene")

for(salma in c("SALMA_kept/genus_level/", "SALMA_smoothed/genus_level/")){
  for(dir in dirs){
    # full
    if(strsplit(dir, split = "-")[[1]] == "1"){
      # initialise large tables
      PLOT_DF <- data.frame(param = NA, rate = NA, col = NA, signif_col = NA, value = NA, interval = NA, dat = NA)
      SIGNIF_DF <- data.frame(param = NA, rate = NA, col = NA, max_val = NA, min_val = NA, star_pos = NA, interval = NA, dat = NA)
      for(trt in keys(intervals)){
        dir <- paste0("./results_EXTENDED/MBD/", salma, dir, trt)
        plot_df <- out_table_MBD(dir, intervals = values(intervals[trt]))[[1]]
        signif_df <- out_table_MBD(dir, intervals = values(intervals[trt]))[[2]]
        # Extend the big berthas
        PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
        SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
      }
      MBD_viol <- MBD.plot(PLOT_DF = PLOT_DF,
                           SIGNIF_DF = SIGNIF_DF,
                           x_ticks = c(values(covar_idx)),
                           rate.labs = rate.labs,
                           int.labs = int.labs)
    }
    # loop across orders
    if(strsplit(dir, split = "-")[[1]] == "6"){
      for(odr in c("Notoungulata", "Other_SANUs", "Rodentia", "Xenarthra", "Metatheria")){
        for(trt in c("", "post_EECO/", "Oligocene_only/")){
        dir <- paste0("./results_EXTENDED/MBD/", salma, dir, odr, "/", trt)
        plot_df <- violin_MBD(dir)[[1]]
        signif_df <- violin_MBD(dir)[[2]]
        # Extend the big berthas
        PLOT_DF <- rbind.data.frame(PLOT_DF, plot_df)
        SIGNIF_DF <- rbind.data.frame(SIGNIF_DF, signif_df)
        j <- j+1
        }
      }
    }
  }
}

rm(plot_df) # free memory
PLOT_DF <- PLOT_DF[-c(1), ] #remove initialising row
SIGNIF_DF <- SIGNIF_DF[-c(1), ]

## PLOT ------------------------------------------------------------------------
  # Separate datasets for all mammals and for herbivores only
#PLOT_DF_all <- PLOT_DF %>% filter(dat == "1-Full")
# PLOT_DF_herbi <- PLOT_DF %>% filter(dat == "5-Ecomorphotype")
PLOT_DF_all <- PLOT_DF
rm(PLOT_DF)
# SIGNIF_DF_all <- SIGNIF_DF %>% filter(dat == "1-Full")
# SIGNIF_DF_herbi <- SIGNIF_DF %>% filter(dat == "5-Ecomorphotype")
SIGNIF_DF_all <- SIGNIF_DF
rm(SIGNIF_DF)

  #### FIGURE 4a ####
fig4a <-
ggsave("./figures/Figure_4/Notoungulata_MBD.pdf",
       plot = fig4a,
       height = 300,
       width = 400,
       units = "mm")

#### FIGURE 4b ####
fig4b <- ggplot(data = PLOT_DF_herbi, aes(x = factor(param), y = value)) +
  # axes
  scale_y_continuous(limits = c(-10, 5)) +
  scale_x_discrete(breaks = seq(from = 0, to = length(covar_idx_diet)-1, by = 1),
                   labels = c(values(covar_idx_diet))) +
  labs(x = NULL,
       y = "Correlation coefficient",
       fill = NULL) +
  # bands
  annotate(geom = "rect", xmin = -Inf, xmax = 1.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  annotate(geom = "rect", xmin = 2.5, xmax = 3.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  annotate(geom = "rect", xmin = 4.5, xmax = 5.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  annotate(geom = "rect", xmin = 6.5, xmax = 7.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  annotate(geom = "rect", xmin = 8.5, xmax = 9.5, ymin = -Inf, ymax = Inf, fill = "grey95") +
  # violins
  geom_violin(adjust = .75, draw_quantiles = c(0.025, 0.5, 0.975), scale = "width", aes(fill = factor(signif_col))) +
  scale_fill_manual(values = c("#fcbba1", "#a50f15", "#9ecae1", "#08519c")) + # non-significant correlation coefficients are displayed in light grey
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey60") +
  # significance star
  geom_text(data = SIGNIF_DF_herbi,
            aes(label = col,
                y = star_pos,
                x = param + 0.75,
                group = col),
            vjust = rep(c(0.5, #extinction star
                          0.5), #origination star
                        (nrow(SIGNIF_DF_herbi)/2)),
            size = 10) +
  # theme aesthetics
  theme(axis.title = element_text(size = 18),
        axis.text = element_text(size = 18),
        axis.ticks.y = element_blank(),
        legend.position = "none",
        strip.text.x = element_text(size = 18),
        strip.text.y = element_text(size = 18),
        strip.background = element_rect(colour = "black", fill = "bisque2"),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
  coord_flip() +
  facet_grid(interval~rate, labeller = labeller(rate = rate.labs, interval = int.labs))

## SAVE ------------------------------------------------------------------------
ggsave("./figures/Figure_4/Figure4.pdf",
       plot = fig4,
       height = 300,
       width = 400,
       units = "mm")
ggsave("./figures/Figure_4/Figure4.png",
       plot = fig4,
       height = 300,
       width = 400,
       units = "mm",
       dpi = 400)
