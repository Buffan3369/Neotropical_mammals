################################################################################
################ Barplots for occurrence abundance in SALMA ####################
################################################################################

library(readxl)
library(ggplot2)
library(deeptime)
library(dplyr)

source("./R/pipeline_from_scratch/2b-matching_functions.R")

SALMA <- data.frame(read_xlsx("./data_2023/time_bins/SALMA.xlsx"))
SALMA$min_ma <- unlist(lapply(X = SALMA$min_ma, FUN = round))
SALMA$max_ma <- unlist(lapply(X = SALMA$max_ma, FUN = round))

spl <- read_xlsx("../../DATA/order_level/matched_order_level/Full_species_list_former_SALMA.xlsx")

spl$stage <- unlist(lapply(spl$stage, no_blank))

in_SALMA <- function(stage){
  splt <- strsplit(stage, split = "-")[[1]]
  if(length(splt) == 1){
    if(splt %in% SALMA$interval_name){return(TRUE)}
    else{return(FALSE)}
  }
  else{
    if((splt[1] %in% SALMA$interval_name) & (splt[2] %in% SALMA$interval_name)){
      return(TRUE)
    }
    else{return(FALSE)}
  }
}
spl_in_SALMA <- spl[unlist(lapply(X = spl$stage, FUN = in_SALMA)), ]
  #Initialise count dataframe
count_df <- data.frame(cat = NA,
                       count = rep(0, 66),
                       time = seq(from = 1, to = 66, by = 1))

for(t in seq(from = 1, to = 65, by = 1)){
  mid <- (2*t+1)/2
  count_df$cat[t] <- SALMA$interval_name[which((SALMA$min_ma < mid) & (SALMA$max_ma > mid))]
}
count_df$cat[1] <- "PLB"
count_df$cat[16] <- "Friasian"
count_df$cat[66] <- "Tiupampan"


## Barplot functions -----------------------------------------------------------
bplt <- function(count_df, name, ymax){
  p <- ggplot(data = count_df, aes(x = time, y = count)) +
    geom_bar(stat = "identity", width = 1, fill = "black") +
    scale_x_reverse(limits = c(67, -1),
                    breaks = c(66, 56, 34, 23, 5, 3, 0),
                    labels = c(66, 56, 33.9, 23.03, 5.33, 2.58, 0)) +
    scale_y_continuous(limits = c(-50, ymax+100),
                       breaks = seq(from = 0, to = ymax, by = 200)) +
    labs(x = "Time (Ma)",
         y = "Number of occurrences") +
    ggtitle(name) +
    geom_segment(aes(x = 0, xend = 66, y = 0, yend = 0)) + 
    geom_segment(aes(x = 66, xend = 66, y = 0, yend = 1200)) +
    theme(plot.margin = margin(5, 10, 5, 10, "mm"),
          title = element_text(size = 18, hjust = 0.5),
          axis.title.x = element_text(size = 14),
          axis.title.y = element_text(size = 14),
          axis.text = element_text(size = 12),
          panel.background = element_blank()) +
    annotate("rect", xmin = 66, xmax = 65, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (66+65)/2, y = -25, label = "Tu", size = 3)+
    annotate("rect", xmin = 64, xmax = 63, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (64+63)/2, y = -25, label = "Pe", size = 3)+
    annotate("rect", xmin = 59, xmax = 61, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (59+61)/2, y = -25, label = "C.Z.", size = 3)+
    annotate("rect", xmin = 55, xmax = 51, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (55+51)/2, y = -25, label = "It", size = 3)+
    annotate("rect", xmin = 51, xmax = 50, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (50+51)/2, y = -25, label = "Ri", size = 3)+
    annotate("rect", xmin = 48, xmax = 47, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (47+48)/2, y = -25, label = "S.F.", size = 3)+
    annotate("rect", xmin = 45, xmax = 44, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (45+44)/2, y = -25, label = "Va", size = 3)+
    annotate("rect", xmin = 42, xmax = 39, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey") +
    annotate("text", x = (42+39)/2, y = -25, label = "Ba", size = 3)+
    annotate("rect", xmin = 39, xmax = 36, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (39+36)/2, y = -25, label = "Mu", size = 3)+
    annotate("rect", xmin = 34, xmax = 30, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (34+30)/2, y = -25, label = "Tg", size = 3)+
    annotate("rect", xmin = 30, xmax = 23, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (30+23)/2, y = -25, label = "De", size = 3)+
    annotate("rect", xmin = 21, xmax = 20, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (21+20)/2, y = -25, label = "Co", size = 3)+
    annotate("rect", xmin = 18, xmax = 16, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (18+16)/2, y = -25, label = "Sa", size = 3)+
    annotate("rect", xmin = 16, xmax = 15, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (16+15)/2, y = -25, label = "Fr", size = 3)+
    annotate("rect", xmin = 15, xmax = 14, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (14+15)/2, y = -25, label = "Cc", size = 3)+
    annotate("rect", xmin = 14, xmax = 12, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (12+14)/2, y = -25, label = "La", size = 3)+
    annotate("rect", xmin = 12, xmax = 10, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (10+12)/2, y = -25, label = "Ma", size = 3)+
    annotate("rect", xmin = 10, xmax = 9, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (10+9)/2, y = -25, label = "Cs", size = 3)+
    annotate("rect", xmin = 9, xmax = 5, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (9+5)/2, y = -25, label = "Hu", size = 3)+
    annotate("rect", xmin = 5, xmax = 4, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (5+4)/2, y = -25, label = "Mo", size = 3)+
    annotate("rect", xmin = 4, xmax = 3, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (4+3)/2, y = -25, label = "Cp", size = 3)+
    annotate("rect", xmin = 3, xmax = 2, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (3+2)/2, y = -25, label = "Mp", size = 3)+
    annotate("rect", xmin = 2, xmax = 1, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = (2+1)/2, y = -25, label = "En", size = 3)+
    annotate("rect", xmin = 1, xmax = 0, ymin = -50, ymax = 0, alpha = 1, color = "black", fill = "lightgrey")+
    annotate("text", x = 1/2, y = -25, label = "PLB", size = 3) +
    deeptime::coord_geo(pos = "bottom", dat = "stages", size = 4, height = unit(1.5, "line"), skip = c("Gelasian", "Calabrian", "Chibanian", "Upper Pleistocene", "LP", "Greenlandian", "Northgrippian", "Meghalayan"))
  return(p)
}

## All SALMA occurrences -------------------------------------------------------
count_df_all <- count_df
for(stage in spl_in_SALMA$stage){
  hyphen_split <- strsplit(stage, split = "-")[[1]]
  if(hyphen_split[1] %in% c("Platan", "Lujanian", "Bonaerian")){
    count_df_all$count[1] <- count_df_all$count[1] + 1
  }
  else if(length(hyphen_split) == 1){
    count_df_all$count[which(count_df_all$cat == hyphen_split)] <- count_df_all$count[which(count_df_all$cat == hyphen_split)] + 1 
  }
  else{
    count_df_all$count[which(count_df_all$cat == hyphen_split[1])] <- count_df_all$count[which(count_df_all$cat == hyphen_split[1])] + 1
    count_df_all$count[which(count_df_all$cat == hyphen_split[2])] <- count_df_all$count[which(count_df_all$cat == hyphen_split[2])] + 1
  }
}

count_df_all$cat[which(count_df_all$cat %in% c("Barrancan", "Sapoan Fauna", "Carodnia Zone", "Tiupaman", "GAP"))] <- NA
count_df_all$time <- unlist(lapply(X = count_df_all$time, FUN = function(x){x+1/2}))
count_df_all <- count_df_all %>% add_row(cat = "PLB", count = 754, time = .5)

p <- bplt(count_df = count_df_all, name = "All SALMA Occurrences", ymax = 1200)
ggsave("C:/Users/lucas/OneDrive/Bureau/Internship_ISEM/presentations/results_11-05/all_SALMA.png",
       plot = p,
       height = 220,
       width = 400,
       units = "mm",
       dpi = 600)

## SANUs -----------------------------------------------------------------------
count_df_SANU <- count_df
SANUs <- spl_in_SALMA[which(spl_in_SALMA$order %in% c("Notoungulata", "Litopterna", "Astrapotheria", "Xenungulata", "Pyrotheria")), ]
for(stage in SANUs$stage){
  hyphen_split <- strsplit(stage, split = "-")[[1]]
  if(hyphen_split[1] %in% c("Platan", "Lujanian", "Bonaerian")){
    count_df_SANU$count[1] <- count_df_SANU$count[1] + 1
  }
  else if(length(hyphen_split) == 1){
    count_df_SANU$count[which(count_df_SANU$cat == hyphen_split)] <- count_df_SANU$count[which(count_df_SANU$cat == hyphen_split)] + 1 
  }
  else{
    count_df_SANU$count[which(count_df_SANU$cat == hyphen_split[1])] <- count_df_SANU$count[which(count_df_SANU$cat == hyphen_split[1])] + 1
    count_df_SANU$count[which(count_df_SANU$cat == hyphen_split[2])] <- count_df_SANU$count[which(count_df_SANU$cat == hyphen_split[2])] + 1
  }
}

count_df_SANU$cat[which(count_df_SANU$cat %in% c("Barrancan", "Sapoan Fauna", "Carodnia Zone", "Tiupaman", "GAP"))] <- NA
count_df_SANU$time <- unlist(lapply(X = count_df_SANU$time, FUN = function(x){x+1/2}))
count_df_SANU <- count_df_SANU %>% add_row(cat = "PLB", count = 754, time = .5)

n_occ_SANUs <- length(which(spl$order %in% c("Notoungulata", "Litopterna", "Astrapotheria", "Xenungulata", "Pyrotheria")))

p <- bplt(count_df = count_df_SANU, name = paste0("SANUs (", round((nrow(SANUs)/n_occ_SANUs)*100, digits = 3), "%)"), ymax = 800)
ggsave("C:/Users/lucas/OneDrive/Bureau/Internship_ISEM/presentations/results_11-05/SANUs.png",
       plot = p,
       height = 220,
       width = 400,
       units = "mm",
       dpi = 600)


## NOTO
count_df_noto <- count_df
noto <- spl_in_SALMA[which(spl_in_SALMA$order %in% c("Notoungulata")), ]
for(stage in noto$stage){
  hyphen_split <- strsplit(stage, split = "-")[[1]]
  if(hyphen_split[1] %in% c("Platan", "Lujanian", "Bonaerian")){
    count_df_noto$count[1] <- count_df_noto$count[1] + 1
  }
  else if(length(hyphen_split) == 1){
    count_df_noto$count[which(count_df_noto$cat == hyphen_split)] <- count_df_noto$count[which(count_df_noto$cat == hyphen_split)] + 1 
  }
  else{
    count_df_noto$count[which(count_df_noto$cat == hyphen_split[1])] <- count_df_noto$count[which(count_df_noto$cat == hyphen_split[1])] + 1
    count_df_noto$count[which(count_df_noto$cat == hyphen_split[2])] <- count_df_noto$count[which(count_df_noto$cat == hyphen_split[2])] + 1
  }
}

count_df_noto$cat[which(count_df_noto$cat %in% c("Barrancan", "Sapoan Fauna", "Carodnia Zone", "Tiupaman", "GAP"))] <- NA
count_df_noto$time <- unlist(lapply(X = count_df_noto$time, FUN = function(x){x+1/2}))
count_df_noto <- count_df_noto %>% add_row(cat = "PLB", count = 754, time = .5)

n_occ_notos <- length(which(spl$order %in% c("Notoungulata")))

p <- bplt(count_df = count_df_noto, name = paste0("Notoungulata (", round((nrow(noto)/n_occ_notos)*100, digits = 3), "%)"), ymax = 800)
ggsave("C:/Users/lucas/OneDrive/Bureau/Internship_ISEM/presentations/results_11-05/Notoungulata.png",
       plot = p,
       height = 220,
       width = 400,
       units = "mm",
       dpi = 600)

