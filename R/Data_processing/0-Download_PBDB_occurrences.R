################################################################################
# Name: 0-Download_PBDB_occurrences.R
# Author: Lucas Buffan
# Date: 2023-12-11
# Aim: Download Cenozoic South American genus-level Mammalia occurrences (PBDB)
# Note: Raw dataset used in the study (downloaded on 11/2023) con be found here:
#      "./data_2023/SPECIES_LISTS/1-Raw_Cnz_SA_Mammals.csv"
################################################################################

pbdb_api = paste0("https://paleobiodb.org/data1.2/occs/list.csv",
                  "?base_name=Mammalia",
                  "&taxon_reso=genus&", #minimal taxonomic resolution
                  "max_ma=66", #restrict to Cenozoic
                  "&cc=SOA", #continent = South America
                  "&show=class,genus,ecospace,coords,loc,ref,crmod" #additional options: classification, genus, ecological stuffs, present-day coordinates, location (country,state,county), citation and creation/modification dates
)

download.file(url = pbdb_api,
              destfile = "./data_2023/SPECIES_LISTS/1-Raw_Cnz_SA_Mammals.csv")

