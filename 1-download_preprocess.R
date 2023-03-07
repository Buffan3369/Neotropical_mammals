#####################################################################
############ Script for data accession and preparation ##############
#####################################################################

library(reticulate)
library(palaeoverse)
library(readxl)

#amahuacatherium peruvium = flan

## Download all south american genus-level Mammalia occurrences from pdbd -----------------------
  #highly detailed dataset => 3,394 occurrences (?!)
download.file(url = "https://paleobiodb.org/data1.2/occs/list.tsv?datainfo&rowcount&base_name=Mammalia&taxon_reso=genus&cc=SOA&show=attr,class,classext,genus,subgenus,taphonomy,coll,coords,loc,stratext,resgroup,ref,refattr,ent",
 destfile = "./data_2023/Neotropical_Mammals_raw_maxi_2023.tsv")
  #more minimalistic one (less features) => 9,750 occurrences
download.file(url = "https://paleobiodb.org/data1.2/occs/list.tsv?datainfo&rowcount&base_name=Mammalia&taxon_reso=genus&cc=SOA",
              destfile = "./data_2023/Neotropical_Mammals_raw_mini_2023.tsv")

## Get rid of of metadata by sourcing a simple python script (watch working directory) ----------
reticulate::source_python("unhead_maxi.py") #maximalistic one
reticulate::source_python("unhead_mini.py") #minimalistic one

## Open the old and new datasets ----------------------------------------------------------------
data_2020 <- readxl::read_xlsx("./data_2020/Mammalia.xlsx") 
data_2023_maxi <- read.table("./data_2023/Neotropical_Mammals_unheaded_maxi_2023.tsv", header = TRUE, sep = '\t', fill = TRUE) #ignore warning
data_2023_mini <- read.table("./data_2023/Neotropical_Mammals_unheaded_mini_2023.tsv", header = TRUE, sep = '\t', fill = TRUE) #ignore warning

## Create a "genus" column in the minimalistic dataset ------------------------------------------
get_genus <- function(x){
  tot_name <- data_2023_mini$accepted_name[x]
  return(unlist(strsplit(tot_name, split = " "))[1])
}
data_2023_mini$genus <- unlist(lapply(X = 1:nrow(data_2023_mini), FUN = get_genus))

## Identify common occurrences between both -----------------------------------------------------
find_redundancy <- function(index, ds){ #function returning duplicate indices between 2023 and 2020 datasets
  return(
    which( (ds[, c('collection_no')] == data_2020$`Collection number`[index]) & 
            (ds[, c('min_ma')] == data_2020$`Min age`[index]) & 
            (ds[, c('max_ma')] == data_2020$`Max age`[index]) & 
            (ds[, c('genus')] == data_2020$Genus[index]) )
                )
}
redundant_indices_maxi <- unique(lapply(X = 1:nrow(data_2020), FUN = find_redundancy, ds = data_2023_maxi))
redundant_indices_mini <- unique(lapply(X = 1:nrow(data_2020), FUN = find_redundancy, ds = data_2023_mini))


