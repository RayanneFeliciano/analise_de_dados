install.packages('ade4')
install.packages('arules')
library(ade4)
library(arules)
library(forcats)

# carrega base de análise
wine_quality <- read.csv2("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", sep = ';', encoding = 'UTF-8')

# verifica a estrutura
str(wine_quality)

# converte elementos em fatores
for(i in 1:9 ) {
  wine_quality[,i] <- as.factor(wine_quality[,i])
}

# checagem após a conversão
str(wine_quality)

# filtragem dos dados que são fatores

factor_wine_quality <- unlist(lapply(wine_quality, is.factor))
wine_quality_factor <- wine_quality[ , factor_wine_quality]
str(wine_quality_factor)

# One Hot Enconding: conversão de fatores em variáveis binárias
wine_quality_binary <- acm.disjonctif(wine_quality_factor)

#visualização da base pós One Hot Enconding
View(wine_quality_binary)

# viscretização: aplicar categorias para os dados que são integer
wine_quality$quality <- discretize(wine_quality$quality, method = 'interval', breaks = 3, labels = c('baixa', 'média', 'alta'))

# verificação da base que teve coluna com dados integer agora categorizada
View(wine_quality)

# contagem dos fatores
fct_count(wine_quality_factor$residual.sugar)

# anonimização dos fatores
fct_anon(wine_quality_factor$residual.sugar)

# reclassificação dos fatores em mais comuns e outros

fct_lump(wine_quality_factor$residual.sugar, n = 2)
