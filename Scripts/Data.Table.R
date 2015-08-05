library(data.table)
test = data.frame(x = rnorm(10, 1), y = rnorm(10, 2), z = rnorm(10, 3))
DT = data.table(test)
DT[y<2 & y>1, ]
DT[c(2, 5),]
DT[, 2, with = FALSE] #subsetting columns#
DT[, mean(x)] #things after coma indicate a calculation#
DT[, w:=z^3] #add column#
DT[, m:={temp=x+2; log2(temp+5)}] #multiple operations#
DT[, k:={x>0 & y>1}]
DT[, o:=mean(x), by=k]
DT[, p:=rep(c('a', 'b'), each=5)]

setkey(DT, p)
DT2 = data.table(h=rnorm(10, 10), p=rep(c('a', 'b'), each =5))
setkey(DT2, p)
merge(DT, DT2)


head(DT, n=3)