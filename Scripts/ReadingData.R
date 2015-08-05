library(RMySQL)
ucscDb = dbConnect(MySQL(), user = 'genome', host = 'genome-mysql.cse.ucsc.edu')
results = dbGetQuery(ucscDb, 'show databases;')
dbDisconnect(ucscDb)

hg19=dbConnect(MySQL(), user = 'genome', db = 'hg19', host = 'genome-mysql.cse.ucsc.edu')
dbListTables(hg19)
dbListFields(hg19, 'affyU133Plus2')
affdata = dbReadTable(hg19, 'affyU133Plus2')
dbDisconnect(hg19)


con = url('http://fanfandesign.com/About.html')
htmlCode = readLines(con)
close(con)