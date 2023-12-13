library(readxl)
library(palaeoverse)
library(dplyr)

# Dataset ----------------------------------------------------------------------
ds <- read.csv("./data_2023/SPECIES_LISTS/3-Fully_cleaned_and_SALMA_matched_Cnz_SA_Mammals.csv",
               sep = ";",
               header = TRUE)
SALMA <- read_xlsx('./data_2023/time_bins/SALMA.xlsx')
sub_epochs <- read_xlsx("./data_2023/time_bins/EarlyMidLate_epochs.xlsx")
ICC <- time_bins("Cenozoic")
#hybrid time bins dataset
bins <- rbind.data.frame(SALMA[, c("interval_name", "min_ma", "max_ma")],
                         ICC[, c("interval_name", "min_ma", "max_ma")],
                         sub_epochs)
bins <- bins %>% add_row(interval_name = c("Holocene", "Pleistocene", "Pliocene", "Oligocene"),
                         min_ma = c(0, 0.0117, 2.58, 23.03),
                         max_ma = c(0.0117, 2.58, 5.33, 33.9))

# Fix non-regular stage assignations -------------------------------------------
ds$stage[which(ds$stage == "Ypresian (Sapoan-Riochican-Itaboraian)")] <- "Itaboraian-Sapoan"
ds$stage[which(ds$stage == "Early Oligocene (Tinguirirican)")] <- "Tinguirirican"
ds$stage[which(ds$stage == "Late Pleistocene (Lujanian)")] <- "Lujanian"
ds$stage[which(ds$stage == "Upper Miocene - Chasicoan" )] <- "Chasicoan"
ds$stage[which(ds$stage == "Tinguirirican o Deseadan" )] <- "Tinguirirican-Deseadan"
#PINTURAN TO CHECK
ds$stage[which(ds$stage == "Langhian-Serravallian (Laventan-Colloncuran)" )] <- "Laventan-Colloncuran"
ds$stage[which(ds$stage == "Pinturense (early Miocene)")] <- "Pinturan"
ds$stage[which(ds$stage == "Burdigalian (Colhuehuapian)")] <- "Colhuehuapian"
ds$stage[which(ds$stage == "Burdigalian-Langhian (Friasian)")] <- "Friasian"
ds$stage[which(ds$stage == "Late Pleistocene-Late Holocene (Lujanian-Platan)")] <- "Lujanian-Platan"
ds$stage[which(ds$stage == "Middle Pleistocene (Bonaerian)")] <- "Bonaerian"
ds$stage[which(ds$stage == "Late Pleistocene-Late Holocene  (Lujanian-Platan)")] <- "Lujanian-Platan"
ds$stage[which(ds$stage == "Tortonian (Huayquerian)")] <- "Huayquerian"
ds$stage[which(ds$stage == "Late Miocene (Huayquerian)")] <- "Huayquerian"
ds$stage[which(ds$stage == "Deseadan-Tinguirirican?")] <- "Deseadan-Tinguirirican"
ds$stage[which(ds$stage == "Priabonian (~Tinguirirican)")] <- "Tinguirirican"
ds$stage[which(ds$stage == "Ypresian (Late Early Eocene)")] <- "Ypresian"
ds$stage[which(ds$stage == "Early Chapadmalan")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Zanclean (~Montehermosan)")] <- "Montehermosan"
ds$stage[which(ds$stage == "Late Pleistocene (Lujanian?)")] <- "Lujanian"
ds$stage[which(ds$stage == "Holocene-Lujanian?")] <- "Lujanian"
ds$stage[which(ds$stage == "Piacenzian (~Chapadmalan)")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Casamayoran (Vacan)")] <- "Vacan"
ds$stage[which(ds$stage == "Bartonian (~Mustersan)")] <- "Mustersan"
ds$stage[which(ds$stage == "Pliocene (?)")] <- "Pliocene"
ds$stage[which(ds$stage == "Late Miocene (Chasicoan-Huayquerian)")] <- "Chasicoan-Huayquerian"
ds$stage[which(ds$stage == "Late Miocene (Huayquerian?)")] <- "Huayquerian"
ds$stage[which(ds$stage == "Early Chasicoan")] <- "Chasicoan"
ds$stage[which(ds$stage == "Late Pliocene (Chapadmalan?)")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Montehermosan-Chapadmalan (??)")] <- "Montehermosan-Chapadmalan"
ds$stage[which(ds$stage == "Rupelian (Tinguirirican?)")] <- "Tinguirirican"
ds$stage[which(ds$stage == "~Tinguirirican-Mustersan")] <- "Mustersan-Tinguirirican"
ds$stage[which(ds$stage == "Late Eocene (Tinguirirican?)")] <- "Tinguirirican"
ds$stage[which(ds$stage == "Lutetian (~Vacan)")] <- "Vacan"
ds$stage[which(ds$stage == "Middle Pliocene (Chapadmalan?)")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Serravallian (Laventan)")] <- "Laventan"
ds$stage[which(ds$stage == "Marplatan?")] <- "Marplatan"
ds$stage[which(ds$stage == "Priabonian (Mustersan?)")] <- "Mustersan"
ds$stage[which(ds$stage == "Priabonian (Mustersan?)")] <- "Mustersan"
ds$stage[which(ds$stage == "Casamayoran")] <- "Riochan-Barrancan"
ds$stage[which(ds$stage == "Bartonian (Barrancan?)")] <- "Barrancan"
ds$stage[which(ds$stage == "Bartonian-Priabonian  (Mustersan?)")] <- "Mustersan"
ds$stage[which(ds$stage == "Middle Eocene (Mustersan?)")] <- "Mustersan"
ds$stage[which(ds$stage == "Lutetian (Itaboraian?)")] <- "Itaboraian"
ds$stage[which(ds$stage == "Zanclean (Montehermosan?)")] <- "Montehermosan"
ds$stage[which(ds$stage == "Piacenzian (Marplatan?)")] <- "Marplatan"
ds$stage[which(ds$stage == "Ypresian-Lutetian (~Riochican?)")] <- "Riochican"
ds$stage[which(ds$stage == "Lutetian (Sapoan?)")] <- "Sapoan"
ds$stage[which(ds$stage == "Lutetian-Bartonian (Sapoan?)")] <- "Sapoan"
ds$stage[which(ds$stage == "Holocene (Platan?)")] <- "Platan"
ds$stage[which(ds$stage == "Late Holocene (Platan?)")] <- "Platan"
ds$stage[which(ds$stage == "Late Pliocene (Marplatan?)")] <- "Marplatan"
ds$stage[which(ds$stage == "PLiocene")] <- "Pliocene"
ds$stage[which(ds$stage == "Middle Miocene (Laventan?)")] <- "Laventan"
ds$stage[which(ds$stage == "Holocene (Platan)")] <- "Platan"
ds$stage[which(ds$stage == "Middle Pleistocene (Bonaerian?)")] <- "Bonaerian"
ds$stage[which(ds$stage == "Platan-Lujanian")] <- "Lujanian-Platan"
ds$stage[which(ds$stage == "Lujanian?")] <- "Lujanian"
ds$stage[which(ds$stage == "Pleistocene (Lujanian?)")] <- "Lujanian"
ds$stage[which(ds$stage == "Late Pliocene-Early Pleistocene (Marplatan?)")] <- "Marplatan"
ds$stage[which(ds$stage == "Bonaerian - Ensenadan")] <- "Ensenadan-Bonaerian"
ds$stage[which(ds$stage == "Zanclean (Montehermosan)")] <- "Montehermosan"
ds$stage[which(ds$stage == "Late Pleistocene?")] <- "Pleistocene"
ds$stage[which(ds$stage == "Ensenadan?")] <- "Ensenadan"
ds$stage[which(ds$stage == "Late Pleistocene-Holocene?")] <- "Late Pleistocene-Holocene"
ds$stage[which(ds$stage == "Chapadmalan?")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Early Pleistocene (Ensenadan?)")] <- "Ensenadan"
ds$stage[which(ds$stage == "Late Pliocene (Uquian-Chapadmalan)")] <- "Chapadmalan-Marplatan"
ds$stage[which(ds$stage == "Chasicoan - Mayoan")] <- "Maoyan-Chasicoan"
ds$stage[which(ds$stage == "Late Pliocene (Chapadmalan)")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Early Pliocene (Montehermosan)")] <- "Montehermosan"
ds$stage[which(ds$stage == "Late Pliocene (Chapadmalalian)")] <- "Chapadmalan"
ds$stage[which(ds$stage == "Calabrian (Ensenadan)")] <- "Ensenadan"
ds$stage[which(ds$stage == "Late Miocene (Chasicoan?)")] <- "Chasicoan"
ds$stage[which(ds$stage == "Bonaerian?")] <- "Bonaerian"
ds$stage[which(ds$stage == "Langhian (Colloncuran?)")] <- "Colloncuran"
ds$stage[which(ds$stage == "middle Late Miocene")] <- "Santacrucian"
ds$stage[which(ds$stage == "Burdigalian (Santacrucian-Colhuehuapian?)")] <- "Colhuehuapian-Santacrucian"
ds$stage[which(ds$stage == "Late Miocene - Early Pliocene (Montehermosan-Huayquerian?)")] <- "Huayquerian-Montehermosan"
ds$stage[which(ds$stage == "Lujanian-Bonaerian")] <- "Bonaerian-Lujanian"
ds$stage[which(ds$stage == "Zanclean (Chapadmalan-Montehermosan)")] <- "Montehermosan-Chapadmalan"
ds$stage[which(ds$stage == "Huayquerian?")] <- "Huayquerian"
ds$stage[which(ds$stage == "Pleistocene?")] <- "Early Pleistocene-Late Pleistocene"
ds$stage[which(ds$stage == "Friasian-Santacrucian")] <- "Santacrucian-Friasian"
ds$stage[which(ds$stage == "Riochan-Barrancan")] <- "Riochican-Barrancan"
ds$stage[which(ds$stage == "Huayquerian-Chapadmalan?")] <- "Huayquerian-Chapadmalan"
ds$stage[which(ds$stage == "Huayquerian-Chasicoan?")] <- "Huayquerian-Chasicoan"
ds$stage[which(ds$stage == "Uquian (=Marplatan?)")] <- "Marplatan"
ds$stage[which(ds$stage == "Maoyan-Chasicoan")] <- "Mayoan-Chasicoan"
ds$stage[which(ds$stage == "Huayquerian-Laventan?")] <- "Laventan-Huayquerian"
ds$stage[which(ds$stage == "Tortonian (Huayquerian-Chasicoan-Mayoan?)")] <- "Mayoan-Huayquerian"
ds$stage[which(ds$stage == "Huayquerian-Mayoan?")] <- "Mayoan-Huayquerian"
ds$stage[which(ds$stage == "Colloncuran?")] <- "Colloncuran"
ds$stage[which(ds$stage == "Montehermosan?")] <- "Montehermosan"
ds$stage[which(ds$stage == "Chapadmalan-Montehermosan")] <- "Montehermosan-Chapadmalan"
ds$stage[which(ds$stage == "Barrancan-Vacan")] <- "Vacan-Barrancan"
ds$stage[which(ds$stage == "Colloncuran-laventan")] <- "Colloncuran-Laventan"
ds$stage[which(ds$stage == "late Holocene")] <- "Late Holocene"
ds$stage[which(ds$stage == "Ensenadan -  Lujanian")] <- "Ensenadan-Lujanian"
ds$stage[which(ds$stage == "Late Pleistocene - Early Holocene")] <- "Late Pleistocene-Early Holocene"
ds$stage[which(ds$stage == "Priabonian - Rupelian")] <- "Priabonian-Rupelian"
ds$stage[which(ds$stage == "Danian - Selandian")] <- "Danian-Selandian"
ds$stage[which(ds$stage == "Tinguirirican - Deseadan")] <- "Tinguirirican-Deseadan"
ds$stage[which(ds$stage == "Huayquerian - Montehermosan")] <- "Huayquerian-Montehermosan"
ds$stage[which(ds$stage == "Late Miocene - Early Pliocene")] <- "Late Miocene-Early Pliocene"
ds$stage[which(ds$stage == "Ypresian - Lutetian")] <- "Ypresian-Lutetian"
ds$stage[which(ds$stage == "Montehermosan - Chapadmalan")] <- "Montehermosan-Chapadmalan"
ds$stage[which(ds$stage == "Huayquerian - Chapadmalan")] <- "Huayquerian-Chapadmalan"
ds$stage[which(ds$stage == "Ensenadan - Lujanian")] <- "Ensenadan-Lujanian"
ds$stage[which(ds$stage == "Middle Pleistocene - Late Holocene")] <- "Middle Pleistocene-Late Holocene"
ds$stage[which(ds$stage == "Middle-Late Paleocene")] <- "Middle Paleocene-Late Paleocene"
ds$stage[which(ds$stage == "Middle-Late Miocene")] <- "Middle Miocene-Late Miocene"


# Identify stages included in regular time datasets ----------------------------
stg <- unique(ds$stage)
stg_abs <- stg[-which(stg %in% bins$interval_name)]
stg_pres <- stg[!(stg %in% stg_abs)]

# Match occurrences with unique stage to the stage boundaries (6919 occ) -------
ds1 <- ds 
for(stage in stg_pres){
  #get ref age boundaries
  ref_min <- bins$min_ma[which(bins$interval_name == stage)]
  ref_max <- bins$max_ma[which(bins$interval_name == stage)]
  #replace
  ds1$min_ma[which(ds1$stage == stage)] <- ref_min
  ds1$max_ma[which(ds1$stage == stage)] <- ref_max
}

# Match occurrences with combined time interval (Int1-Int2 with Int1 > Int2) ---
for(int in stg_abs[!(stg_abs == "Pinturan")]){
  spl <- strsplit(int, split = "-")[[1]]
  #get ref age boundaries
  ref_min <- bins$min_ma[which(bins$interval_name == spl[2])]
  ref_max <- bins$max_ma[which(bins$interval_name == spl[1])]
  #replace
  ds1$min_ma[which(ds1$stage == int)] <- ref_min
  ds1$max_ma[which(ds1$stage == int)] <- ref_max
}

# Matching occ from with clear age constraint (tuffs) --------------------------
  #La Cantera (Dunn et al. 2013)
LC <- which(ds1$locality %in% c("Gran Barranca (La Cantera)", "La Cantera"))
ds1$min_ma[LC] <- 30.617
ds1$max_ma[LC] <- 30.77
  #La Cancha (Dunn et al. 2013)
LC <- which(ds1$locality %in% c("Gran Barranca (La Cancha)", "La Cancha"))
ds1$min_ma[LC] <- 33.56
ds1$max_ma[LC] <- 33.6
  #Deseadan soricacebines Branisella and Canaanimico (Marivaux et al. 2016)
idx <- which(ds1$genus %in% c("Canaanimico", "Branisella"))
ds1$min_ma[idx] <- 24.5
ds1$max_ma[idx] <- 26
