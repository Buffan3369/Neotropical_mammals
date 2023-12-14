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
