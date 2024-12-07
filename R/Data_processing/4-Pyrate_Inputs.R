################################################################################
# Name: 4-PyRate_Inputs.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: Generate PyRate inputs for EOT data.
# Note: Ages extracted for both the RESTRICTED (=Eocene-Oligocene only) and 
#       EXTENDED (including a bit of Miocene and palaeocene) datasets.
################################################################################

library(dplyr)

## Accessory functions ---------------------------------------------------------
source("~/PyRate/pyrate_utilities.r")
source("./R/useful/helper_functions.R")

## -----------------------------------------------------------------------------
## RESTRICTED (i.e. Eocene-Oligocene only) -------------------------------------
## -----------------------------------------------------------------------------
i <- 4
for(salma in c("SALMA_kept", "SALMA_smoothed")){
  i <- i+1
  occdf <- readRDS(paste0("./data_2023/SPECIES_LISTS/", i, "-Fully_cleaned_EOT_SA_Mammals_", salma, "_Tropics_Diet.RDS"))
## Genus-level -----------------------------------------------------------------
  ### Full & Singleton ###
  #prepare data
  gen_lvl <- occdf %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
  #save
  write.table.lucas(x = gen_lvl,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/1-Full/Full_EOT_gen_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/1-Full/Full_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  ### Spatially scaled
  #subset unique genera at a given age and place (characterised by p_lng, p_lat (nb. could have been present-day lon/lat))
  gen_lvl_scaled <- occdf %>%
    group_by(genus, gen_lvl_status, min_ma, max_ma, p_lng, p_lat, age) %>%
    distinct(genus) %>%
    ungroup() %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
  #save
  write.table.lucas(x = gen_lvl_scaled,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/2-Spatially_scaled/spatially_scaled_EOT_gen_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/2-Spatially_scaled/spatially_scaled_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  ### Tropical/Extra-tropical ###
  #subset tropical/extra-tropical taxa
  trop <- occdf %>%
    filter(loc == "T") %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
  Etrop <- occdf %>%
    filter(loc == "E") %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
  #save
  write.table.lucas(x = trop,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/3-Tropical_Extratropical/Tropical_EOT_gen_occ_", salma, ".txt"))
  write.table.lucas(x = Etrop,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/3-Tropical_Extratropical/Extratropical_EOT_gen_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/3-Tropical_Extratropical/Tropical_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/3-Tropical_Extratropical/Extratropical_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  ### Diet types (10 replicates) ###
  for(dt in c("carnivore", "herbivore", "omnivore", "insectivore")){ #frugivore omitted, not enough data
    tmp <- occdf %>%
      filter(diet == dt) %>%
      select(genus, gen_lvl_status, min_ma, max_ma) %>%
      rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
    write.table.lucas(x = tmp,
                      file = paste0(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/4-Ecomorphotype/", dt, "_EOT_gen_occ_", salma, ".txt")))
    extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/4-Ecomorphotype/", dt, "_EOT_gen_occ_", salma, ".txt"),
                 replicates = 10)
  }
  ### Order (10 replicates) ###
  for(odr in keys(tax_dict)){
    # Get the occ of the corresponding "order"
    tmp_odr <- occdf %>% 
      filter(order %in% values(tax_dict[odr])) %>% 
      select(genus, gen_lvl_status, min_ma, max_ma) %>% 
      rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma")
    # Save
    write.table.lucas(x = tmp_odr,
                      file = paste0(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/5-Order_level/", odr, "_EOT_gen_occ_", salma, ".txt")))
    # Extract ages
    extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/genus_level/5-Order_level/", odr, "_EOT_gen_occ_", salma, ".txt"),
                 replicates = 10)
  }
  
## Species-level ---------------------------------------------------------------
  ### Full & Singleton ###
  #prepare data
  sp_lvl <- occdf %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma")
  #save
  write.table.lucas(x = sp_lvl,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/1-Full/Full_EOT_sp_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/1-Full/Full_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  ### Spatially scaled ###
  #subset unique genera at a given age and place (characterised by p_lng, p_lat (nb. could have been present-day lon/lat))
  sp_lvl_scaled <- occdf %>%
    group_by(accepted_name, status, min_ma, max_ma, p_lng, p_lat, age) %>%
    distinct(accepted_name) %>%
    ungroup() %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma")
  #save
  write.table.lucas(x = sp_lvl_scaled,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/2-Spatially_scaled/spatially_scaled_EOT_sp_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/2-Spatially_scaled/spatially_scaled_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  ### Tropical/Extra-tropical ###
  #subset tropical/extra-tropical taxa
  sp_trop <- occdf %>%
    filter(loc == "T") %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma")
  sp_Etrop <- occdf %>%
    filter(loc == "E") %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma")
  #save
  write.table.lucas(x = sp_trop,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/3-Tropical_Extratropical/Tropical_EOT_sp_occ_", salma, ".txt"))
  write.table.lucas(x = sp_Etrop,
                    file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/3-Tropical_Extratropical/Extratropical_EOT_sp_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/3-Tropical_Extratropical/Tropical_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/3-Tropical_Extratropical/Extratropical_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  ### Diet types (10 replicates) ###
  for(dt in c("carnivore", "herbivore", "omnivore", "insectivore")){ #frugivore omitted, not enough data
    tmp <- occdf %>%
      filter(diet == dt) %>%
      select(accepted_name, status, min_ma, max_ma) %>%
      rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma")
    write.table.lucas(x = tmp,
                      file = paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/4-Ecomorphotype/", dt, "_EOT_sp_occ_", salma, ".txt"))
    extract.ages(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/4-Ecomorphotype/", dt, "_EOT_sp_occ_", salma, ".txt"),
                 replicates = 10)
  }
  ### Order (10 replicates) ###
  for(odr in keys(tax_dict)){
    # Get the occ of the corresponding "order"
    tmp_odr <- occdf %>% 
      filter(order %in% values(tax_dict[odr])) %>% 
      select(accepted_name, status, min_ma, max_ma) %>% 
      rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma")
    # Save
    write.table.lucas(x = tmp_odr,
                      file = paste0(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/5-Order_level/", odr, "_EOT_sp_occ_", salma, ".txt")))
    # Extract ages
    extract.ages(paste0(paste0("./data_2023/PyRate/RESTRICTED/", salma, "/species_level/5-Order_level/", odr, "_EOT_sp_occ_", salma, ".txt")),
                 replicates = 10)
  }
}

## -----------------------------------------------------------------------------
## EXTENDED (i.e. Late Palaeocene + Eocene-Oligocene + Early Miocene) ----------
## -----------------------------------------------------------------------------
i <- 6
for(salma in c("SALMA_kept", "SALMA_smoothed")){
  i <- i+1
  occdf <- readRDS(paste0("./data_2023/SPECIES_LISTS/", i, "-Fully_cleaned_EOT_extended_SA_Mammals_", salma, "_Tropics_Diet.RDS"))
  ## Genus-level -----------------------------------------------------------------
  ### Full & Singleton ###
  #prepare data
  gen_lvl <- occdf %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  #save
  write.table.lucas(x = gen_lvl,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/1-Full/Full_EOT_gen_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/1-Full/Full_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  ### Spatially scaled
  #subset unique genera at a given age and place (characterised by p_lng, p_lat (nb. could have been present-day lon/lat))
  gen_lvl_scaled <- occdf %>%
    group_by(genus, gen_lvl_status, min_ma, max_ma, p_lng, p_lat, age) %>%
    distinct(genus) %>%
    ungroup() %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  #save
  write.table.lucas(x = gen_lvl_scaled,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/2-Spatially_scaled/spatially_scaled_EOT_gen_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/2-Spatially_scaled/spatially_scaled_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  ### Tropical/Extra-tropical ###
  #subset tropical/extra-tropical taxa
  trop <- occdf %>%
    filter(loc == "T") %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  Etrop <- occdf %>%
    filter(loc == "E") %>%
    select(genus, gen_lvl_status, min_ma, max_ma) %>%
    rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  #save
  write.table.lucas(x = trop,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/3-Tropical_Extratropical/Tropical_EOT_gen_occ_", salma, ".txt"))
  write.table.lucas(x = Etrop,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/3-Tropical_Extratropical/Extratropical_EOT_gen_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/3-Tropical_Extratropical/Tropical_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/3-Tropical_Extratropical/Extratropical_EOT_gen_occ_", salma, ".txt"),
               replicates = 20)
  ### Diet types (10 replicates) ###
  for(dt in c("carnivore", "herbivore", "omnivore", "insectivore")){ #frugivore omitted, not enough data
    tmp <- occdf %>%
      filter(diet == dt) %>%
      select(genus, gen_lvl_status, min_ma, max_ma) %>%
      rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma") %>%
      mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
      filter(!(is.na(min_age) | is.na(max_age)))
    
    write.table.lucas(x = tmp,
                      file = paste0(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/4-Ecomorphotype/", dt, "_EOT_gen_occ_", salma, ".txt")))
    extract.ages(paste0(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/4-Ecomorphotype/", dt, "_EOT_gen_occ_", salma, ".txt")),
                 replicates = 10)
  }
  ### Order (10 replicates) ###
  for(odr in keys(tax_dict)){
    # Get the occ of the corresponding "order"
    tmp_odr <- occdf %>% 
      filter(order %in% values(tax_dict[odr])) %>% 
      select(genus, gen_lvl_status, min_ma, max_ma) %>% 
      rename(Species = "genus", Status = "gen_lvl_status", min_age = "min_ma", max_age = "max_ma") %>%
      mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
      filter(!(is.na(min_age) | is.na(max_age)))
    # Save
    write.table.lucas(x = tmp_odr,
                      file = paste0(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/5-Order_level/", odr, "_EOT_gen_occ_", salma, ".txt")))
    # Extract ages
    extract.ages(paste0(paste0("./data_2023/PyRate/EXTENDED/", salma, "/genus_level/5-Order_level/", odr, "_EOT_gen_occ_", salma, ".txt")),
                 replicates = 10)
  }
  
  ## Species-level ---------------------------------------------------------------
  ### Full & Singleton ###
  #prepare data
  sp_lvl <- occdf %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  #save
  write.table.lucas(x = sp_lvl,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/1-Full/Full_EOT_sp_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/1-Full/Full_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  ### Spatially scaled ###
  #subset unique genera at a given age and place (characterised by p_lng, p_lat (nb. could have been present-day lon/lat))
  sp_lvl_scaled <- occdf %>%
    group_by(accepted_name, status, min_ma, max_ma, p_lng, p_lat, age) %>%
    distinct(accepted_name) %>%
    ungroup() %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  #save
  write.table.lucas(x = sp_lvl_scaled,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/2-Spatially_scaled/spatially_scaled_EOT_sp_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/2-Spatially_scaled/spatially_scaled_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  ### Tropical/Extra-tropical ###
  #subset tropical/extra-tropical taxa
  sp_trop <- occdf %>%
    filter(loc == "T") %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  sp_Etrop <- occdf %>%
    filter(loc == "E") %>%
    select(accepted_name, status, min_ma, max_ma) %>%
    rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma") %>%
    mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
    filter(!(is.na(min_age) | is.na(max_age)))
  #save
  write.table.lucas(x = sp_trop,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/3-Tropical_Extratropical/Tropical_EOT_sp_occ_", salma, ".txt"))
  write.table.lucas(x = sp_Etrop,
                    file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/3-Tropical_Extratropical/Extratropical_EOT_sp_occ_", salma, ".txt"))
  #extract ages
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/3-Tropical_Extratropical/Tropical_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/3-Tropical_Extratropical/Extratropical_EOT_sp_occ_", salma, ".txt"),
               replicates = 20)
  ### Diet types (10 replicates) ###
  for(dt in c("carnivore", "herbivore", "omnivore", "insectivore")){ #frugivore omitted, not enough data
    tmp <- occdf %>%
      filter(diet == dt) %>%
      select(accepted_name, status, min_ma, max_ma) %>%
      rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma") %>%
      mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
      filter(!(is.na(min_age) | is.na(max_age)))
    
    write.table.lucas(x = tmp,
                      file = paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/4-Ecomorphotype/", dt, "_EOT_sp_occ_", salma, ".txt"))
    extract.ages(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/4-Ecomorphotype/", dt, "_EOT_sp_occ_", salma, ".txt"),
                 replicates = 10)
  }
  ### Order (10 replicates) ###
  for(odr in keys(tax_dict)){
    # Get the occ of the corresponding "order"
    tmp_odr <- occdf %>% 
      filter(order %in% values(tax_dict[odr])) %>% 
      select(accepted_name, status, min_ma, max_ma) %>% 
      rename(Species = "accepted_name", Status = "status", min_age = "min_ma", max_age = "max_ma") %>%
      mutate(min_age = as.numeric(min_age), max_age = as.numeric(max_age)) %>% 
      filter(!(is.na(min_age) | is.na(max_age)))
    
    # Save
    write.table.lucas(x = tmp_odr,
                      file = paste0(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/5-Order_level/", odr, "_EOT_sp_occ_", salma, ".txt")))
    # Extract ages
    extract.ages(paste0(paste0("./data_2023/PyRate/EXTENDED/", salma, "/species_level/5-Order_level/", odr, "_EOT_sp_occ_", salma, ".txt")),
                 replicates = 10)
  }
}
