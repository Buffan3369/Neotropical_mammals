#####################################################################
############ Script for data accession and preparation ##############
#####################################################################

library(reticulate) #source python scripts in R
library(palaeoverse) #data preparation facilities
library(readxl) #read excel documents

#amahuacatherium peruvium = flan

## Download all south american genus-level Mammalia occurrences from pdbd ----------------------------------------------------------------
download.file(url = "https://paleobiodb.org/data1.2/occs/list.csv?base_name=Mammalia&taxon_reso=genus&cc=SOA&show=class,genus,loc,ref,entname,crmod",
              destfile = "./data_2023/Neotropical_Mammals_raw_2023.csv")

## Open the old and new datasets --------------------------------------------------------------------------------------------------------
data_2020_raw <- read.table("./data_2020/Mammalia.txt", header = TRUE, sep = '\t', fill = TRUE) #8,009 occurrences
data_2020_clean <- readxl::read_xlsx("./data_2020/Mammalia.xlsx") #dataset cleaned by Fabien, 7,7670 occurrences
data_2023 <- read.csv("./data_2023/Neotropical_Mammals_raw_2023.csv", header = TRUE) #9,750 occurrences

## Erase occurrences from the 2023 dataset that have been entered or modified before March 2020 -----------------------------------------
get_old <- function(x){
  year_modified <- as.numeric(strsplit(data_2023$modified[x], split = "-")[[1]][1])
  month_modified <- as.numeric(strsplit(data_2023$modified[x], split = "-")[[1]][2])
  if( (year_modified < 2020) | (month_modified < 03) ){
    return(x)
  }
}
to_drop <- unlist(lapply(X = 1:nrow(data_2023), FUN = get_old)) #7,382 occurrences 
data_2023 <- data_2023[-to_drop, ]

## Check and correct potential mis-spellings between the three datasets -------------------------------------------------------------------
names_old_raw <- unique(paste(data_2020_raw$occurrence.genus_name, data_2020_raw$occurrence.species_name, sep = " "))
names_old_clean <- unique(paste(data_2020_clean$Genus, data_2020_clean$Species, sep = " "))
names_new <- unique(data_2023$accepted_name)
taxdf <- data.frame(accepted_names = c(names_old_raw, names_old_clean, names_new))
rm(names_old_raw, names_old_clean, names_new)
#check spelling mistakes between all the names that we are dealing qith (from the 3 datasets)
check_spell_mistake <- palaeoverse::tax_check(taxdf, name = "accepted_names") 
synonyms <- check_spell_mistake$synonyms
#correct a bit (some were highlighted as synonyms whereas actually different, e.g sp.1 vs sp.2
not_syn <- c(2,4,13:15,
             25, #Megatherium americanum and Megatherium americium seem to be two different species
             26:31,
             35, #Oligoryzomys flavescens and Oligoryzomys fulvescens two different species
             37, #a matter of "sp." vs nothing among this lovely palaeo-tattoo
             38, #Parutaetus chilensis and chicoensis are two different species
             39:44,
             50:52,
             56:58,
             60:62,
             69:71,
             76, #Scelidotheridium and Scelinotherium are different genera
             77:78,
             84)
synonyms1 <- synonyms[-not_syn, ]
row.names(synonyms1) <- 1:nrow(synonyms1)
#check one by one and create the "actual names" and "wrong names" vectors
actual_names <- c("Adianthus bucatus",
                  "Andinomys edax",
                  "Chorobates villosissimus",
                  "Cladosictis patagonica",
                  "Didelphis brachiodonta",
                  "Eocardia excavata",
                  "Eosclerocalyptus tapinocephalus",
                  "Eucelophorus chapalmalensis",
                  "Glossotherium",
                  "Gyrinodon quassus",
                  "Herpailurus yagouaroundi",
                  "Holochilus brasiliensis",
                  "Homalodontotherium sp.",
                  "Inia geoffrensis",
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
                  "Phlyctaenopyga ameghinoi",
                  "Phugatherium cataclisticum",
                  "Platygonus chapadmalensis", #to be verified!!
                  "Platygonus scagliae",
                  "Pontoporia blainvillei",
                  "Proborhyaena gigantea",
                  "Procyon cancrivorus",
                  "Prolagostomus pusillus",
                  "Protamandua rothi", #both seem to exist though
                  "Prothoatherium colombianus",
                  "Protocyon scagliarum",
                  "Protosteiromys asmeodeophilus",
                  "Protypotherium attenuatum",
                  "Protypotherium praerutilum",
                  "Prozaedyus planus",
                  "Pyrotherium romeroi",
                  "Salladolodus deuterotherioides", #to be checked
                  "Scelidodon chiliense",
                  "Smilodon riggii",
                  "Stegotherium tessellatum",
                  "Tapirus oliverasi",
                  "Thylamys zettii",
                  "Thylophorops chapadmalensis")
get_the_other <- function(x){
  if(x %in% synonyms1$greater){
    return(synonyms1$lesser[which(synonyms1$greater == x)])
  }
  else{
    return(synonyms1$greater[which(synonyms1$lesser == x)])
  }
}
wrong_names <- unlist(lapply(X = actual_names, FUN = get_the_other))
rm(taxdf, check_spell_mistake, synonyms, synonyms1, not_syn)
#replace wrong names in the 3 datasets
  #data_2020_raw
GenSp <- paste(data_2020_raw$occurrence.genus_name, data_2020_raw$occurrence.species_name, sep = " ")
index_to_replace <- which(GenSp %in% wrong_names) #indices of the names to replace in the dataframe's accepted names
values_to_replace <- GenSp[which(GenSp %in% wrong_names)] #names to replace in the dataframe's accepted names
i = 1
index_in_wrong_names <- c() #indices of these names in wrong_names (and actual_names a fortiori) in the right order
while(i <= length(index_to_replace)){
  value <- values_to_replace[i]
  index_in_wrong_names <- c(index_in_wrong_names, which(wrong_names == value))
  i = i+1
}
GenSp <- replace(x = GenSp,
                 list = index_to_replace,
                 values = actual_names[index_in_wrong_names]) #replacement
GenSp_split <- lapply(X = GenSp, FUN = strsplit, split = " ")
genus <- c()
species <- c()
for(i in 1:length(GenSp)){
  genus <- c(genus, GenSp_split[[i]][[1]][1])
  species <- c(species, GenSp_split[[i]][[1]][2])
}
data_2020_raw$occurrence.genus_name <- genus
data_2020_raw$occurrence.species_name <- species
###Validation###
#paste(data_2020_raw$occurrence.genus_name[index_to_replace], data_2020_raw$occurrence.species_name[index_to_replace], sep = " ") == values_to_replace
################
  #data_2020_clean
GenSp <- paste(data_2020_clean$Genus, data_2020_clean$Species, sep = " ")
index_to_replace <- which(GenSp %in% wrong_names) #indices of the names to replace in the dataframe's accepted names
values_to_replace <- GenSp[which(GenSp %in% wrong_names)] #names to replace in the dataframe's accepted names
i = 1
index_in_wrong_names <- c() #indices of these names in wrong_names (and actual_names a fortiori) in the right order
while(i <= length(index_to_replace)){
  value <- values_to_replace[i]
  index_in_wrong_names <- c(index_in_wrong_names, which(wrong_names == value))
  i = i+1
}
GenSp <- replace(x = GenSp,
                 list = index_to_replace,
                 values = actual_names[index_in_wrong_names]) #replacement
GenSp_split <- lapply(X = GenSp, FUN = strsplit, split = " ")
genus <- c()
species <- c()
for(i in 1:length(GenSp)){
  genus <- c(genus, GenSp_split[[i]][[1]][1])
  species <- c(species, GenSp_split[[i]][[1]][2])
}
data_2020_clean$Genus <- genus
data_2020_clean$Species <- species
  #data_2023
index_to_replace <- which(data_2023$accepted_name %in% wrong_names) #indices of the names to replace in the dataframe's accepted names
values_to_replace <- data_2023$accepted_name[which(data_2023$accepted_name %in% wrong_names)] #names to replace in the dataframe's accepted names
i = 1
index_in_wrong_names <- c() #indices of these names in wrong_names (and actual_names a fortiori) in the right order
while(i <= length(index_to_replace)){
  value <- values_to_replace[i]
  index_in_wrong_names <- c(index_in_wrong_names, which(wrong_names == value))
  i = i+1
}
data_2023$accepted_name <- replace(x = data_2023$accepted_name,
                                        list = index_to_replace,
                                        values = actual_names[index_in_wrong_names]) #replacement
rm(index_in_wrong_names, index_to_replace, values_to_replace, GenSp, GenSp_split, value, wrong_names, actual_names)

## Harmonise names among datasets ---------------------------------------------------------------------
get_taxo <- function(x, level = c("species", "genus")){ #function to return vector of either genus or species of data_2023
  tot_name <- data_2023$accepted_name[x]
  if(level == "genus"){
    return(unlist(strsplit(tot_name, split = " "))[1])
  }
  else if(level == "species"){
    return(unlist(strsplit(tot_name, split = " "))[2])
  }
}
  #Erase names between parenthesis in data_2023
species_2023 <- unlist(lapply(X = 1:nrow(data_2023), FUN = get_taxo, level = "species"))
get_par <- function(x){ #get position of parenthesis
  if("(" %in% strsplit(species_2023[x], split = "")[[1]]){
    return(x)
  }
}
for(i in unlist(lapply(X = 1:length(species_2023), FUN = get_par))){ #for each position where we detected a parenthesis
  name <- data_2023$accepted_name[i]
  if(length(strsplit(name, split = " ")) == 2){ #if name = "Genus (Genus)"
    data_2023$accepted_name[i] <- strsplit(name, split = " ")[[1]][1] #genus name only
  }
  else{ #name = Genus (~Genus) species
    data_2023$accepted_name[i] <- paste(strsplit(name, split = " ")[[1]][1], #genus
                                        strsplit(name, split = " ")[[1]][length(strsplit(name, split = " ")[[1]])], #last element, species
                                        sep = " ")
  }
}
    #Erase species name when "sp." in data_2020_raw
problematic_indices <- which(data_2020_raw$occurrence.species_name == "sp.")
data_2020_raw$occurrence.species_name[problematic_indices] <- NA

  #Create species and genus columns in data_2023
data_2023$genus <- unlist(lapply(X = 1:nrow(data_2023), FUN = get_taxo, level = "genus"))
data_2023$species <- unlist(lapply(X = 1:nrow(data_2023), FUN = get_taxo, level = "species"))

  #Create full name column in data_2020
data_2020_raw$accepted_name <- paste(data_2020_raw$occurrence.genus_name, data_2020_raw$occurrence.species_name, sep = " ")
no_space <- which(is.na(data_2020_raw$occurrence.species_name))
data_2020_raw$accepted_name[no_space] <- data_2020_raw$occurrence.genus_name[no_space] #from "Genus " to "Genus"



## Combine by columns and save the results -----------------------------------------------------------------------------------------------------------------------
write.csv(data_2020_raw, file = "./data_2020/Neotropical_Mammals_harmonised_2020.csv")
write.csv(data_2023, file = "./data_2023/Neotropical_Mammals_harmonised_2023.csv")
