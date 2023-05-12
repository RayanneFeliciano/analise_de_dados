library(readxl)

baseVendas <-  read_excel("C:\\Users\\ray_a\\OneDrive\\Documentos\\analise_de_dados\\bases_originais\\base_vendas_2022.xlsx", sheet = 1)

produtos <- read_excel('C:\\Users\\ray_a\\OneDrive\\Documentos\\analise_de_dados\\bases_originais\\cadastro_produtos.xlsx', sheet = 1)

produtos <- produtos %>% select(SKU, Produto)

produtosVendidos <- left_join(baseVendas, produtos, by = c('SKU' = 'SKU'))

view(produtosVendidos)
