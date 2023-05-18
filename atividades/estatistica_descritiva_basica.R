# carrega base
wine_quality <- read.csv2("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", sep = ';', encoding = 'UTF-8')

## tabela de frequência absoluta
table(wine_quality$quality)

## tabela de frequência relativa
prop.table(table(wine_quality$quality))

## Medidas de tendência central

# média da variável quality
mean(wine_quality$quality)

# mediana da variável quality
median(wine_quality$quality)

## separatrizes
quantile(wine_quality$quality, probs = 0.75)
quantile(wine_quality$quality, probs = 0.10)
quantile(wine_quality$quality, probs = 0.95)

# desvio padrão da variável quality
sd(wine_quality$quality)

# sumário básico das variáveis
summary(wine_quality)

#sumário descritivo completo usando o pacote fBasics
pacman::p_load(fBasics)
basicStats(wine_quality[ , 12])

