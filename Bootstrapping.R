distNormalSimulacao <- rnorm(150)
distNormalSimulacao

#Amostragem com 30 elementos da base criada acima e sem repetição
sample(distNormalSimulacao, 10, FALSE)


#Aplicação do bootstraping
set.seed(321)

bootDistNormal <- replicate(10, sample(distNormalSimulacao,10, TRUE))
bootDistNormal

#Bootstraping e estatística
mediaBootsNormal10 <- replicate(10, mean(sample(distNormalSimulacao, 10, TRUE)))
mediaBootsNormal50 <- replicate(50, mean(sample(distNormalSimulacao, 10, TRUE)))
mediaBootsNormal100 <- replicate(100, mean(sample(distNormalSimulacao, 10, TRUE)))
mediaBootsNormal150 <- replicate(150, mean(sample(distNormalSimulacao, 10, TRUE)))

mean(mediaBootsNormal10)
mean(mediaBootsNormal50)
mean(mediaBootsNormal100)
mean(mediaBootsNormal150)
mean(distNormalSimulacao)

