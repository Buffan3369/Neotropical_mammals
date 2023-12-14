################################################################################
# Name: helper_functions.R
# Author: Lucas Buffan
# Date: 2023-12-13
# Aim: basic helper functions for less heavy codes
################################################################################

write.table.lucas <- function(...){
  write.table(sep = "\t",
              na = "",
              row.names = FALSE,
              quote = FALSE,
              ...)
}