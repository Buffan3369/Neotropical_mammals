################################################################################
# Goal: Table recap
# Author: Lucas Buffan
# Contact: Lucas.L.Buffan@gmail.com
################################################################################

library(tidyverse)

tbl <- readRDS("./data_2023/SPECIES_LISTS/6-Fully_cleaned_EOT_SA_Mammals.RDS")
# Non-Na orders
full_odr <- unique(tbl$order)[!is.na(unique(tbl$order))]
# Assess number of occ, singleton and proportion of singleton per order
final_df <- data.frame(order = full_odr,
                       n_occ = sapply(X = full_odr,
                                      FUN = function(x){
                                        tmp <- tbl %>% filter(order == x)
                                        return(nrow(tmp))}),
                       n_gen = sapply(X = full_odr,
                                      FUN = function(x){
                                        tmp <- tbl %>% filter(order == x)
                                        return(length(unique(tmp$genus)))}),
                       n_singl = sapply(X = full_odr,
                                        FUN = function(x){
                                          tmp <- tbl %>% filter(order == x)
                                          gen_count <- tmp %>% count(genus)
                                          S <- which(gen_count$n == 1)
                                          return(length(S))
                                          }))
# Add "total" row
ttl_count <- tbl %>% count(genus)
final_df <- final_df %>% add_row(order = "total", n_occ = nrow(tbl), n_gen = nrow(ttl_count), n_singl = length(which(ttl_count$n == 1)))
# Add "propotion of singleton" column
final_df$prop_singl <- sapply(X = 1:nrow(final_df),
                              FUN = function(x){
                                occ <- final_df$n_gen[x]
                                singl <- final_df$n_singl[x]
                                prop <- (singl / occ)
                                return(round(prop, digits = 2))
                              })
# save
write.csv(final_df, "./data_2023/recap_tbl_EOT.csv", row.names = FALSE)
