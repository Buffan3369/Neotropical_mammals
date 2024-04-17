spl <- readRDS("./data_2023/SPECIES_LISTS/8-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS")

spl$family[which(spl$genus %in% c("Clypeotherium", "Glyptatelus"))] <- "Glyptatelidae"
spl$family[which(spl$genus == "Palaeopeltis")] <- "Palaeopeltidae"
spl$family[which(spl$genus == "Hapalops")] <- "Megalonychidae"
spl$order[which(spl$genus %in% c("Octodontotherium", "Similhapalops"))] <- "Pilosa"
spl$order[which(spl$genus == "Carolozittelia")] <- "Pyrotheria"
spl$family[which(spl$genus == "Carolozittelia")] <- "Pyrotheriidae"

spl$family[which(spl$genus %in% c("Caroloameghinia", "Procaroloameghinia", "Canchadelphys"))] <- "Caroloameghiniidae"
spl$order[which(spl$family %in% c("Peradectidae", "Caroloameghiniidae"))] <- "Didelphimorphia"

spl$order[which(spl$family %in% c("Glasbiidae", "Sillustaniidae"))] <- "Polydolopimorphia"
spl$order[which(spl$genus %in% c("Praedens", "Epiklohnia", "Apeirodon",
                                 "Palangania", "Bobbschaefferia", "Chulpasia"))] <- "Polydolopimorphia"
spl$family[which(spl$genus == "Gashternia")] <- "Gashterniidae"
spl$order[which(spl$family == "Gashterniidae")] <- "Polydolopimorphia"
spl$family[which(spl$genus == "Palangania")] <- "Glasbiidae"

spl$order[which(spl$genus == "Groeberia")] <- "Groeberida"
spl$family[which(spl$genus == "Groeberia")] <- "Groeberiidae"

spl$family[which(spl$genus == "Marmosopsis")] <- "Sternbergiidae"
spl$order[which(spl$family %in% c("Jaskhadelphyidae", "Herpetotheriidae", "Derorhynchidae", 
                                  "Protodidelphidae", "Pucadelphyidae", "Sternbergiidae"))] <- "Basal_Marsupialia"
spl$order[which(spl$genus %in% c("Fieratherium", "Wirunodon", "Zeusdelphys", 
                                 "Austropediomys", "Monodelphopsis"))] <- "Basal_Marsupialia"

# Picunia, Eutrochodon, Trilobodon, Florentinoameghinia are basal mammals with uncertain affinity => left as they are!

saveRDS(spl, "./data_2023/SPECIES_LISTS/8-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS")
