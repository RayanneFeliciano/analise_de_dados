# imputação de valores em outliers ou missing
pacman::p_load(data.table, Hmisc, VIM) # carrega pacotes

## imputação numérica
data(food, package = 'VIM')
status(food)
view(food)

baseOriginal <- copy(food)

# tendência central
(baseOriginal$Sweetener <- impute(baseOriginal$Sweetener, fun = mean))

# teste se o valor foi imputado
is.imputed(baseOriginal$Sweetener)

#tabela de imputação por sim/não
table(is.imputed(baseOriginal$Sweetener))

## Hot deck

# Volta para a base original que possui NA
baseOriginal <- copy(food)

# imputação por instâncias/semelhanças
(baseImputada <- kNN(baseOriginal))
