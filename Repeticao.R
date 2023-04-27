#Utilização da base mtcars do R
mtcars

#Family apply
apply(mtcars, 2, sum)

lapply(mtcars, sum)
unlist(lapply(mtcars, sum))
lapply(mtcars, function(x) x*2)

sapply(mtcars, sum)
sapply(mtcars, sum, simplify = FALSE)

mapply(rep, 1:3, 3:1)
mapply(rep, 1:3)
mapply(rep, 3:1, 3)
