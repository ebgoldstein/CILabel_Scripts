# Script for dealing with CILabel data dumps (json) in R... following:
# https://blog.exploratory.io/working-with-json-data-in-very-simple-way-ad7ebcc0bb89


#This seems more difficult to do in Pandas:
#https://stackoverflow.com/questions/53218931/how-to-unnest-explode-a-column-in-a-pandas-dataframe

library(tidyverse)
library(jsonlite)
library(tibble)

#load in the data and look at it

test <- fromJSON("~/Desktop/06-23-2020-dump.json")
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


Buxton <- untest %>%
  filter(catalogName == 'Buxton Coastal Camera') 

Labels <- Buxton$tags$collisionType

Buxton <- Buxton %>%
  select(catalogName, archiveName, image.fileName) %>%
  add_column(Labels) %>%
  group_by(catalogName, archiveName, image.fileName, Labels) %>%
  mutate(Count = n()) %>%
  distinct() %>%
  pivot_wider(names_from = Labels, values_from = Count)

write_csv(Buxton, 'Buxtondata.csv')