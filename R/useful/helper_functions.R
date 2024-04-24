################################################################################
# Name: helper_functions.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: basic helper functions for less heavy codes
################################################################################

library(hash)

## Write text tables -----------------------------------------------------------
write.table.lucas <- function(...){
  write.table(sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              ...)
}

## Function to select the closest 'age_vect' element to the integer 'int_age' --------------------------------------
select_closer <- function(int_age, age_vect){
  diff <- sapply(X = age_vect, FUN = function(x){return(abs(x-int_age))})
  return(which.min(diff))
}

## Taxonomic grouping dictionary -----------------------------------------------
tax_dict <- hash::hash("Notoungulata" = "Notoungulata",
                       "Rodentia" = "Rodentia",
                       "Xenarthra" = c("Cingulata", "Pilosa"),
                       "Other_SANUs" = c("Litopterna", "Xenungulata", "Pyrotheria", "Astrapotheria", "SANU"), #SANU is used for members of the Didolodontidae family, unresolved affinity (but we know they're SANUs)
                       "Metatheria" = c("Dasyuromorphia", "Microbiotheria", "Didelphimorphia",
                                        "Paucituberculata", "Polydolopimorphia", "Sparassodonta",
                                        "Groeberida", "Basal_Marsupialia")
                       )

## Function to replace a space by an underscore --------------------------------
spc_to_udsc <- function(x){
  spl <- strsplit(x, split = " ")[[1]]
  if(length(spl) > 1){
    str <- spl[1]
    for(el in spl[-c(1)]){
      str <- paste(str, el, sep = "_")
    }
    return(str)
  }
  else{
    return(x)
  }
}

## Stackoverflow's function to enlarge pane ------------------------------------
enlarge_output_pane <- function(height. = 700, width. = 1300){
  
  # detect current output pane dimensions
  dim_px <- grDevices::dev.size("px")
  
  # if detected width is less than 'width.', widen output pane with RStudio's layoutZoomRightColumn command
  if(dim_px[1] < width.){ rstudioapi::executeCommand("layoutZoomRightColumn") }
  
  # if detected height is less than 'height.', switch to Viewer windom and set height
  if(dim_px[2] < height.){
    
    viewer <- getOption("viewer")
    viewer("http://localhost:8100", height = height.)
    
  }
}

## Function to assess Jaccard's similarity index based on two assemblages ------
jaccard <- function(a, b) {
  intersection = length(intersect(a, b))
  union = length(a) + length(b) - intersection
  return (intersection/union)
}

## Function to assess Bray-Curtis dissimilarity index between two assemblages --
bray_curtis <- function(a1, a2, round=FALSE, d=NULL){ #a1 and a2 should be two-columns dataframes, one for the taxon, the other for its abundance
  all_tax <- unique(c(a1[,1], a2[,1]))[[1]]
  minSum <- 0
  for(tax in all_tax){
    if(tax %in% a1[,1][[1]] & tax %in% a2[,1][[1]]){ # if not in either of the two assemblages, minSum will be added 0
      val_a1 <- a1[which(a1[,1] == tax),2]
      val_a2 <- a2[which(a2[,1] == tax),2]
      minSum <- minSum + min(val_a2, val_a1)
    }
  }
  BC <- 1 - (2*minSum) / (sum(a1[,2])+sum(a2[,2]))
  if(round){
    return(round(BC, digits = d))
  }
  else{
    return(BC)
  }
}

