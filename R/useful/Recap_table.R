################################################################################
# Goal: Table recap of the nb of occ, genera, species, singletons per order
# Author: Lucas Buffan
# Contact: Lucas.L.Buffan@gmail.com
################################################################################

library(tidyverse)

#tbl <- readRDS("./data_2023/SPECIES_LISTS/5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
tbl <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
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
                       n_singl_gen = sapply(X = full_odr,
                                        FUN = function(x){
                                          tmp <- tbl %>% filter(order == x)
                                          gen_count <- tmp %>% count(genus)
                                          S <- which(gen_count$n == 1)
                                          return(length(S))
                                        }),
                       n_sp = sapply(X = full_odr,
                                      FUN = function(x){
                                        tmp <- tbl %>% filter(order == x)
                                        return(length(unique(tmp$accepted_name)))}),
                       n_singl_sp = sapply(X = full_odr,
                                            FUN = function(x){
                                              tmp <- tbl %>% filter(order == x)
                                              sp_count <- tmp %>% count(accepted_name)
                                              S <- which(sp_count$n == 1)
                                              return(length(S))
                                            }))
# Add "total" row
ttl_count_gen <- tbl %>% count(genus)
ttl_count_sp <- tbl %>% count(accepted_name)
final_df <- final_df %>% add_row(order = "Total", n_occ = nrow(tbl), 
                                 n_gen = nrow(ttl_count_gen), n_singl_gen = length(which(ttl_count_gen$n == 1)), 
                                 n_sp = nrow(ttl_count_sp), n_singl_sp = length(which(ttl_count_sp$n == 1)))
# Add "propotion of singleton" column
prop_singl_gen <- sapply(X = 1:nrow(final_df),
                         FUN = function(x){
                           occ <- final_df$n_gen[x]
                           singl <- final_df$n_singl_gen[x]
                           prop <- (singl / occ)
                           return(round(prop, digits = 2))
                           })
prop_singl_sp <- sapply(X = 1:nrow(final_df),
                        FUN = function(x){
                          occ <- final_df$n_sp[x]
                          singl <- final_df$n_singl_sp[x]
                          prop <- (singl / occ)
                          return(round(prop, digits = 2))
                         })
final_df <- final_df %>% 
  add_column(prop_singl_gen = prop_singl_gen, .after = "n_singl_gen") %>%
  add_column(prop_singl_sp = prop_singl_sp, .after = "n_singl_sp")

# save
write.csv(final_df, "./manuscript/Supp_Mat/supp_tbl/recap_tbl_EOT_extended.csv", row.names = FALSE)
