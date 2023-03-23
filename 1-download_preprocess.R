#####################################################################
############ Script for data accession and preparation ##############
#####################################################################

library(palaeoverse) #data preparation facilities
library(readxl) #read excel documents
library(tidyverse) #data management tools
library(hash) #dictionnary

## Download all south american genus-level Mammalia occurrences from pdbd ----------------------------------------------------------------
download.file(url = "https://paleobiodb.org/data1.2/occs/list.csv?base_name=Mammalia&taxon_reso=genus&cc=SOA&show=class,genus,loc,ref,entname,crmod",
              destfile = "./data_2023/Neotropical_Mammals_raw_2023.csv")

## Open the old and new datasets --------------------------------------------------------------------------------------------------------
data_2020_raw <- read.table("./data_2020/Mammalia.txt", header = TRUE, sep = '\t', fill = TRUE) #8,009 occurrences
data_2020_clean <- readxl::read_xlsx("./data_2020/Mammalia.xlsx") #dataset cleaned by Fabien, 7,7670 occurrences
data_2023 <- read.csv("./data_2023/Neotropical_Mammals_raw_2023.csv", header = TRUE) #9,750 occurrences

## Erase occurrences from the 2023 dataset that have been entered or modified before 19 May 2020 -------------------------------------------
get_old <- function(x){
  #date is in "YYYY-MM-DD hh:mm:ss" format. We first split using "-" as separator
  mod <- strsplit(data_2023$modified[x], split = "-")[[1]]
  year_modified <- as.numeric(mod[1])
  month_modified <- as.numeric(mod[2])
  day_modified <- as.numeric(strsplit(mod[3], split = " ")[[1]][1]) #we split the third element using " " as separator and take the first element
  if(year_modified < 2020){
    return(x)
  }
  else if( (year_modified == 2020) & (month_modified <= 05) & (day_modified < 19)){
    return(x)
  }
}
to_drop <- unlist(lapply(X = 1:nrow(data_2023), FUN = get_old)) #7,272 occurrences 
data_2023 <- data_2023[-to_drop, ]
rownames(data_2023) <- 1:nrow(data_2023)
rm(to_drop)

## Harmonise names among datasets --------------------------------------------------------------------------------------------------------
#Erase species name with "sp."  (2 functions, otherwise is a shit)
#in data_2020_raw
get_sp_raw <- function(x){
  if( ("sp." %in% strsplit(data_2020_raw$occurrence.species_name[x], split = " ")[[1]]) |
      (data_2020_raw$occurrence.species_name[x] == "morphotype 2") ){
    return(x)
  }
}
problematic_indices <- unlist(lapply(X = 1:nrow(data_2020_raw), 
                                     FUN = get_sp_raw))
data_2020_raw$occurrence.species_name[problematic_indices] <- NA
#in data_2020_clean
get_sp_clean <- function(x){
  if( ("sp." %in% strsplit(data_2020_clean$Species[x], split = " ")[[1]]) |
      ("sp.." %in% strsplit(data_2020_clean$Species[x], split = " ")[[1]]) |
      (data_2020_clean$Species[x] == "morphotype 2") ){
    return(x)
  }
}
problematic_indices <- unlist(lapply(X = 1:nrow(data_2020_clean), 
                                     FUN = get_sp_clean))
data_2020_clean$Species[problematic_indices] <- NA
rm(problematic_indices)

## Spot and correct potential mis-spellings between the three datasets -------------------------------------------------------------------
assemble_gen_sp <- function(x, dataset, sp_col, gen_col){
  if(is.na(dataset[x, c(sp_col)]) == TRUE){ #if species is NA
    return(dataset[x, c(gen_col)])
  }
  else{
    return(paste(dataset[x, c(gen_col)], dataset[x, c(sp_col)], sep = " "))
  }
}
names_old_raw <- unique(unlist(lapply(X = 1:nrow(data_2020_raw), 
                                      FUN = assemble_gen_sp, 
                                      dataset = data_2020_raw, 
                                      sp_col = "occurrence.species_name",
                                      gen_col = "occurrence.genus_name")))
names_old_clean <- unique(unlist(lapply(X = 1:nrow(data_2020_clean), 
                                        FUN = assemble_gen_sp, 
                                        dataset = data_2020_clean, 
                                        sp_col = "Species",
                                        gen_col = "Genus")))
names_new <- unique(data_2023$accepted_name)
taxdf <- data.frame(accepted_names = c(names_old_raw, names_old_clean, names_new))
rm(names_old_raw, names_old_clean, names_new)
#check spelling mistakes between all the names that we are dealing qith (from the 3 datasets)
check_spell_mistake <- palaeoverse::tax_check(taxdf, name = "accepted_names") 
synonyms <- check_spell_mistake$synonyms
#correct a bit (some were highlighted as synonyms whereas actually different)
not_syn <- c(16, #Megatherium americanum and Megatherium americium seem to be two different species
             20, #Oligoryzomys flavescens and Oligoryzomys fulvescens two different species
             22, #Parutaetus chilensis and chicoensis are two different species
             34, #Protosteiromys asmodeophilus and aesmeodeophilus both seem to exist (to be checked)
             40 #Scelidotheridium and Scelinotherium are different genera
)
synonyms1 <- synonyms[-not_syn, ]
row.names(synonyms1) <- 1:nrow(synonyms1)
#check one by one and create the "actual names" and "wrong names" vectors
actual_names <- c("Andinomys edax",
                  "Chorobates villosissimus",
                  "Cladosictis patagonicus",
                  "Didelphis brachiodonta",
                  "Eocardia excavata",
                  "Eosclerocalyptus tapinocephalus",
                  "Eucelophorus chapadmalensis",
                  "Gyrinodon quassus",
                  "Herpailurus yagouaroundi",
                  "Holochilus brasiliensis",
                  "Inia geoffrensis",
                  "Interatherium robustum",
                  "Lagostomus incisus",
                  "Macrochorobates chapadmalensis", #Chapadmal es una provincia argentina
                  "Macroeuphractus moreni",
                  "Megatherium tarijense",
                  "Mylodon darwinii", #both actually seem to be used
                  "Myocastor coypus",
                  "Palaeolama weddelli",
                  "Philander opossum",
                  "Phlyctaenopyga ameghinoi",
                  "Phugatherium cataclisticum",
                  "Platygonus chapadmalensis", #to be verified!!
                  "Pontoporia blainvillei",
                  "Proborhyaena gigantea",
                  "Procyon cancrivorus",
                  "Prolagostomus pusillus",
                  "Protamandua rothi", #both seem to be used though
                  "Prothoatherium colombianum",
                  "Protocyon scagliarum",
                  "Protypotherium attenuatum",
                  "Protypotherium praerutilum",
                  "Pyrotherium romeroi",
                  "Salladolodus deuterotherioides", #to be checked
                  "Scelidodon chiliensis",
                  "Smilodon riggii",
                  "Stegotherium tessellatum",
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
GenSp <- unlist(lapply(X = 1:nrow(data_2020_raw),
                       FUN = assemble_gen_sp,
                       dataset = data_2020_raw,
                       sp_col = "occurrence.species_name",
                       gen_col = "occurrence.genus_name"))
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
GenSp <- unlist(lapply(X = 1:nrow(data_2020_clean),
                       FUN = assemble_gen_sp,
                       dataset = data_2020_clean,
                       sp_col = "Species",
                       gen_col = "Genus"))
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
#write.csv(data_2020_raw, file = "./data_2020/Neotropical_Mammals_harmonised_2020.csv") #save raw dataset in case

## Match data_2023 occurrences with data_2020_clean ---------------------------------------------------------------------------------------
#get rid of unuseful columns
data_2020_clean <- data_2020_clean[, -c(2, 4, 11, 14, 16)]
data_2023 <- data_2023[, -c(1:4, 6:9, 11:14, 17:19, 25:29, 32:35)]
#Add "Order" (1) and "Reference" (16) columns to data_2020_clean
data_2020_clean <- data_2020_clean %>% add_column(Order = rep(NA, nrow(data_2020_clean)), .before = "Family")
data_2020_clean <- data_2020_clean %>% add_column(Reference = rep(NA, nrow(data_2020_clean)), .after = "Collection authorizer")
data_2020_clean <- rename(data_2020_clean, Status = "Status...6")
#Create Species and Genus columns in data_2023, erase "accepted_name" one and create 
get_taxo <- function(x){ #function to return vector of species of data_2023
  tot_name <- data_2023$accepted_name[x]
  return(unlist(strsplit(tot_name, split = " "))[2])
}
data_2023$Species <- unlist(lapply(X = 1:nrow(data_2023), FUN = get_taxo))
data_2023 <- data_2023[, -c(2)]
#Create "Status" column in data_2023
data_2023$Status <- unlist(lapply(X = data_2023$min_ma, 
                                  FUN = function(x){if(x < 5){return(NA)} #if the lower bound of the occurrence is older than 5My, we consider the species extinct (quite likely), else we don't know
                                    else if(x == 0){return("extant")} #if this bound is equal to 0, the species is extant
                                    else{return("extinct")}})) 
#Rename data_2023 columns based on data_2020
new_names <- c(`Collection number` = "collection_no",
               `Max age` = "max_ma",
               `Min age` = "min_ma",
               Order = "order",
               Family = "family",
               Genus = "genus",
               Country = "cc",
               State = 'state',
               Reference = "primary_reference",
               `Collection authorizer` = "authorizer")
data_2023 <- rename(data_2023, all_of(new_names))
#Solve Country issue
country_dict <- hash(keys = unique(data_2023$Country),
                     values = c("Argentina", "Brazil", "Chile", "Bolivia", "Uruguay", "Peru", "Venezuela", "Ecuador", "Colombia"))
for(abbrev in keys(country_dict)){
  data_2023$Country[which(data_2023$Country == abbrev)] <- as.character(values(country_dict[abbrev]))
}
#add missing columns
data_2023$Period <- rep(NA, nrow(data_2023))
data_2023$Epoch <- rep(NA, nrow(data_2023))
data_2023$Note <- rep(NA, nrow(data_2023))
#reorder columns
data_2023 <- data_2023[, colnames(data_2020_clean)]

## Combine by rows and save the results ------------------------------------------------------------------------------------------------
write.csv(rbind(data_2020_clean, data_2023),
          file = "./data_2023/Neotropical_Mammals_COMBINED.csv",
          row.names = FALSE,
          na = "")
