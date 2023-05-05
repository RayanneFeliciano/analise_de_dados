library(dplyr)

#carregando base de dados inicial
preçosCombustiveisInicial <- read.csv2("https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/arquivos/shpc/dsan/2023/precos-gasolina-etanol-03.csv",sep = ';', encoding = 'UTF-8')

preçosCombustiveisInicial <- preçosCombustiveisInicial [c(-2:-10),]

View(preçosCombustiveisInicial)

#carregando base de dados final

preçosCombustiveisFinal <- read.csv2("https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/arquivos/shpc/dsan/2023/precos-gasolina-etanol-03.csv",sep = ';', encoding = 'UTF-8')

#comparação entre as bases usando chave substituta
preçosCombustiveisInicial$chavesubstituta = apply(preçosCombustiveisInicial[ ,c(4,12)], MARGIN = 1, FUN = function(i) paste(i, collapse = ''))

preçosCombustiveisFinal$chavesubstituta = apply(preçosCombustiveisFinal[,c(4,12)], MARGIN = 1, FUN = function(i) paste(i, collapse = ''))

View(preçosCombustiveisFinal)
View(preçosCombustiveisInicial)

#base de comparação
preçosCombustiveisIncremental <- (!preçosCombustiveisFinal$chavesubstituta %in% preçosCombustiveisInicial$chavesubstituta)

preçosCombustiveisInicial[preçosCombustiveisIncremental,]

preçosCombustiveisCompleta <- rbind(preçosCombustiveisInicial, preçosCombustiveisInicial[preçosCombustiveisIncremental,])
