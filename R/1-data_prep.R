#Bibliotekos
library(tidyverse)
library(jsonlite)
library(dplyr)

cat("Darbinė direktorija:", getwd())

#Failo paruosimas
download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.json.zip", "../data/temp")
unzip("../data/temp",  exdir = "../data/")
readLines("../data/monthly-2023.json", 20)


data = fromJSON("../data/monthly-2023.json")

#Filtravimas
data %>%
  filter(ecoActCode== 620000) %>%
  saveRDS('../data/620000.rds')

#Nereikalingu failu pasalinimas
file.remove("../data/temp")
file.remove("../data/monthly-2023.json")
