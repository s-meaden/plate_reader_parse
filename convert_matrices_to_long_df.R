#!/usr/bin/env Rscript

library(dplyr)

# Take csv of matrices and convert to ling format.

args = commandArgs(trailingOnly=TRUE)

df<-read.csv(args[1], header = T)
#df<-read.table("~/Dropbox/MC_fellowship/MCF/SS/structure_altr_proj/student_project/septu_project/wurz_strains/wurz_strain_check_matrices.csv",
#              header = T)


# Get rid of random stuff
keeps<-c('Value', 'X1', 'X2', 'X3', 'X3', 'X4', 'X5', 'X6',
         'X7', 'X8', 'X9', 'X10', 'X11', 'X12')

# Get rid of grep matches:
head(df, n = 13)

df<-df %>%
  select(., keeps) %>%
  mutate(., drop = ifelse(Value == "Value", "YES", "NO")) %>%
  filter(., drop == "NO") %>%
  select( -drop)

# Melt data into long format

n = 8 #because 8 rows in a 96 well plate

df<-df %>%
  mutate(., time = rep(1:101, each=n)) %>%   # 101 is number of readings taken during a 20hr growth curve. May need to change?
  reshape2::melt(., id.vars = c('Value', 'time')) %>%
  mutate(., well = paste(Value, gsub("X", "", variable), sep = "")) %>%
  select(- variable, Value) %>%
  mutate(., well = gsub(" ", "", well))

head(df)

## Write output into new file:
write.csv(df, args[2], row.names = FALSE, quote = FALSE)




