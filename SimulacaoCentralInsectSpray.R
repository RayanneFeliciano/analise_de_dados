InsectSprays$count
mean(InsectSprays$count)
SimulacaoCentralInsectSpray <- InsectSprays$count - mean(InsectSprays$count)
hist(InsectSprays$count)
hist(SimulacaoCentralInsectSpray)
