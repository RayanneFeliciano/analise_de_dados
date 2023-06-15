### CARREGAR PACOTES
pacman::p_load(ccaPP, lsa, minerva, Rfast)

### CRIAR FUNÇÃO PARA RODAR VÁRIAS ASSOCIAÇÕES
multi.cor <- function(x, y) {
  c(
    cor = cor(x, y), # Correlação
    dcor = dcor(x, y), # Distance correlation
    cosine = cosine(x, y), # Distância do Cosseno 
    maxCor = maxCorProj(x, y), # Maximal correlation
    MIC = mine (x, y) #  Maximal Information Coefficient
  )
}

### EXEMPLO 1 LINEAR
x <- iris$Sepal.Length
y <- iris$Sepal.Width - 1.7*x

plot(x, y) # Plotar o gráfico

corList <- multi.cor(x, y)
names(corList)
corList <- corList[c(1,5,6,7, 15)]
corList


### EXEMPLO 1.1 LINEAR 
y1 <- y - runif(150, 4.3, 6) ## 150 = Número de casos na base iris; 4.3 = valor mínimo do sepal.length; 6 = valor um pouco abaixo do máximo encontrado na coluna sepal.length que é de 7.9 
plot(x, y1)

corList1 <- multi.cor(x, y1)
corList1 <- corList1[c(1,5,6,7, 15)]
corList1

### EXEMPLO 1.2 LINEAR
y2 <- y - runif(150, 4.3, 7) ## 150 = Número de casos na base iris; 4.3 = valor mínimo do sepal.length; 6 = valor um pouco abaixo do máximo encontrado na coluna sepal.length que é de 7.9

plot(x, y2)

corList2 <- multi.cor(x, y2)
corList2 <- corList2[c(1,5,6,7, 15)]
corList2

### EXEMPLO 2 QUADRÁTICA
k <- iris$Sepal.Length
l <- iris$Sepal.Width - 1.7*k + k^2

plot(k, l)

corList <- multi.cor(k, l)
corList <- corList[c(1,5,6,7, 15)]
corList

### EXEMPLO 2.1 QUADRÁTICA
l1 <- l - runif(150, 5.3, 6)

plot(k, l1)

corList3 <- multi.cor(k, l1)
corList3 <- corList3[c(1,5,6,7, 15)]
corList3

### EXEMPLO 2.2 QUADRÁTICA
l2 <- l - runif(150, 4.3, 7)

plot(k, l2)

corList4 <- multi.cor(k, l2)
corList4 <- corList4[c(1,5,6,7, 15)]
corList4
