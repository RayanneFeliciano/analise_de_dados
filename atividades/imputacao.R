# imputação de valores em outliers ou missing
pacman::p_load(data.table, Hmisc, VIM) # carrega pacotes

## imputação numérica
data(food, package = 'VIM')
status(food)
view(food)

BaseOriginal <- copy(food)

# tendência central
(BaseOriginal$Sweetener <- impute(BaseOriginal$Sweetener, fun = mean))

# teste se o valor foi imputado
is.imputed(BaseOriginal$Sweetener)

#tabela de imputação por sim/não
table(is.imputed(BaseOriginal$Sweetener))

## Hot deck

# Volta para a base original que possui NA
BaseOriginal <- copy(food)

# imputação por instâncias/semelhanças
(BaseImputada <- kNN(BaseOriginal))
