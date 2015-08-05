x[x$'var2'>5,] #NAA values are kept#
x[which(x$'var2'>5),] #NA values are excluded#

sort(x$var2, na.last=TRUE)
x[order(x$var2, na.last = TRUE),] #accesdending#
x[order(-x$var2, na.last = TRUE),] #deceanding#
x[order(x$var1, x$var3),]

library(plyr)
arrange(x, -var1)


fileUrl = "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile='./data/restaurants.csv', method='internal')
restdata = read.csv('./data/restaurants.csv')
summary(restdata)
head(restdata, n=3)
quantile(restdata$councilDistrict, probs=c(0.5, 0.75, 0.9))
colSums(is.na(restdata))
table(restdata$zipCode %in% c('21212', '21213'))
restdata[restdata$zipCode %in% c('21212', '21213'), ]
print(object.size(restdata), unit='Mb')


restdata$nearMe = restdata$neighborhood %in% c('Roland Park', 'Homeland')
table(restdata$nearMe)
restdata$zipGroup = cut(restdata$zipCode, breaks=quantile(restdata$zipCode))
table(restdata$zipGroup, restdata$zipCode)


library(reshape2)
mtcars$carname = rownames(mtcars)
carmelt = melt(mtcars, id=c('carname', 'gear', 'cyl'), measure.vars=c('hp','mpg')
cyldata = dcast(carmelt, cyl ~ variable, mean)

spraymelt = melt(InsectSprays, id='spray', measure.vars = 'count')
spraycount = dcast(spraymelt, spray ~ variable, sum)


library(dplyr)
head(select(mtcars, mpg:gear))
head(select(mtcars, 1:5))
head(select(mtcars, -(mpg:gear))) #exclude columns mpg to gear#
power_car = filter(mtcars, mtcars$hp>100 & mtcars$gear>3)
sub_car = select(power_car, 1:3, gear, carname)
order_car = arrange(power_car, cyl, desc(mpg))
mtcars = rename(mtcars, brand = carname)
mutate()
group_by()


