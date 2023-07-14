#### PREPARAÇÃO #####
### CARREGANDO PACOTES ###
pacman::p_load(ade4, car, caret, corrplot, dplyr, EnvStats, gvlma, jtools, lm.beta, lmtest, MASS, Metrics, performance, sandwich, simpleboot, SmartEDA, sjPlot, stargazer, broom.mixed)

### ETL ###
# leitura da base de dados
regrOriginal <- read.csv2('https://raw.githubusercontent.com/RayanneFeliciano/analise_de_dados/master/bases_originais/dados.csv', sep = ',', stringsAsFactors = T, encoding = 'UTF-8') # carregando a base já tratada para o ambiente do R
View(regrOriginal)

# verificação da base e da sua estrutura
summary(regrOriginal)
str(regrOriginal)

# transformação das variáveis que estão como fator em numérica
regrOriginal$pib_capita <- as.numeric(regrOriginal$pib_capita)
regrOriginal$milit_expend <- as.numeric(regrOriginal$milit_expend)

##### MODELAGEM #####
### criação dos três modelo iniciais, usando step ###
regrOriginalBack <- step(lm(pib_capita ~ ., data = regrOriginal), direction = "backward")
regrOriginalForw <- step(lm(pib_capita ~ ., data = regrOriginal), direction = "forward")
regrOriginalBoth <- step(lm(pib_capita ~ ., data = regrOriginal), direction = "both")

# Verificação das regressões
summary(regrOriginalBack)
summary(regrOriginalForw)
summary(regrOriginalBoth)

# regrOriginalForw possui uma coluna que ficou sem coeficientes definidos na regressão: Retirada dessa variável
regrOriginalForw <- step(lm(pib_capita ~ ano + milit_expend + arms_indus + arms_imp + arms_exp + milit_staff, data = regrOriginal), direction = "forward")
summary(regrOriginalForw)

# obtenção dos coeficientes padronizados
lm.beta(regrOriginalBoth)

### comparação dos modelos ###
# Sumários
stargazer(regrOriginalBack, regrOriginalForw, regrOriginalBoth, type="text", object.names = TRUE, title="Defesa e Crescimento Economico", single.row=TRUE)
plot_summs(regrOriginalBack, regrOriginalForw, regrOriginalBoth, model.names = c("Backward", "Forward", "Both"))

# obtenção do IC 95% para os coeficientes
confint(regrOriginalBack)
confint(regrOriginalForw)
confint(regrOriginalBoth)

# Performance
test_performance(regrOriginalBack, regrOriginalForw, regrOriginalBoth)
compare_performance(regrOriginalBack, regrOriginalForw, regrOriginalBoth, rank = TRUE, verbose = FALSE)
plot(compare_performance(regrOriginalBack, regrOriginalForw, regrOriginalBoth, rank = TRUE, verbose = FALSE))

### Diagnóstico ###
# checagem geral #
check_model(regrOriginalBoth)
par(mfrow = c(2,2))
plot(regrOriginalBoth, which = c(1:4), pch = 20)

# testes unitários #
shapiro.test(residuals(regrOriginalBoth))
check_heteroscedasticity(regrOriginalBoth)
check_collinearity(regrOriginalBoth)

# outliers #
check_outliers(regrOriginalBoth)
influencePlot(regrOriginalBoth, id.method="identify", main="Observações Influentes", sub="Círculo proporcional à distância de Cook")
residualPlots(regrOriginalBoth)

## Remodelagem 1: raíz quadrada ##
regrOriginal$milit_staff <- sqrt(regrOriginal$milit_staff)

regrOriginalBoth2 <- step(lm(pib_capita ~ arms_indus + ano + milit_expend + milit_staff, data = regrOriginal), direction = "both")
summary(regrOriginalBoth2)

par(ask = FALSE)
check_model(regrOriginalBoth2)
check_outliers(regrOriginalBoth2)
residualPlots(regrOriginalBoth2)
par(mfrow = c(2,2))
plot(regrOriginalBoth2, which = c(1:4), pch = 20)

### Remodelagem 2: elevar ao quadrado ###
regrOriginal$milit_staff <- scale(regrOriginal$milit_staff) 
regrOriginal$milit_staff <- regrOriginal$milit_staff^2
regrOriginal$milit_staff

regrOriginalBoth3 <- step(lm(pib_capita ~ arms_indus + ano + milit_expend + milit_staff, data = regrOriginal), direction = "both")
summary(regrOriginalBoth3)

par(ask = FALSE)
check_model(regrOriginalBoth3)
check_outliers(regrOriginalBoth3)
residualPlots(regrOriginalBoth3)
par(mfrow = c(2,2))
plot(regrOriginalBoth3, which = c(1:4), pch = 20)

# homocedasticidade - Teste Breusch-Pagan
library(lmtest)
bptest(regrOriginalBoth)

# ausência de autocorrelação dos resíduos: Teste Durbin-watson
dwtest(regrOriginalBoth3)
durbinWatsonTest(regrOriginalBoth3)

