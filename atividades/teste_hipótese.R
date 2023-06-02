pacman::p_load(data.table)

# carrega a base
load("C:/Users/ray_a/Downloads/Latinobarometro_2020_Esp_Rdata_v1_0.rdata")

# relação qui-quadrado para verificar a associação entre situação financeira e apoio à democracia
chisq.test(Latinobarometro_2020_Esp$p8st.a, Latinobarometro_2020_Esp$p10stgbs)
# variáveis são dependentes / há associação. p-valor (p-value) <= 0.05

