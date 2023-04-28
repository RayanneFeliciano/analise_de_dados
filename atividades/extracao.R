pacman::p_load(dplyr)

# bases de sinistros de transito do site da PCR
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

# juntando as bases de dados com comando rbind
colunas_iguais <- names(sinistrosRecife2020Raw[intersect(names(sinistrosRecife2020Raw), names(sinistrosRecife2021Raw))])
sinistrosRecife2020Raw <- sinistrosRecife2020Raw %>% select(all_of(colunas_iguais))

colunas_iguais2 <- names(sinistrosRecife2019Raw[intersect(names(colunas_iguais), names(sinistrosRecife2019Raw))])
sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% select(all_of(colunas_iguais2))

sinistrosRecifeRaw <- rbind(sinistrosRecife2019Raw, sinistrosRecife2020Raw, sinistrosRecife2021Raw, sinistrosRecife2019Raw)

# modificação da natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)

# modificação do bairro_cruzamento de texto para fator
sinistrosRecifeRaw$bairro_cruzamento <- as.factor(sinistrosRecifeRaw$bairro_cruzamento)

#modificação do formato da data
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw, format ('%Y-%m-%d')

#substituição de NA por 0

nazero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

sinistrosRecifeRaw[,15:25] <- sapply(sinistrosRecifeRaw[,15:25], nazero)

#listagem dos itens intermediários

ls()

#verificação do tamando dos itens intermediários
for (itm in ls()) {
  print(formatC(c(itm, object.size(get(itm))),
                format="d",
                width=30),
        quote=F)
}

#remoção dos itens intermediários que não são de interesse manter
rm(list = c('sinistrosRecife2019Raw', 'sinistrosRecife2020Raw','itm'
            'sinistrosRecife2021Raw', 'colunas_iguais', 'colunas_iguais2'))

#listagem final para verificar se ficaram os itens de interesse
ls()

#exportando no formato do R
saveRDS(sinistrosRecifeRaw, 'C:/Users/ray_a/OneDrive/Documentos/analise_de_dados/bases_tratadas/Sinistros Recife.rds')

#exportando no padrão interoperabilidade
write.csv2(sinistrosRecifeRaw, 'C:\\Users\\ray_a\\OneDrive\\Documentos\\analise_de_dados\\bases_tratadas\\Sinistros Recife.csv')

