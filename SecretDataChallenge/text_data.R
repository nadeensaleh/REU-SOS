textdata = read.csv("spreadsheets/SurveyAnalysis/data/SurveyData_Text_Cleaned.csv", na.strings = "")
textdata = textdata[-1,] # Delete first row

# Q9.3_1 through 7 -> different impediments
textdata$Q9.3_1 <- as.character(textdata$Q9.3_1)
textdata$Q9.3_2 <- as.character(textdata$Q9.3_2)
textdata$Q9.3_3 <- as.character(textdata$Q9.3_3)
textdata$Q9.3_4 <- as.character(textdata$Q9.3_4)
textdata$Q9.3_5 <- as.character(textdata$Q9.3_5)
textdata$Q9.3_6 <- as.character(textdata$Q9.3_6)
textdata$Q9.3_7 <- as.character(textdata$Q9.3_7)

# 12.9 -> role
textdata$Q12.9 <- as.character(textdata$Q12.9)

# Pull out a subset
subsetdata <- textdata[,c("Q9.3_1", "Q9.3_2", "Q9.3_3", "Q9.3_4", "Q9.3_5", "Q9.3_6", "Q9.3_7", "Q12.9")]

# Delete "Other" roles
subsetdata <- subsetdata[subsetdata$Q12.9!="Other", ]

# Convert impediment text to "1" since impediment definition is already defined by column
for (i in 1:nrow(subsetdata)) {
  if (!is.na(subsetdata$Q9.3_1[i])) {
    subsetdata$Q9.3_1[i] = as.numeric(1)
  } 
  if (!is.na(subsetdata$Q9.3_2[i])) {
    subsetdata$Q9.3_2[i] = as.numeric(1)
  } 
  if (!is.na(subsetdata$Q9.3_3[i])) {
    subsetdata$Q9.3_3[i] = as.numeric(1)
  } 
  if (!is.na(subsetdata$Q9.3_4[i])) {
    subsetdata$Q9.3_4[i] = as.numeric(1)
  } 
  if (!is.na(subsetdata$Q9.3_5[i])) {
    subsetdata$Q9.3_5[i] = as.numeric(1)
  } 
  if (!is.na(subsetdata$Q9.3_6[i])) {
    subsetdata$Q9.3_6[i] = as.numeric(1)
  } 
  if (!is.na(subsetdata$Q9.3_7[i])) {
    subsetdata$Q9.3_7[i] = as.numeric(1)
  }
}

# Rename the column to be associated with impediment
colnames(subsetdata) <- c("time", "cost", "quality", "interest", "support", "applicable", "other", "role")

# Subset into tables by impediment and bind back together to get all individual markings
time <- subsetdata[subsetdata$time==1, ]
cost <- subsetdata[subsetdata$cost==1, ]
quality <- subsetdata[subsetdata$quality==1, ]
interest <- subsetdata[subsetdata$interest==1, ]
support <- subsetdata[subsetdata$support==1, ]
applicable <- subsetdata[subsetdata$applicable==1, ]
alldata <- rbind(time, cost, quality, interest, support, applicable)

# Remove NA rows
ind <- apply(alldata, 1, function(x) all(is.na(x)))
alldata <- alldata[ !ind, ]

# Convert columns to numeric
alldata$time <- as.numeric(alldata$time)
alldata$cost <- as.numeric(alldata$cost)
alldata$quality <- as.numeric(alldata$quality)
alldata$interest <- as.numeric(alldata$interest)
alldata$support <- as.numeric(alldata$support)
alldata$applicable <- as.numeric(alldata$applicable)
alldata$other <- as.numeric(alldata$other)

# Replace NA with zero for sake of mean
alldata[is.na(alldata)] <- 0

# Associate each role with the mean average of checks per imediment, new data.frame -> done
done <- aggregate(alldata[, 1:7], list(alldata$role), mean)

# Rename roles column from auto-assigned name 'Group1'
colnames(done)[1] <- "role"

# Melt data for graphing
library(reshape2)
done <- melt(done)
roles <- done$role

# Plot stacked bar graph with melted data
library(ggplot2)
ggplot(done, aes(x=roles, y=value, fill=variable)) + geom_bar(stat='identity')