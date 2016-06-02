.libPaths( c( .libPaths(), "./Stats/src/lib") )

library(minerva)
library(ggplot2) 
library(reshape2) 
library(RMySQL)
library(lsr)

connection <- dbConnect(MySQL(), user = 'root', password = '', host = '127.0.0.1', dbname='ProductHunt')
f.query <- dbSendQuery(connection, "SELECT DAYOFWEEK(created_at) as day, HOUR(created_at) as hour, votes_count FROM Posts")
f.results = fetch(f.query, n=-1)
data = f.results
#data <- data[order(data$votes_count),]
#row.names(data) <- data$day
library(reshape2)
mymatrix <- acast(data, day ~ hour)
mymatrix
rownames(mymatrix) <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
colnames(mymatrix) <- c("12:00 am","1:00 am","2:00 am","3:00 am","4:00 am","5:00 am","6:00 am","7:00 am","8:00 am","9:00 am","10:00 am","11:00 am","12:00 pm","1:00 pm","2:00 pm","3:00 pm","4:00 pm","5:00 pm","6:00 pm","7:00 pm","8:00 pm","9:00 pm","10:00 pm","11:00 pm")
day_hour_hm <- heatmap(mymatrix, Rowv=NA, Colv=NA, col = cm.colors(256), scale="column", margins=c(5,8))
