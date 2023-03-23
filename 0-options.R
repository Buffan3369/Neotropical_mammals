################################################################################
####################### Options script (file managing) #########################
################################################################################

params <- list(
  pbdb_api = paste0("https://paleobiodb.org/data1.2/occs/list.csv",
                    "?base_name=Mammalia", #what we want to downloads (here all Mammalia occurrences)
                    "&taxo_reso=genus", #taxonomic resolution, genus here
                    "&cc=SOA", #geographical place, here SOuth America, SOA
                    "&show=class,genus,loc,ref,entname,crmod" #additional things we want to get, here different taxonomic levels, sample geolocation, reference, enterer name and date
                    ),
  Islands = c("Puerto Rico",
               "Dominican Republic",
               "Cayman Islands",
               "Netherlands Antilles",
               "Jamaica",
               "Antigua and Barbuda",
               "Cuba",
               "Grenada"),
  North_american_localities = c("Mexico", 
                                "Belize", 
                                "Panama", 
                                "Costa Rica")
)
