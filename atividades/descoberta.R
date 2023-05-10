install.packages('funModeling')
library(funModeling)

install.packages('tidyverse')
library(tidyverse)

# olhada nos dados
glimpse(ChickWeight)

# verificar estrutura dos dados (quantos zeros, infinitos, casos únicos, etc)
status(ChickWeight)

# variáveis que são fatores e suas frequências
freq(ChickWeight)

# histograma das variáveis numéricas
plot_num(ChickWeight)

# estatísticas das variáveis numéricas
profiling_num(ChickWeight)
