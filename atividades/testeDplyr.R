library(dplyr)
library(readxl)

preçosCombustiveis <- read.csv2("https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/arquivos/shpc/dsan/2023/precos-gasolina-etanol-03.csv",sep = ';', encoding = 'UTF-8')

# sumários
count(preçosCombustiveis, Produto)

# sumários com agrupamentos
preçosCombustiveis %>% group_by(Produto) %>% summarise(avg = mean(Valor.de.Venda))

## realização da transformação de casos

# seleção de casos
preçosCombustiveis %>% filter(Estado...Sigla == 'PE') %>% summarise(avg = mean(Valor.de.Venda))
preçosCombustiveis %>% filter(Estado...Sigla == 'PE') %>% group_by(Produto) %>%  summarise(avg = mean(Valor.de.Venda))

# ordenar casos
arrange(preçosCombustiveis, Valor.de.Venda)
arrange(preçosCombustiveis, desc(Valor.de.Venda))


### realização de transformação de variáveis

# seleção de colunas
preçosCombustiveis %>% select(Municipio, Produto, Data.da.Coleta, Valor.de.Venda) %>% arrange(desc(Valor.de.Venda))

# novas colunas
preçosCombustiveis %>% mutate(variacaoPrecoMedio = Valor.de.Venda-mean(Valor.de.Venda))

# renomear
preçosCombustiveis %>% rename(Estado = Estado...Sigla)


