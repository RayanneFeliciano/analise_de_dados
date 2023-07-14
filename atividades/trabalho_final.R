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
regrOriginalBack <- step(lm(pib_capita ~ . -ano, data = regrOriginal), direction = "backward")
regrOriginalForw <- step(lm(pib_capita ~ . -ano, data = regrOriginal), direction = "forward")
regrOriginalBoth <- step(lm(pib_capita ~ . -ano, data = regrOriginal), direction = "both")

# Verificação das regressões
summary(regrOriginalBack)
summary(regrOriginalForw)
summary(regrOriginalBoth)

# regrOriginalForw possui uma coluna que ficou sem coeficientes definidos na regressão: Retirada dessa variável
regrOriginalForw <- step(lm(pib_capita ~ milit_expend + arms_indus + arms_imp + arms_exp + milit_staff, data = regrOriginal), direction = "forward")
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

# homocedasticidade - Teste Breusch-Pagan
library(lmtest)
bptest(regrOriginalBoth)

# ausência de autocorrelação dos resíduos: Teste Durbin-watson
dwtest(regrOriginalBoth)

# outliers #
check_outliers(regrOriginalBoth)
influencePlot(regrOriginalBoth, id.method="identify", main="Observações Influentes", sub="Círculo proporcional à distância de Cook")
residualPlots(regrOriginalBoth)

### Remodelagem 1: raíz quadrada e exclusão de variável ###
regrOriginal$milit_staff <- sqrt(regrOriginal$milit_staff)
regrOriginal <- regrOriginal %>% dplyr::select(-c(milit_staff))

regrOriginalBoth2 <- step(lm(pib_capita ~ arms_indus, data = regrOriginal), direction = "both")
summary(regrOriginalBoth2)

par(ask = FALSE)
check_model(regrOriginalBoth2)
check_outliers(regrOriginalBoth2)
residualPlots(regrOriginalBoth2)
par(mfrow = c(2,2))
plot(regrOriginalBoth2, which = c(1:4), pch = 20)

# Remodelagem 2: BoxCox #
regrOriginalBoxCox <- EnvStats::boxcox(regrOriginalBoth2, optimize = T)

par(mfrow=c(1,2), ask = FALSE)
qqnorm(resid(regrOriginalBoth2))
qqline(resid(regrOriginalBoth2))
plot(regrOriginalBoxCox, plot.type = "Q-Q Plots", main = 'Normal Q-Q Plot')
par(mfrow=c(1,1), ask = FALSE)

lambda <- regrOriginalBoxCox$lambda
lambda

regrOriginalBoxCox <- step(lm((pib_capita^lambda-1)/lambda ~ arms_indus, data = regrOriginal), direction = "both")

check_model(regrOriginalBoxCox)

## checagem diante do novo modelo ##
# testes unitários #
shapiro.test(residuals(regrOriginalBoth2))

# Demais pressupostos
check_heteroscedasticity(regrOriginalBoth2)
check_collinearity(regrOriginalBoth2)

# homocedasticidade - Teste Breusch-Pagan
library(lmtest)
bptest(regrOriginalBoth2)

# ausência de autocorrelação dos resíduos: Teste Durbin-watson
dwtest(regrOriginalBoth2)
durbinWatsonTest(regrOriginalBoth2)

Summary(regrOriginalBoth2)




