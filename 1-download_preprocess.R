#####################################################################
############ Script for data accession and preparation ##############
#####################################################################

library(reticulate) #source python scripts in R
library(palaeoverse) #data preparation facilities
library(readxl) #read excel documents

#amahuacatherium peruvium = flan

## Download all south american genus-level Mammalia occurrences from pdbd -----------------------
  #highly detailed dataset => 3,394 occurrences (?!)
download.file(url = "https://paleobiodb.org/data1.2/occs/list.tsv?datainfo&rowcount&base_name=Mammalia&taxon_reso=genus&cc=SOA&show=attr,class,classext,genus,subgenus,taphonomy,coll,coords,loc,stratext,resgroup,ref,refattr,ent",
 destfile = "./data_2023/Neotropical_Mammals_raw_maxi_2023.tsv")
  #more minimalistic one (less features) => 9,750 occurrences
download.file(url = "https://paleobiodb.org/data1.2/occs/list.tsv?datainfo&rowcount&base_name=Mammalia&taxon_reso=genus&cc=SOA",
              destfile = "./data_2023/Neotropical_Mammals_raw_mini_2023.tsv")

## Get rid of of metadata by sourcing simple python scripts (watch working directory) -----------
reticulate::source_python("unhead_maxi.py") #maximalistic one
reticulate::source_python("unhead_mini.py") #minimalistic one

## Open the old and new datasets ----------------------------------------------------------------
data_2020 <- readxl::read_xlsx("./data_2020/Mammalia.xlsx") #length(which(data_2020$`Source database` == "PaleoDB")) = 2,746: nb of occurrences identified as coming from PBDB
data_2023_maxi <- read.table("./data_2023/Neotropical_Mammals_unheaded_maxi_2023.tsv", header = TRUE, sep = '\t', fill = TRUE) #ignore warning
data_2023_mini <- read.table("./data_2023/Neotropical_Mammals_unheaded_mini_2023.tsv", header = TRUE, sep = '\t', fill = TRUE)

## Create a "genus" column in the minimalistic dataset ------------------------------------------
get_taxo <- function(x, level = c("species", "genus")){
  tot_name <- data_2023_mini$accepted_name[x]
  if(level == "genus"){
    return(unlist(strsplit(tot_name, split = " "))[1])
  }
  else if(level == "species"){
    return(unlist(strsplit(tot_name, split = " "))[2])
  }
}
data_2023_mini$genus <- unlist(lapply(X = 1:nrow(data_2023_mini), FUN = get_taxo, level = "genus"))
data_2023_mini$species <- unlist(lapply(X = 1:nrow(data_2023_mini), FUN = get_taxo, level = "species"))

## Identify and erase common occurrences between 2020 and 2023 datasets --------------------------
find_redundancy <- function(index, ds){ #function returning duplicate indices between 2023 and 2020 datasets
  return(
    which( (ds[, c('collection_no')] == data_2020$`Collection number`[index]) & 
            (ds[, c('min_ma')] == data_2020$`Min age`[index]) & 
            (ds[, c('max_ma')] == data_2020$`Max age`[index]) & 
            (ds[, c('genus')] == data_2020$Genus[index]) )
                )
}
redundant_indices_maxi <- unique(unlist(lapply(X = 1:nrow(data_2020), FUN = find_redundancy, ds = data_2023_maxi)))
data_2023_maxi <- data_2023_maxi[-redundant_indices_maxi, ]

redundant_indices_mini <- unique(unlist(lapply(X = 1:nrow(data_2020), FUN = find_redundancy, ds = data_2023_mini)))
data_2023_mini <- data_2023_mini[-redundant_indices_mini, ]

## Check and correct potential mis-spellings between the three datasets ---------------------------
names_old <- unique(paste(data_2020$Genus, data_2020$Species, sep = " "))
names_max <- unique(data_2023_maxi$accepted_name)
names_min <- unique(data_2023_mini$accepted_name)
taxdf <- data.frame(accepted_names = c(names_old, names_max, names_min))
#check spelling mistakes between all the names that we are dealing qith (from the 3 datasets)
check_spell_mistake <- palaeoverse::tax_check(taxdf, name = "accepted_names") 
synonyms <- check_spell_mistake$synonyms
#correct a bit (some were highlighted as synonyms whereas actually different, e.g sp.1 vs sp.2
not_syn <- c(2,4,13,14,15,
             22, #Megatherium americanum and Megatherium americium seem to be two different species
             23,24,25,26,27,28,
             32, #Oligoryzomys flavescens and Oligoryzomys fulvescens two different species
             34, #a matter of "sp." vs nothing among this lovely palaeo-tattoo
             35, #Parutaetus chilensis and chicoensis are two different species
             36,37,38,39,40,41,47,48,49,51,52,53,55,56,57,64,65,66,73)
synonyms1 <- synonyms[-not_syn, ]
row.names(synonyms1) <- 1:nrow(synonyms1)
#check one by one and add the "actual_name" column, containing the name well spelled
synonyms1$actual_name <- c("Adianthus bucatus",
                          "Andinomys edax",
                          "Chorobates villosissimus",
                          "Cladosictis patagonica",
                          "Didelphis brachiodonta",
                          "Eocardia excavata",
                          "Eosclerocalyptus tapinocephalus",
                          "Eucelophorus chapalmalensi",
                          "Glossotherium",
                          "Gyrinodon quassus",
                          "Homalodontotherium sp.",
                          "Interatherium robustum",
                          "Lagostomus incisus",
                          "Luanthus initialis",
                          "Macrochorobates chapalmalensis",
                          "Macroeuphractus moreni",
                          "Megatherium tarijense",
                          "Mylodon darwinii", #both actually seem to be used
                          "Myocastor coypus",
                          "Palaeolama weddelli",
                          "Philander opossum",
                          "Phlyctaenopyga ameghini",
                          "Phugatherium cataclisticum",
                          "Platygonus chapadmalensis", #to be verified!!
                          
                          )

## Erase from the minimalistic occurrences also present in the maximalistic dataset --------------

