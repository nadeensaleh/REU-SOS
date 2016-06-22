everything = read.csv("spreadsheets/SurveyAnalysis/data/SurveyData_Numeric_Cleaned.csv", stringsAsFactors = FALSE)
everything = everything[-1,] # Delete first row

# Subset data regarding distribution of Excel uses
thisdata <- everything[,c("Q3.3_1", "Q3.3_2", "Q3.3_3", "Q3.3_4", "Q3.3_5", "Q3.3_6")]

# Pull out name of columns we're interested in, this time including the associated role
columns <- c("Q3.3_1", "Q3.3_2", "Q3.3_3", "Q3.3_4", "Q3.3_5", "Q3.3_6", "Q12.9")

# Convert columns to numeric
everything$Q3.3_1 <- as.numeric(everything$Q3.3_1)
everything$Q3.3_2 <- as.numeric(everything$Q3.3_2)
everything$Q3.3_3 <- as.numeric(everything$Q3.3_3)
everything$Q3.3_4 <- as.numeric(everything$Q3.3_4)
everything$Q3.3_5 <- as.numeric(everything$Q3.3_5)
everything$Q3.3_6 <- as.numeric(everything$Q3.3_6)

# Sum the Excel features used and place into contents of original data, 
# new data.frame -> finaldata
finaldata <- transform(everything, sum=rowSums(thisdata))

# Associate numbers with string of roles in roles column
for (i in 1:nrow(finaldata)) {
  if (finaldata$Q12.9[i] == 1) {
    finaldata$Q12.9[i] = "Sales"
  }
  if (finaldata$Q12.9[i] == 2) {
    finaldata$Q12.9[i] = "Marketing"
  }
  if (finaldata$Q12.9[i] == 3) {
    finaldata$Q12.9[i] = "Operations/Manufacturing"
  }
  if (finaldata$Q12.9[i] == 4) {
    finaldata$Q12.9[i] = "Engineering"
  }
  if (finaldata$Q12.9[i] == 5) {
    finaldata$Q12.9[i] = "Research"
  }
  if (finaldata$Q12.9[i] == 6) {
    finaldata$Q12.9[i] = "Finance"
  }
  if (finaldata$Q12.9[i] == 7) {
    finaldata$Q12.9[i] = "Distribution"
  }
  if (finaldata$Q12.9[i] == 8) {
    finaldata$Q12.9[i] = "Others"
  }
}

# Pull out role and feature sum columns
finaldata2 <- finaldata[,c("Q12.9", "sum")]

# Associate each role with the mean average Excel uses marked, new data.frame -> done
finaldata3 <- as.data.frame(ddply(finaldata2, ~ Q12.9, summarize,
      mean = round(mean(sum), 2),
      sd = round(sd(sum), 2)))

# Delete unnecessary info
finaldata3 = finaldata3[-1,]
finaldata3$sd <- NULL

# Rename role column
colnames(finaldata3)[1] <- "role" 

# Remove "Other" roles
finaldata3 <- finaldata3[finaldata3$role!="Others", ]

# Bar graph of roles and Excel purpose
positions <- c("Research", "Distribution", "Operations/Manufacturing", "Marketing", "Sales", "Engineering", "Finance")
ggplot(data=finaldata3, aes(x=role, y=mean, fill=role)) +
  geom_bar(colour="black", stat="identity") +
  guides(fill=FALSE) +
  scale_x_discrete(limits = positions)