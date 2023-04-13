library(readxl)
library(tibble)

setwd("E:/Internship_ISEM/Neotropical_Mammals/DATA/raw_order_level")
semi_not <- read_xlsx("semi_Not.xlsx")
#correct Deseadan
deseadan <- which((semi_not$min_ma == 21) & (semi_not$max_ma == 29))
semi_not$min_ma[deseadan] <- 23.03
semi_not$max_ma[deseadan] <- 30
#correct mustersan
mustersan <- which(semi_not$early_interval == "Mustersan")
semi_not$min_ma[mustersan] <- 36
semi_not$max_ma[mustersan] <- 38
#create species column
get_taxo <- function(x){ #function to return vector of species of semi_not
  tot_name <- semi_not$accepted_name[x]
  return(unlist(strsplit(tot_name, split = " "))[2])
}
semi_not$Species <- unlist(lapply(X = 1:nrow(semi_not), FUN = get_taxo))
#Merge early and late interval columns
late_int_NE <- which(is.na(semi_not$late_interval) == FALSE)
for(i in late_int_NE){
  semi_not$early_interval[i] <- paste0(semi_not$early_interval[i], "-", semi_not$late_interval[i])
}
#Bin time
binning <- bin_time(occdf = data.frame(max_ma = semi_not$max_ma,
                                       min_ma = semi_not$min_ma),
                    bins = Cnz,
                    method = "majority")
semi_not$Epoch <- unlist(lapply(X = binning$bin_assignment,
                                 FUN = function(x){return(Cnz$interval_name[which(Cnz$bin == x)])}))
semi_not$overlap_percentage <- binning$overlap_percentage
add_period <- function(x){
  if(semi_not$Epoch[x] %in% c("Holocene", "Pleistocene")){
    return("Quaternary")
  }
  else if(semi_not$Epoch[x] %in% c("Pliocene", "Miocene")){
    return("Neogene")
  }
  else{
    return("Paleogene")
  }
}
semi_not$Period <- unlist(lapply(X = 1:nrow(semi_not),
                                 FUN = add_period))
#add remaining columns
semi_not$Status <- "extinct"
semi_not$Formation <- NA
semi_not$Note <- NA
semi_not <- semi_not[, -c(4, 9, 15, 16)]
country_dict <- hash(keys = unique(semi_not$cc),
                     values = c("Argentina", "Chile", "Bolivia", "Uruguay", "Peru", "Colombia", "Brazil","Venezuela", "Paraguay"))
for(abbrev in keys(country_dict)){
  semi_not$cc[which(semi_not$cc == abbrev)] <- as.character(values(country_dict[abbrev]))
}
#reorder columns
right_order <- c("order", "family", "genus", "Species", "Status", "cc", "state", "county", "Formation", "Period", "Epoch",
                 "early_interval", "overlap_percentage", "min_ma", "max_ma", "collection_no", "authorizer", "primary_reference", "Note")
semi_not <- semi_not[, right_order]
#save
write.table(semi_not, file = "semi_not.tsv", sep = "\t", dec = ",", quote = FALSE, na = "")
