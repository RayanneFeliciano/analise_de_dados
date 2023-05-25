install.packages('VIM')
library(data.table)
library(funModeling)
library(tidyverse)
library(VIM)

# importa a base chorizonDL
data(chorizonDL, package = "VIM")

# observa a base
head(chorizonDL)

# verifica os tipos de dados - verificação de que são todos numéricos
status(chorizonDL)

# cria a matriz sombra
x <- as.data.frame(abs(is.na(chorizonDL)))

# observa a matriz sombra
head(x)

# mantém variáveis que possuem NA
y <- x[which(sapply(x, sd) > 0)]

# observa a correlação entre variáveis que possuem NA
cor(y)

# busca de padrões entre os valores específicos das variáveis e os NA
cor(chorizonDL, y, use = 'pairwise.complete.obs')
