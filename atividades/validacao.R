library(data.table)
library(dplyr)
library(tidyverse)
install.packages('validate')
library(validate)

# carrega base de análise
global_poverty <- read.csv2("C:\\Users\\ray_a\\OneDrive\\Documentos\\analise_de_dados\\bases_originais\\pip_dataset.csv", sep = ',', encoding = 'UTF-8')

# criação de matriz, selecionando apenas algumas variáveis de interesse
global_poverty <- global_poverty %>% group_by(country) %>% select(country, year, survey_year, headcount_ratio_international_povline, headcount_ratio_lower_mid_income_povline, headcount_ratio_upper_mid_income_povline)

# criação de regras para validação
regras_global_poverty <- validator(headcount_ratio_international_povline >= 0, headcount_ratio_lower_mid_income_povline >=0, headcount_ratio_upper_mid_income_povline>=0)

# verificaçao se a base obedece as regras de validação
validacao_global_poverty <- confront(global_poverty, regras_global_poverty)

# retorna informações sobre a validação
summary(validacao_global_poverty)

# coloca em gráfico as características da base de acordo com a validação
plot(validacao_global_poverty)
