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
regrOriginal$PIB.per.capita <- as.numeric(regrOriginal$PIB.per.capita)
regrOriginal$Military.expenditure <- as.numeric(regrOriginal$Military.expenditure)

# modificação do nome de algumas colunas
colnames(regrOriginal)[2:8] <- c('milit_expend', 'coop_def', "arms_indus", 'arms_imp', "arms_exp", 'pib_capta', 'milit_staff')

##### MODELAGEM #####
### criação dos três modelo iniciais, usando step ###
regrOriginalBack <- step(lm(pib_capta ~ . -Ano, data = regrOriginal), direction = "backward")
regrOriginalForw <- step(lm(pib_capta ~ . -Ano, data = regrOriginal), direction = "forward")
regrOriginalBoth <- step(lm(pib_capta ~ . -Ano, data = regrOriginal), direction = "both")

# Verificação das regressões
summary(regrOriginalBack)
summary(regrOriginalForw)
summary(regrOriginalBoth)

# regrOriginalForw possui uma coluna que ficou sem coeficientes definidos na regressão: Retirada dessa variável
regrOriginalForw <- step(lm(pib_capta ~ milit_expend + arms_indus + arms_imp + arms_exp + milit_staff, data = regrOriginal), direction = "forward")
summary(regrOriginalForw)

### comparação dos modelos ###
# Sumários
stargazer(regrOriginalBack, regrOriginalForw, regrOriginalBoth, type="text", object.names = TRUE, title="Defesa e Crescimento Economico", single.row=TRUE)
(plot_summs(regrOriginalBack, regrOriginalForw, regrOriginalBoth, model.names = c("Backward", "Forward", "Both"))

# Performance
test_performance(regrOriginalBack, regrOriginalForw, regrOriginalBoth)
compare_performance(regrOriginalBack, regrOriginalForw, regrOriginalBoth, rank = TRUE, verbose = FALSE)
plot(compare_performance(regrOriginalBack, regrOriginalForw, regrOriginalBoth, rank = TRUE, verbose = FALSE))

### Diagnóstico ###
# checagem geral #
check_model(regrOriginalBoth)

# testes unitários #
shapiro.test(residuals(regrOriginalBoth))
check_heteroscedasticity(regrOriginalBoth)
check_collinearity(regrOriginalBoth)

# outliers #
check_outliers(regrOriginalBoth)
influencePlot(regrOriginalBoth, id.method="identify", main="Observações Influentes", sub="Círculo proporcional à distância de Cook")
residualPlots(regrOriginalBoth)

### Remodelagem 1 ###
regrOriginal$Military.personnel..thousands. <- sqrt(regrOriginal$Military.personnel..thousands.)
regrOriginal <- regrOriginal %>% dplyr::select(-c(Military.personnel..thousands.))

regrOriginalBoth2 <- step(lm(PIB.per.capita ~ Arms.Industry..milhoes.US.., data = regrOriginal), direction = "both")
summary(regrOriginalBoth2)

par(ask = FALSE)
check_model(regrOriginalBoth2)
residualPlots(regrOriginalBoth2)

### Ausência de normalidade nos resíduos ######
# Remoção de outliers #
cooksdRegrOriginal <- cooks.distance(regrOriginalBoth2)
obsInfluentes <- cooksdRegrOriginal[cooksdRegrOriginal > 4*mean(cooksdRegrOriginal, na.rm=T)]

regrOriginal %>% slice(c(as.integer(names(obsInfluentes))))

RegrOriginal2 <- regrOriginal %>% slice(-c(as.integer(names(obsInfluentes))))

regrOriginalBoth3 <- step(lm(PIB.per.capita ~ Arms.Industry..milhoes.US.., data = RegrOriginal2), direction = "both")
summary(regrOriginalBoth3)
check_model(regrOriginalBoth3)
residualPlots(regrOriginalBoth3)

# Transformação Box-Cox#
regrOriginalBoxCox <- EnvStats::boxcox(regrOriginalBoth3, optimize = T)

par(mfrow=c(1,2), ask = FALSE)
qqnorm(resid(regrOriginalBoth3))
qqline(resid(regrOriginalBoth3))
plot(regrOriginalBoxCox, plot.type = "Q-Q Plots", main = 'Normal Q-Q Plot')
par(mfrow=c(1,1), ask = FALSE)

lambda <- regrOriginalBoxCox$lambda
lambda

regrOriginalBoxCox <- step(lm((PIB.per.capita^lambda-1)/lambda ~ Arms.Industry..milhoes.US.., data = RegrOriginal2), direction = "both")

summary(regrOriginalBoxCox)
check_model(regrOriginalBoxCox)
residualPlots(regrOriginalBoxCox)

### Heterocedasticidade ###
# Estimativas robustas
regrOriginalBoxCox$robse <- vcovHC(regrOriginalBoxCox, type = "HC1")
coeftest(regrOriginalBoxCox, regrOriginalBoxCox$robse)

summary(regrOriginalBoxCox)
check_model(regrOriginalBoxCox)
residualPlots(regrOriginalBoxCox)



## Testes (!!!)

#verificar outliers
boxplot(RegrOriginal2$Arms.Industry..milhoes.US..)
boxplot(RegrOriginal2$Military.personnel..thousands.)

x = RegrOriginal2$Arms.Industry..milhoes.US..

q1 = quantile(RegrOriginal2$Arms.Industry..milhoes.US.., 0.25)
q3 = quantile(RegrOriginal2$Arms.Industry..milhoes.US.., 0.75)
iq = q3 - q1
lim_inf = q1 - 1.5*iq
lim_sup = q3 + 1.5*iq

x > lim_sup
x < lim_inf


View(regrOriginal)

solo.ID <- 1
solo.atr <- 4
solo.nome <- 'Arms.Industry..milhoes.US..'
solo.selecao <- c(solo.ID, solo.atr)

box.out <- boxplot(regrOriginal[,solo.atr], main = paste(solo.nome))$out

hist(regrOriginal[,solo.atr], main = paste(solo.nome))

regrOriginal[regrOriginal[,solo.nome] %in% box.out, solo.selecao]


