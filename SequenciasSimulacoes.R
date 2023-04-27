#colocação da set.seed de modo fixo
taskSeed <- addTaskCallback(function(...) {set.seed(159);TRUE})
taskSeed

#variável normal
distNormal <- rnorm(12)
distNormal

#variável binominal
distbinominal <- rbinom(12, 1, 0.7)
distbinominal

#atribuição para os dados usando a repetição
repetir <- c(rep("Estudos", length(distbinominal)/3), rep("Academia", length (distbinominal)/3), rep("Lazer", length (distbinominal)/3))
repetir

#indexação dos itens
index <- seq(1, length(distNormal))
index

removeTaskCallback(taskSeed)
