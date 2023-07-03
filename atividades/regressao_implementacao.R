### CARREGANDO PACOTES ###
pacman::p_load(car, gvlma, lm.beta, lmtest, MASS, sandwich)

### REGRESSÃO ASSAULT - BASE USArrests
regUSArrests <- lm(Assault ~ ., data = USArrests) # ESTIMANDO A REGRESSÃO
summary(regUSArrests) # SUMÁRIO
lm.beta(regUSArrests) # COEFICIENTES PADRONIZADOS

# Stepwise #
regUSArrestsBack <- step(lm(Assault ~ ., data = USArrests), direction = 'backward') # de trás pra frente
summary(regUSArrestsBack)
regUSArrestsForw <- step(lm(Assault ~ ., data = USArrests), direction = 'forward') # do início pro fim
summary(regUSArrestsForw)
regUSArrestsBoth <- step(lm(Assault ~ ., data = USArrests), direction = 'both') # nos dois sentidos
summary(regUSArrestsBoth)

### VERIFICAÇÃO DOS PRESSUPOSTOS ###
# normalidade dos resíduos
shapiro.test(residuals(regUSArrests))
plot(regUSArrests, which=1, col=c("blue")) # resíduos x ajuste
plot(regUSArrests, which=2, col=c("red")) # Q-Q Plot
plot(regUSArrests, which=5, col=c("blue"))  # Observações Influentes

# inflação da variância / multicolinearidade
vif(regUSArrests)
barplot(vif(regUSArrests), main = "VIF Values", horiz = FALSE, col = "steelblue", ylim = c(0,5))
abline(h = 5, lwd = 3, lty = 2)

# homocedasticidade (H0 = homocedasticidade)
bptest(regUSArrests) # teste de homocedasticidade
plot(regUSArrests, which=3, col=c("blue"))  # Scale-Location Plot