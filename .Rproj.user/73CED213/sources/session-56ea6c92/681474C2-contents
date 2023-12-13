################################################################################
############### Prepare and save 3-Fully_cleaned_SALMA_kept.csv ################
################################################################################

library(readxl)
library(dplyr)

all_cleaned <- read_xlsx("../../DATA/order_level/matched_order_level/Full_species_list.xlsx")
all_cleaned <- all_cleaned %>% filter(!((order %in% c("Cetacea", "Sirenia")) | 
                                          (family %in% c("Phocidae", "Otariidae"))))

all_cleaned$stage[which(all_cleaned$stage == "Ypresian (Sapoan-Riochican-Itaboraian)")] <- "Itaboraian-Sapoan"
all_cleaned$stage[which(all_cleaned$stage == "Early Oligocene (Tinguirirican)")] <- "Tinguirirican"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene (Lujanian)")] <- "Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Upper Miocene - Chasicoan" )] <- "Chasicoan"
all_cleaned$stage[which(all_cleaned$stage == "Tinguirirican o Deseadan" )] <- "Tinguirirican-Deseadan"
#PINTURAN TO CHECK
all_cleaned$stage[which(all_cleaned$stage == "Langhian-Serravallian (Laventan-Colloncuran)" )] <- "Laventan-Colloncuran"
all_cleaned$stage[which(all_cleaned$stage == "Pinturense (early Miocene)")] <- "Pinturan"
all_cleaned$stage[which(all_cleaned$stage == "Burdigalian (Colhuehuapian)")] <- "Colhuehuapian"
all_cleaned$stage[which(all_cleaned$stage == "Burdigalian-Langhian (Friasian)")] <- "Friasian"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene-Late Holocene (Lujanian-Platan)")] <- "Lujanian-Platan"
all_cleaned$stage[which(all_cleaned$stage == "Middle Pleistocene (Bonaerian)")] <- "Bonaerian"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene-Late Holocene  (Lujanian-Platan)")] <- "Lujanian-Platan"
all_cleaned$stage[which(all_cleaned$stage == "Tortonian (Huayquerian)")] <- "Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Late Miocene (Huayquerian)")] <- "Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Deseadan-Tinguirirican?")] <- "Deseadan-Tinguirirican"
all_cleaned$stage[which(all_cleaned$stage == "Priabonian (~Tinguirirican)")] <- "Tinguirirican"
all_cleaned$stage[which(all_cleaned$stage == "Ypresian (Late Early Eocene)")] <- "Ypresian"
all_cleaned$stage[which(all_cleaned$stage == "Early Chapadmalan")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Zanclean (~Montehermosan)")] <- "Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene (Lujanian?)")] <- "Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Holocene-Lujanian?")] <- "Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Piacenzian (~Chapadmalan)")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Casamayoran (Vacan)")] <- "Vacan"
all_cleaned$stage[which(all_cleaned$stage == "Bartonian (~Mustersan)")] <- "Mustersan"
all_cleaned$stage[which(all_cleaned$stage == "Pliocene (?)")] <- "Pliocene"
all_cleaned$stage[which(all_cleaned$stage == "Late Miocene (Chasicoan-Huayquerian)")] <- "Chasicoan-Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Late Miocene (Huayquerian?)")] <- "Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Early Chasicoan")] <- "Chasicoan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pliocene (Chapadmalan?)")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Montehermosan-Chapadmalan (??)")] <- "Montehermosan-Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Rupelian (Tinguirirican?)")] <- "Tinguirirican"
all_cleaned$stage[which(all_cleaned$stage == "~Tinguirirican-Mustersan")] <- "Mustersan-Tinguirirican"
all_cleaned$stage[which(all_cleaned$stage == "Late Eocene (Tinguirirican?)")] <- "Tinguirirican"
all_cleaned$stage[which(all_cleaned$stage == "Lutetian (~Vacan)")] <- "Vacan"
all_cleaned$stage[which(all_cleaned$stage == "Middle Pliocene (Chapadmalan?)")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Serravallian (Laventan)")] <- "Laventan"
all_cleaned$stage[which(all_cleaned$stage == "Marplatan?")] <- "Marplatan"
all_cleaned$stage[which(all_cleaned$stage == "Priabonian (Mustersan?)")] <- "Mustersan"
all_cleaned$stage[which(all_cleaned$stage == "Priabonian (Mustersan?)")] <- "Mustersan"
all_cleaned$stage[which(all_cleaned$stage == "Casamayoran")] <- "Riochan-Barrancan"
all_cleaned$stage[which(all_cleaned$stage == "Bartonian (Barrancan?)")] <- "Barrancan"
all_cleaned$stage[which(all_cleaned$stage == "Bartonian-Priabonian  (Mustersan?)")] <- "Mustersan"
all_cleaned$stage[which(all_cleaned$stage == "Middle Eocene (Mustersan?)")] <- "Mustersan"
all_cleaned$stage[which(all_cleaned$stage == "Lutetian (Itaboraian?)")] <- "Itaboraian"
all_cleaned$stage[which(all_cleaned$stage == "Zanclean (Montehermosan?)")] <- "Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Piacenzian (Marplatan?)")] <- "Marplatan"
all_cleaned$stage[which(all_cleaned$stage == "Ypresian-Lutetian (~Riochican?)")] <- "Riochican"
all_cleaned$stage[which(all_cleaned$stage == "Lutetian (Sapoan?)")] <- "Sapoan"
all_cleaned$stage[which(all_cleaned$stage == "Lutetian-Bartonian (Sapoan?)")] <- "Sapoan"
all_cleaned$stage[which(all_cleaned$stage == "Holocene (Platan?)")] <- "Platan"
all_cleaned$stage[which(all_cleaned$stage == "Late Holocene (Platan?)")] <- "Platan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pliocene (Marplatan?)")] <- "Marplatan"
all_cleaned$stage[which(all_cleaned$stage == "PLiocene")] <- "Pliocene"
all_cleaned$stage[which(all_cleaned$stage == "Middle Miocene (Laventan?)")] <- "Laventan"
all_cleaned$stage[which(all_cleaned$stage == "Holocene (Platan)")] <- "Platan"
all_cleaned$stage[which(all_cleaned$stage == "Middle Pleistocene (Bonaerian?)")] <- "Bonaerian"
all_cleaned$stage[which(all_cleaned$stage == "Platan-Lujanian")] <- "Lujanian-Platan"
all_cleaned$stage[which(all_cleaned$stage == "Lujanian?")] <- "Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Pleistocene (Lujanian?)")] <- "Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Late Pliocene-Early Pleistocene (Marplatan?)")] <- "Marplatan"
all_cleaned$stage[which(all_cleaned$stage == "Bonaerian - Ensenadan")] <- "Ensenadan-Bonaerian"
all_cleaned$stage[which(all_cleaned$stage == "Zanclean (Montehermosan)")] <- "Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene?")] <- "Pleistocene"
all_cleaned$stage[which(all_cleaned$stage == "Ensenadan?")] <- "Ensenadan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene-Holocene?")] <- "Late Pleistocene-Holocene"
all_cleaned$stage[which(all_cleaned$stage == "Chapadmalan?")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Early Pleistocene (Ensenadan?)")] <- "Ensenadan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pliocene (Uquian-Chapadmalan)")] <- "Chapadmalan-Marplatan"
all_cleaned$stage[which(all_cleaned$stage == "Chasicoan - Mayoan")] <- "Maoyan-Chasicoan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pliocene (Chapadmalan)")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Early Pliocene (Montehermosan)")] <- "Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Late Pliocene (Chapadmalalian)")] <- "Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Calabrian (Ensenadan)")] <- "Ensenadan"
all_cleaned$stage[which(all_cleaned$stage == "Late Miocene (Chasicoan?)")] <- "Chasicoan"
all_cleaned$stage[which(all_cleaned$stage == "Bonaerian?")] <- "Bonaerian"
all_cleaned$stage[which(all_cleaned$stage == "Langhian (Colloncuran?)")] <- "Colloncuran"
all_cleaned$stage[which(all_cleaned$stage == "middle Late Miocene")] <- "Santacrucian"
all_cleaned$stage[which(all_cleaned$stage == "Burdigalian (Santacrucian-Colhuehuapian?)")] <- "Colhuehuapian-Santacrucian"
all_cleaned$stage[which(all_cleaned$stage == "Late Miocene - Early Pliocene (Montehermosan-Huayquerian?)")] <- "Huayquerian-Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Lujanian-Bonaerian")] <- "Bonaerian-Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Zanclean (Chapadmalan-Montehermosan)")] <- "Montehermosan-Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian?")] <- "Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Pleistocene?")] <- "Early Pleistocene-Late Pleistocene"
all_cleaned$stage[which(all_cleaned$stage == "Friasian-Santacrucian")] <- "Santacrucian-Friasian"
all_cleaned$stage[which(all_cleaned$stage == "Riochan-Barrancan")] <- "Riochican-Barrancan"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian-Chapadmalan?")] <- "Huayquerian-Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian-Chasicoan?")] <- "Huayquerian-Chasicoan"
all_cleaned$stage[which(all_cleaned$stage == "Uquian (=Marplatan?)")] <- "Marplatan"
all_cleaned$stage[which(all_cleaned$stage == "Maoyan-Chasicoan")] <- "Mayoan-Chasicoan"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian-Laventan?")] <- "Laventan-Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Tortonian (Huayquerian-Chasicoan-Mayoan?)")] <- "Mayoan-Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian-Mayoan?")] <- "Mayoan-Huayquerian"
all_cleaned$stage[which(all_cleaned$stage == "Colloncuran?")] <- "Colloncuran"
all_cleaned$stage[which(all_cleaned$stage == "Montehermosan?")] <- "Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Chapadmalan-Montehermosan")] <- "Montehermosan-Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Barrancan-Vacan")] <- "Vacan-Barrancan"
all_cleaned$stage[which(all_cleaned$stage == "Colloncuran-laventan")] <- "Colloncuran-Laventan"
all_cleaned$stage[which(all_cleaned$stage == "late Holocene")] <- "Late Holocene"
all_cleaned$stage[which(all_cleaned$stage == "Ensenadan -  Lujanian")] <- "Ensenadan-Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Late Pleistocene - Early Holocene")] <- "Late Pleistocene-Early Holocene"
all_cleaned$stage[which(all_cleaned$stage == "Priabonian - Rupelian")] <- "Priabonian-Rupelian"
all_cleaned$stage[which(all_cleaned$stage == "Danian - Selandian")] <- "Danian-Selandian"
all_cleaned$stage[which(all_cleaned$stage == "Tinguirirican - Deseadan")] <- "Tinguirirican-Deseadan"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian - Montehermosan")] <- "Huayquerian-Montehermosan"
all_cleaned$stage[which(all_cleaned$stage == "Late Miocene - Early Pliocene")] <- "Late Miocene-Early Pliocene"
all_cleaned$stage[which(all_cleaned$stage == "Ypresian - Lutetian")] <- "Ypresian-Lutetian"
all_cleaned$stage[which(all_cleaned$stage == "Montehermosan - Chapadmalan")] <- "Montehermosan-Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Huayquerian - Chapadmalan")] <- "Huayquerian-Chapadmalan"
all_cleaned$stage[which(all_cleaned$stage == "Ensenadan - Lujanian")] <- "Ensenadan-Lujanian"
all_cleaned$stage[which(all_cleaned$stage == "Middle Pleistocene - Late Holocene")] <- "Middle Pleistocene-Late Holocene"
all_cleaned$stage[which(all_cleaned$stage == "Middle-Late Paleocene")] <- "Middle Paleocene-Late Paleocene"
all_cleaned$stage[which(all_cleaned$stage == "Middle-Late Miocene")] <- "Middle Miocene-Late Miocene"
all_cleaned$stage[which(all_cleaned$stage %in% c("\"Pinturan\"", 
                                                 "\"Pinturense\" (early Miocene)"))] <- "Early Miocene"
all_cleaned$stage[which(all_cleaned$stage == "\"Pleistocene\"")] <- "Pleistocene"

SALMA <- read_xlsx('./data_2023/time_bins/SALMA.xlsx')

ctr_min <- 0
ctr_max <- 0
for(stg in unique(all_cleaned$stage)){
  #choose ref if in SALMA
  hyp_spl <- strsplit(stg, split = "-")[[1]]
  if(length(hyp_spl) > 1){
    if((hyp_spl[1] %in% SALMA$interval_name == FALSE)){
      next
    }
    else if((hyp_spl[2] %in% SALMA$interval_name == FALSE)){
      next
    }
    
    else{
      ref_min <- SALMA$min_ma[which(SALMA$interval_name == hyp_spl[2])]
      ref_max <- SALMA$max_ma[which(SALMA$interval_name == hyp_spl[1])]
    }
  }
  else{
    if(stg %in% SALMA$interval_name == FALSE){
      next
    }
    else{
      ref_min <- SALMA$min_ma[which(SALMA$interval_name == stg)]
      ref_max <- SALMA$max_ma[which(SALMA$interval_name == stg)]
    }
  }
  #loop across occurrences associated to stg
  for(i in which(all_cleaned$stage == stg)){
    if(ref_min > all_cleaned$min_ma[i]){
      all_cleaned$min_ma[i] <- ref_min
      ctr_min <- ctr_min + 1
    }
    if(ref_max < all_cleaned$max_ma[i]){
      all_cleaned$max_ma[i] <- ref_max
      ctr_max <- ctr_max + 1
    }
  }
}

#add New taxa
  #EOT
new_tax <- read_xlsx("../../DATA/inventary_newly_added_EOT.xlsx")
new_tax$authorizer <- NA
new_tax$status <- "extinct"
new_tax$gen_lvl_status <- "extinct"
new_tax <- new_tax[, colnames(all_cleaned)]
  #bind
all_cleaned <- rbind.data.frame(all_cleaned, new_tax)
all_cleaned <- all_cleaned %>% arrange(order, family, genus, accepted_name, cc)
  #save
saveRDS(all_cleaned, "./data_2023/SPECIES_LISTS/3-Fully_cleaned_SALMA_kept.RDS")

#Subset EOT data
all_cleaned_EOT <- all_cleaned %>% filter(epoch %in% c("Eocene", "Oligocene"))
  #save
saveRDS(all_cleaned_EOT, "./data_2023/SPECIES_LISTS/6-Fully_cleaned_EOT_SA_Mammals.RDS")
