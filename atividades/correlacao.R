## CORRELAÇÃO COM R ##
# PRIMEIRO, VAMOS CARREGAR OS PACOTES
pacman::p_load(corrplot, dplyr, ggplot2)

# TABELA DE CORRELAÇÃO COM TODAS AS VARIÁVEIS #
cor(mtcars)

# GRÁFICOS DE DISPERSÃO PAREADOS DAS VARIÁVEIS #
pairs(mtcars)

# CORRPLOT DAS VARIÁVEIS #
mtcarsCor <- cor(mtcars)
corrplot(mtcarsCor, method = "number", order = 'alphabet')
corrplot(mtcarsCor, order = 'alphabet') 
