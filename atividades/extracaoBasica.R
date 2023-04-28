install.packages('readxl')
library(readxl)

install.packages('rjson')
library(rjson)

install.packages('XML')
library(XML)

install.packages('readxl')
library(readxl)

#arquivo Json
avesRecife <- fromJSON(file = 'http://dados.recife.pe.gov.br/dataset/1ddcc3d1-a596-4416-bee8-7d38d45c12fa/resource/536a9a9f-7860-40db-9931-0b9374d174bf/download/arvoresfaunas_parquesepracas.geojson')

avesRecife <- as.data.frame(avesRecife)

#arquivo csv
nameGender <- read.csv2('https://archive.ics.uci.edu/ml/machine-learning-databases/00591/name_gender_dataset.csv', sep = ';', encoding = 'UTF-8')
nameGender

#arquivo txt
words <- read.table('https://archive.ics.uci.edu/ml/machine-learning-databases/bag-of-words/readme.txt', header = TRUE, sep = ',', dec = '.')
words
