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

## Taxonomic grouping dictionary -----------------------------------------------
tax_dict <- hash::hash("Notoungulata" = "Notoungulata",
                       "Rodentia" = "Rodentia",
                       "Xenarthra" = c("Cingulata", "Pilosa"),
                       "Other_SANUs" = c("Litopterna", "Xenungulata", "Pyrotheria", "Astrapotheria"),
                       "Metatheria" = c("Dasyuromorphia", "Microbiotheria", "Didelphimorphia",
                                        "Paucituberculata", "Polydolopimorphia", "Sparassodonta")
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