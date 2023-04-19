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

#Indexação com o nome da coluna (forma 1)
listaLivros$autores

#Indexação com o nome da coluna (forma 2)
listaLivros[ ,'autores']

#Indexação para recuperar toda a coluna pela sua posição
listaLivros[ ,3]

#Indexação para recuperar um dado específico pela sua posição
listaLivros[2,3]

#Indexação para retirar uma coluna
listaLivros[ ,-2]

#Indexação testagem de quais são maiores que a condição em certa coluna
listaLivros[ ,'ano'] > 2005

#Indexação para resgatar mais de um dado numa coluna específica
listaLivros[2:3,'ano']
listaLivros[c(2:3,6),'ano']
