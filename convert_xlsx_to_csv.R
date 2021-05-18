#!/usr/bin/env Rscript

library(readxl)
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

#### IMPORTANT #####

# Before running this script open the excel file and save as .xlsx 

# Script to take plate reader output and covert to long dataframe.

#df <- read_excel("~/Desktop/plate_reader_test/FB_Growth_assay_Zor+Ths.xlsx", sheet = "Photometric1")

df<-read_excel(args[1], sheet = "Photometric1")

write.csv(df, args[2], row.names = FALSE, quote = FALSE)





