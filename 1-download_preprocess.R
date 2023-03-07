#####################################################################
######### Script for data preparation towards PyRate input ##########
#####################################################################

library(reticulate)
library(palaeoverse)
library(readxl)

#amahuacatherium peruvium = flan

## Download all south american genus-level Mammalia occurrences from pdbd -----------------------
download.file(url = "https://paleobiodb.org/data1.2/occs/list.tsv?datainfo&rowcount&base_name=Mammalia&taxon_reso=genus&cc=SOA&show=attr,class,classext,genus,subgenus,taphonomy,coll,coords,loc,stratext,resgroup,ref,refattr,ent",
 destfile = "./data_2023/Neotropical_Mammals_raw_2023.tsv")
## Get rid of of metadata by sourcing a simple python script ------------------------------------
reticulate::source_python("unhead.py")
## Open the old and new datasets ----------------------------------------------------------------
setwd("..")
data_2020 <- readxl::read_xlsx("./data_2020/Mammalia.xlsx") 
data_2023 <- read.table("./data_2023/Neotropical_Mammals_2023_unheaded.tsv", header = TRUE, sep = '\t', fill = TRUE)
## Identify common occurrences between both -----------------------------------------------------