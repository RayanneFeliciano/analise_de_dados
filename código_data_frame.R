install.packages('eeptools')
library(eeptools)

#vetor com nome dos livros
nomeLivros <- c('The Nature of Political Theory', 'Justiça como equidade: uma reformulação','A raposa e o porco-espinho: Justiça e valor','A ideia de Justiça', 'Anarquia, Estado e Utopia', 'The Society of Equals')

#vetor com nome dos autores
nomeAutores <- c('Andrew Vincent', 'John Rawls', 'Ronald Dworkin', 'Amartya Sen', 'Robert Nozick', 'Pierre Rosanvallon')

#vetor com ano dos livros
anoLivro <- c(2004, 2001, 2011, 2009, 1974, 2011)

#vetor com ano de nascimento dos autores
anoNascimentoAutor <- c(1951, 1921, 1931, 1933, 1938, 1948)

#vetor com país de origem dos autores
nacionalidadeAutor <- c('Britanico', 'Americano', 'Americano', 'Indiano', 'Americano', 'Frances')

#data.frame dos dados
listaLivros <- data.frame(
  livro = nomeLivros,
  autores = nomeAutores,
  ano = anoLivro,
  nascimentoAutor = anoNascimentoAutor,
  nacionalidadeAutor = nacionalidadeAutor
)
View(listaLivros)
