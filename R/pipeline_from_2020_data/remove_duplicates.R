library(readxl)
library(hash)

sp_l <- read_xlsx("E:/Internship_ISEM/Neotropical_Mammals/species_list_with_duplicates.xlsx")
raw_2023 <- read.csv("./data_2023/Neotropical_Mammals_raw_2023.csv") 

## Match genus names between raw and cleaned dataset ---------------------------
  #out of time coverage
too_old <- which(raw_2023$min_ma >= 66)
raw_2023 <- raw_2023[-too_old, ]
  #with parenthesis
abs_in_spl <- unique(raw_2023$genus[which(raw_2023$genus %in% sp_l$Genus == FALSE)])
for(genus in abs_in_spl){
  idx <- which(raw_2023$genus == genus)
  rpcl <- strsplit(genus, split = " ")
  raw_2023$genus[idx] <- rpcl[[1]][1]
}
#remaining <- unique(raw_2023$genus[which(raw_2023$genus %in% sp_l$Genus == FALSE)])
  #remove genera introduced by or extinct because of humans
raw_2023 <- raw_2023[-which(raw_2023$genus %in% c("Lepus", "Neomonachus", "Mus", "Sus")),]
  #correct typos
dict_typo_corr <- hash(keys = c("Epieuryceros", "Bolomys", "Pithiculites", "Glossotheridium", "Plesioxotodon", "Hippidium"), #in raw dataset
                       values = c("Epieurycerus", "Necromys", "Pitheculites", "Glossotherium", "Plesiotoxodon", "Hippidion")) #corrected names
for(key in keys(dict_typo_corr)){
  raw_2023$genus[which(raw_2023$genus == key)] <- dict_typo_corr[[key]]
}

## Remove duplicates using raw dataset as a reference --------------------------
# Assess the number of times the elements of the "key" object appear in the "value" object
counter <- function(key, values){
  counter <- c()
  for(k in key){
    counter <- c(counter, length(which(values == k)))
  }
  return(counter)
}
# Return the indices of the duplicates in species_list
dpl_spl <- function(genus){
  collections_raw <- raw_2023$collection_no[which(raw_2023$genus == genus)]
  collections_spl <- sp_l$`Collection number`[which(sp_l$Genus == genus)]
  #counter
  key <- unique(collections_raw) #could have been `collections_spl`
  count_raw <- counter(key = key, values = collections_raw)
  count_spl <- counter(key = key, values = collections_spl)
  to_drop <- c() #list that will contain the indices of the sp_l rows to drop
  #target indices to erase
  for(idx in which(count_spl > count_raw)){
    coll_idx <- which((sp_l$Genus == genus) & (sp_l$`Collection number` == key[idx]))
    #second character of the associated ref (preferentially keep the one with pbdb ref, starting by "{X}." where X is a letter of the alphabet)
    sec_char_ref <- unlist(lapply(X = sp_l$Reference[coll_idx],
                                  FUN = function(x){return(strsplit(x, split = "")[[1]][2])}))
    tmp <- c() #temporary vector containing the indices of the duplicates WE WANT TO KEEP
    #If we do have duplicates including some with pbdb refs
    if("." %in% sec_char_ref){
      tmp <- c(tmp, coll_idx[which(sec_char_ref == ".")])
      #in case we have duplicates among the occurrences with refs
      if(length(tmp) > count_raw[idx]){
        i <- 1
        while(length(tmp) > count_raw[idx]){
          tmp <- tmp[-i]
          i <- i+1
        }
      }
      #in case we need to get rid of other duplicates
      else if(length(tmp) < count_raw[idx]){
        remaining_idx <- coll_idx[-which(coll_idx %in% tmp)]
        i <- 1
        while(length(tmp) < count_raw[idx]){
          tmp <- c(tmp, remaining_idx[i])
          i <- i+1
        }
      }
    }
    #We don't have pbdb refs among the duplicates : arbitrary fill tmp until we get the same number of occurrences belonging to the collection as in the raw dataset
    else{
      i <- 1
      while(length(tmp) < count_raw[idx]){
        tmp <- c(tmp, coll_idx[i])
        i <- i+1
      }
    }
    to_drop <- c(to_drop, coll_idx[-which(coll_idx %in% tmp)])
  }
  return(to_drop)
}
  #remove
to_drop <- unlist(lapply(X = unique(raw_2023$genus),
                         FUN = dpl_spl))

## Save results ----------------------------------------------------------------
write.csv(sp_l[-to_drop, ], "./data_2023/species_list_without_duplicates.csv", na = "", row.names = FALSE)

no_dup <- sp_l[-to_drop, ]

for(i in 1:nrow(no_dup)){
  if(no_dup$`Max age`[i] == no_dup$`Min age`[i]){
    no_dup$`Max age`[i] <- no_dup$`Max age`[i] + 0.0001
  }
}
binning <- bin_time(occdf = data.frame(max_ma = no_dup$`Max age`,
                                       min_ma = no_dup$`Min age`),
                    bins = Cnz,
                    method = "majority")
no_dup$Epoch <- unlist(lapply(X = binning$bin_assignment,
                                 FUN = function(x){return(Cnz$interval_name[which(Cnz$bin == x)])}))
no_dup$overlap_percentage <- binning$overlap_percentage
