setwd('C:/Users/hliu/Documents/R_study/cleaning data')
if(!file.exists('data')){dir.create('data')}

fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = './data/cameras.csv', method = 'internal')
camera = read.csv('./data/cameras.csv', na.strings = NA)

library(XML)
fileUrl = "http://www.w3schools.com/xml/simple.xml"
doc = xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode = xmlRoot(doc)
xpathSApply(rootNode, '//name', xmlValue)
xpathSApply(rootNode, '//price', xmlValue)

library(jsonlite)
jsondata = fromJSON("https://api.github.com/users/jtleek/repos")