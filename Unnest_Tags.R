# Script for dealing with CILabel data dumps (json) in R... following:
# https://blog.exploratory.io/working-with-json-data-in-very-simple-way-ad7ebcc0bb89


#This seems more difficult to do in Pandas:
#https://stackoverflow.com/questions/53218931/how-to-unnest-explode-a-column-in-a-pandas-dataframe



library(tidyverse)
library(jsonlite)
library(tibble)



#load in the data and look at it

test <- fromJSON("~/Desktop/untitled folder/06-21-2020-T-01-21-41_tags_export.json")
str(test)

#flatten it
tflat <- flatten(test)
str(tflat)

#make it a data frame
t_tbl <- as_data_frame(tflat)
t_tbl

#unnest it based on image.tags
untest <- unnest(t_tbl,image.tags)

# get df with only Catalog, Archive, filename, tags
