################################################################################
# Name: 6-Get_TsTe_order.R
# Author: Lucas Buffan
# Contact: lucas.l.buffan@gmail.com
# Aim: Extract Ts/Te corresponding to each order in the overall TsTe tables.
################################################################################

library(tidyverse)
source("./R/useful/helper_functions.R") # contains tax_dict and sp_to_udsc

# Reference database containing orders for each species/genus
occdf <- readRDS("./data_2023/SPECIES_LISTS/4-Fully_cleaned_Cnz_SA_mammals_SALMA_kept_Tropics_Diet.RDS")
occdf$accepted_name <- sapply(X = occdf$accepted_name, FUN = spc_to_udsc) #convert spaces to hyphens
occdf$genus <- sapply(X = occdf$genus, FUN = spc_to_udsc)

# Taxon lists in species and genus-level analyses
sp_ref <- read.table("./data_2023/PyRate/EXTENDED/SALMA_kept/species_level/1-Full/Full_EOT_sp_occ_SALMA_kept_TaxonList.txt", header = TRUE)
sp_ref$order <- sapply(X = sp_ref$Species, FUN = function(x){unique(occdf$order[which(occdf$accepted_name == x)])})
gen_ref <- read.table("./data_2023/PyRate/EXTENDED/SALMA_kept/genus_level/1-Full/Full_EOT_gen_occ_SALMA_kept_TaxonList.txt", header = TRUE)
gen_ref$order <- sapply(X = gen_ref$Species, FUN = function(x){unique(occdf$order[which(occdf$genus == x)])})

# Loop across the four outputs
for(salma in c("SALMA_kept", "SALMA_smoothed")){
  for(lvl in c("species_level", "genus_level")){
    if(lvl == "species_level" & salma == "SALMA_smoothed"){
      next
    }
    # choose reference
    if(lvl == "species_level"){
      ref <- sp_ref
    }
    else{
      ref <- gen_ref
    }
    # open corresponding TsTe file
    tste_dir <- paste0("./results_EXTENDED/", salma, "/", lvl, "/1-Full/MH_sampler/LTT/")
    tste <- list.files(path = tste_dir, pattern = "_se_est.txt")[1]
    tste_ttl <- read.table(paste(tste_dir, tste, sep = "/"),
                           header = TRUE)
    tste_ttl <- tste_ttl %>% add_column(tax = ref$order)
    for(odr in keys(tax_dict)){
      tmp_tste_odr <- tste_ttl %>%
        filter(tax %in% values(tax_dict[odr])) %>% 
        select(!c("tax"))
      write.table.lucas(file = paste0("./results_EXTENDED/", salma, "/", lvl, "/6-Order_level/", odr, "/BDCS/TsTe_", odr, "_", salma, "_", lvl, ".txt"),
                        x = tmp_tste_odr)
      write.table.lucas(file = paste0("./results_EXTENDED/", salma, "/", lvl, "/6-Order_level/", odr, "/BDCS_5M/TsTe_", odr, "_", salma, "_", lvl, ".txt"),
                        x = tmp_tste_odr)
    }
  }
}
