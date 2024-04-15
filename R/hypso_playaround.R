library(tidyverse)
library(readxl)

## Data from Solórzano & Nuñez (2021) ------------------------------------------
data_traits <- read_xlsx("./data_2023/Noto_hypso/Solorzano_Nunez_2021_SuppTable_Hypso_BM.xltx")
data_traits <- data_traits %>% arrange(Suborder, Family, Genus)
# Fix typos
data_traits <- data_traits %>% mutate(Hypsodonty = sapply(X = `Hypsodonty values`, FUN = function(x){
  if(is.na(x)){
    return(NA)
  }
  else if(x == 0){
    return("Brachydont")
  }
  else if(x == 1){
    return("Mesodont")
  }
  else if(x == 2){
    return("Hypsodont")
  }
  else if(x == 3){
    return("Hypselodont")
  }
}))

spl <- readRDS("./data_2023/SPECIES_LISTS/7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS")
n <- spl %>% filter(order == "Notoungulata")

our_species <- unique(n$accepted_name)
target <- unlist(sapply(X = 1:length(our_species), FUN = function(x){
  spl <- strsplit(our_species[x], split = "_")[[1]]
  if(length(spl) == 1){
    return(x)
  }
}))

our_species <- our_species[-target]
our_species <- sapply(X = our_species, FUN = function(x){
  spl <- strsplit(x, split = "_")[[1]]
  return(paste0(spl[1], " ", spl[2]))
})

tar_sp <- data_traits$Species
abs <- which(tar_sp %in% our_species == FALSE)
data_traits1 <- data_traits %>% filter(Species %in% tar_sp[abs] == FALSE)

abs1<-which(our_species %in% tar_sp == FALSE)





source("./R/useful/helper_functions.R")



par(mfrow = c(1,2))
plot(x = p_open$Age, y = p_open$P_open, type = "l", xlim = rev(range(p_open$Age)))

plot(x = rLAI$Age, y = rLAI$rLAI, type = "l", xlim = rev(range(rLAI$Age)))


