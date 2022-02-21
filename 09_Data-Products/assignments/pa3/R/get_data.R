## Load required packages
library(purrr);library(dplyr)

## download baby names data set from Social Security Administration's website
url1 <- "https://www.ssa.gov/oact/babynames/names.zip"
url2 <- "https://www.ssa.gov/oact/babynames/state/namesbystate.zip"
download.file(url1, "./data_inputs/names.zip")
download.file(url2,"./data_inputs/namesbystate.zip")

## unzip downloaded files
unzip("./data_inputs/names.zip", exdir = "./data_inputs/names")
unzip("./data_inputs/namesbystate.zip", exdir = "./data_inputs/namesbystate")

## import data of baby names
### import files at national level. Since the 'year' is not included as a
### variable but in the names of each file, we will need to do
### write a function to do the transformation during the importing process
import_names <- function(path, pattern){
        list_names <- list.files(path,
                                 pattern = pattern, recursive = TRUE,
                                 full.names = TRUE) %>%
                data.frame(FILE_PATH = ., stringsAsFactors = FALSE) %>%
                mutate(YEAR = gsub("[^0-9]", "", .$FILE_PATH))

        names <-data.frame()

        for (i in seq_along(list_names$FILE_PATH)) {
                names0 <- read.table(list_names$FILE_PATH[i],
                                     sep = ",",
                                     col.names = c("NAME", "GENDER", "COUNT"),
                                     stringsAsFactors = FALSE)
                names0$YEAR <- list_names$YEAR[i]
                names <- rbind(names, names0)
        }
        names
}

### import the files using the function
names <- import_names(path = "./data_inputs/names",
                      pattern = "txt") %>%
        mutate(GENDER = factor(GENDER), YEAR = as.numeric(YEAR)) %>%
        select(YEAR, NAME, GENDER, COUNT)

### import files at states level. This time since all variables are included
### we do not need to write a function to tranform the data
namesbystate <- map_df(list.files("./data_inputs/namesbystate",
                                  pattern = ".TXT",
                                  full.names = TRUE,
                                  recursive = TRUE),
                       read.table, sep = ",",
                       stringsAsFactors = FALSE,
                       col.names = c("STATE", "GENDER",
                                     "YEAR", "NAME", "COUNT"))


## save data sets
saveRDS(names,"./data_outputs/names.Rds")
saveRDS(namesbystate,"./data_outputs/namesbystate.Rds")

## save the data set that will be used to build the shiny app to the
## shiny app folder as well
saveRDS(names,"./shiny/names.Rds")

## clear the workspace
rm(list = ls())
