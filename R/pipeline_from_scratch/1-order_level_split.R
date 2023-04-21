#################################################################################
###################### Separate raw occurrences by order ########################
#################################################################################

## Libraries -----------------------------------------------------------
library(hash)
## Open raw data -------------------------------------------------------
raw_2023 <- read.csv("./data_2023/Neotropical_Mammals_raw_2023.csv") 
## Remove occurrences out of time coverage -----------------------------
too_old <- which(raw_2023$min_ma >= 66)
raw_2023 <- raw_2023[-too_old, ]
## Exclude occurrences with doubtful name ------------------------------
no_dub <- function(name){
  spl <- strsplit(name, split = " ")[[1]]
  if("nomen" %in% spl){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
}
raw_2023 <- raw_2023[-which(lapply(X = raw_2023$difference, FUN = no_dub) == TRUE), ]
## Remove genera introduced by or extinct because of humans ------------
raw_2023 <- raw_2023[-which(raw_2023$genus %in% c("Lepus", "Neomonachus", "Mus", "Sus")),]
## Correct typos -------------------------------------------------------
dict_typo_corr <- hash(keys = c("Epieuryceros", "Bolomys", "Pithiculites", "Glossotheridium", "Plesioxotodon", "Hippidium"), #in raw dataset
                       values = c("Epieurycerus", "Necromys", "Pitheculites", "Glossotherium", "Plesiotoxodon", "Hippidion")) #corrected names
#sometimes, genera have more than one component, e.g. "Hippidium (Plagiohippus)"
splitted_genera <- lapply(X = raw_2023$genus, FUN = function(x){return(strsplit(x, split = " ")[[1]][1])})
#function to replace the first compound of a name
rpl_first <- function(full_name, new_first, split = " "){
  spl <- strsplit(full_name, split = split)[[1]]
  spl[1] <- new_first
  replaced <- ""
  for(i in spl){
    replaced <- paste(replaced, i)
  }
  return(replaced)
}
#apply
for(key in keys(dict_typo_corr)){
  raw_2023$genus[which(splitted_genera == key)] <- dict_typo_corr[[key]]
  raw_2023$accepted_name[which(splitted_genera == key)] <- rpl_first(full_name = raw_2023$accepted_name[which(splitted_genera == key)],
                                                                     new_first = dict_typo_corr[[key]])
}
#typo on family names
raw_2023$family[which(raw_2023$family == "Pyrotheridae")] <- "Pyrotheriidae"
## Assign orders to occurrences with unknown order ----------------------
#Polydolopimorphia
raw_2023$order[which( (raw_2023$family %in% c("Argyrolagidae", "Bonapartheriidae", "Polydolopidae", "Prepidolopidae"))) |
                 (raw_2023$genus %in% c("Wamradolops", "Roberthoffstetteria"))] <- "Polydolopimorphia"
#Pyrotheria
raw_2023$order[which((raw_2023$family %in% c("Pyrotheriidae", "Rosendolopidae")) |
                       raw_2023$genus == "Griphodon")] <- "Pyrotheria"
#Gondwanatheria
raw_2023$order[which(raw_2023$family == "Sudamericidae")] <- "Gondwanatheria"

#remove unuseful columns
cols_to_drop <- c("occurrence_no","record_type","reid_no","flags","identified_name","identified_rank","identified_no","difference",
                  "accepted_no","reference_no","phylum","class","latlng_basis","latlng_precision","geogscale","geogcomments",
                  "enterer","modifier")
raw_2023 <- raw_2023[, !(names(raw_2023) %in% cols_to_drop)]
#solve Xenarthra issue: split Pilosa and Cingulata properely
Cingulata <- read.table("../../DATA/order_level/from_2020_2023_data_combination/Cingulata.txt", sep = "\t", header = TRUE, fill = TRUE, dec = ",")
Pilosa <- read.table("../../DATA/order_level/from_2020_2023_data_combination/Pilosa.txt", sep = "\t", header = TRUE, dec = ",")
raw_2023$order[which((raw_2023$genus %in% unique(Cingulata$Genus)) | (raw_2023$family %in% unique(Cingulata$Family)) )] <- "Cingulata"
raw_2023$order[which(raw_2023$family %in% c("Pampatheriidae", "Panochthidae"))] <- "Cingulata"
raw_2023$order[which(raw_2023$genus %in% c("Pseudoplohophorus", "Plohophorops", "Zaphilus", "Trachycalyptus", "Trachycalyptoides",
                                           "Urotherium", "Protoglyptodon", "Parahoplophorus", "Stromaphorus", "Phlyctaenopyga",
                                           "Stromaphorus", "Phlyctaenopyga", "Plohophoroides", "Stromaphoropsis"))] <- "Cingulata"
raw_2023$order[which((raw_2023$genus %in% unique(Pilosa$Genus)) | (raw_2023$family %in% unique(Pilosa$Family)) )] <- "Pilosa"
raw_2023$order[which(raw_2023$genus == "Anathitus")] <- "Pilosa"
#Solve Panameriungulata: extract Litopterna
Litopterna <- read.table("../../DATA/order_level/from_2020_2023_data_combination/Litopterna.txt", sep = "\t", header = TRUE, fill = TRUE, dec = ",")
raw_2023$order[which((raw_2023$genus %in% unique(Litopterna$Genus)) | (raw_2023$family %in% unique(Litopterna$Family)) )] <- "Litopterna"
raw_2023$order[which(raw_2023$genus == "Thoatheriopsis")] <- "Litopterna"
raw_2023$family[which(raw_2023$genus == "Thoatheriopsis")] <- "Proterotheriidae"
#set country abbreviation to its actual name
country_dict <- hash(keys = unique(raw_2023$cc)[order(unique(raw_2023$cc))],
                     values = c("Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Peru", "Paraguay", "Surinam", "Uruguay", "Venezuela"))
for(abbrev in keys(country_dict)){
  raw_2023$cc[which(raw_2023$cc == abbrev)] <- as.character(values(country_dict[abbrev]))
}
#write and save order-level lists
for(order in unique(raw_2023$order)){
  tmp_order <- raw_2023[which(raw_2023$order == order), ]
  #save order-level table
  write.table(x = tmp_order,
              file = paste0("E:/Internship_ISEM/Neotropical_Mammals/DATA/raw/order_level_txt/", order, ".txt"),
              sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              dec = ",")
}
