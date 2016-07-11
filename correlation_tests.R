.libPaths( c( .libPaths(), "~/REU-SOS/Stats/src/lib") )

library(minerva)
library(ggplot2) 
library(reshape2) 
library(RMySQL)
library(lsr)

# Get data from a database
connection <- dbConnect(MySQL(), user = 'root', password = '', host = '127.0.0.1', dbname='ProductHunt')

# Correlation between votes and days of week/hour
f.query <- dbSendQuery(connection, "SELECT id, comments_count, DAYOFWEEK(created_at), HOUR(created_at) FROM Posts where comments_count>100")
f.results = fetch(f.query, n=-1)
comments  = f.results[,2]
dayOfWeek = f.results[,3]
hour = f.results[,4]

cor.test(comments, dayOfWeek)
cor.test(comments, hour)

# Print out information from histogram
info <- hist(f.results[,2])
info

# This is a neat trick to print out a histogram for all attributes of your data
allHistograms <- melt(f.results[,c(2:4)])
ggplot(allHistograms,aes(x = value)) +
facet_wrap(~variable,scales = "free_x") +
geom_histogram()

# Get data from a database
connection <- dbConnect(MySQL(), user = 'root', password = '', host = '127.0.0.1', dbname='ProductHunt')

# Correlation between votes and days of week/hour
f.query <- dbSendQuery(connection, "SELECT id, votes_count, DAYOFWEEK(created_at), HOUR(created_at) FROM Posts where votes_count>100")
f.results = fetch(f.query, n=-1)
votes  = f.results[,2]
dayOfWeek = f.results[,3]
hour = f.results[,4]

cor.test(votes, dayOfWeek)
cor.test(votes, hour)

allHistograms <- melt(f.results[,c(2:4)])
ggplot(allHistograms,aes(x = value)) +
facet_wrap(~variable,scales = "free_x") +
geom_histogram()

connection <- dbConnect(MySQL(), user = 'root', password = '', host = '127.0.0.1', dbname='ProductHunt')

# Correlation between votes and days of week/hour
f.query <- dbSendQuery(connection, "SELECT id, COUNT(*) as postCount, DAYOFWEEK(created_at) as day, HOUR(created_at) as hour FROM Posts GROUP BY day,hour")
f.results = fetch(f.query, n=-1)
posts  = f.results[,2]
dayOfWeek = f.results[,3]
hour = f.results[,4]

cor.test(posts, dayOfWeek)
cor.test(posts, hour)

allHistograms <- melt(f.results[,c(2:4)])
ggplot(allHistograms,aes(x = value)) +
facet_wrap(~variable,scales = "free_x") +
geom_histogram()