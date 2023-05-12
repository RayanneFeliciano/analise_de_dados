indicadores <- c(1, 2, 1, 3, 2, 3, 2, 1)
recode <- c(populoso = 1, povoado =2)
(indicadores <- factor(indicadores, levels = recode, labels = names(recode)))

(indicadores <- relevel(indicadores, ref = 'povoado'))

pib <- c(4, 2, 7, 5, 1, 1, 1, 2)
(indicadores <- reorder(indicadores, pib))

attr(indicadores, 'scores') <- NULL
indicadores
