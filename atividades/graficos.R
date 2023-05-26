pacman::p_load(dplyr, ggplot2)

# Gráfico de caixas univariado
ChickWeight %>% ggplot(aes(y = weight)) + geom_boxplot()

# Gráfico de caixas multivariado
ChickWeight %>% ggplot(aes(y= weight, x= Diet)) + geom_boxplot()

# Histograma
ChickWeight %>% ggplot(aes(x=weight)) + geom_histogram()

# Densidade
ChickWeight %>% ggplot(aes(x=weight)) + geom_density()

# Séries Temporais
ChickWeight %>% filter(Chick == 1) %>% ggplot(aes(y= weight, x= Time)) + geom_line()

# Barras
ChickWeight %>% ggplot(aes(y=weight, x=Time)) + geom_bar(stat = 'identity')

# Dispersão
ChickWeight %>% ggplot(aes(y=weight, x=Time)) + geom_point()
