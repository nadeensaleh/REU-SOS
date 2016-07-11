alldata = read.csv("spreadsheets/SurveyAnalysis/data/SurveyData_Text_Cleaned.csv", na.strings = "", stringsAsFactors=FALSE)
alldata = alldata[-1,] # Delete first row

# Extract business subunit associations where not NA
columns <- c("Q3.4_10", "Q3.4_13", "Q3.4_3", "Q3.4_1", "Q3.4_2", "Q3.4_6", "Q3.4_11")
tools <- alldata[,columns]
colnames(tools) <- c("FindReplace", "DataSortTool", 
                     "ConditionalFormatting", "LOOKUPFunctions", 
                     "PivotTables", "ChartWizard", "Macros")

# Remove count for "Never" and "Don't Know" fields
tools <- as.data.frame(tools)
fr <- as.data.frame(table(tools$FindReplace))
fr <- fr[fr$Var1!="Never" & fr$Var1!="Don't Know",]
dst <- as.data.frame(table(tools$DataSortTool))
dst <- dst[dst$Var1!="Never" & dst$Var1!="Don't Know",]
cf <- as.data.frame(table(tools$ConditionalFormatting))
cf <- cf[cf$Var1!="Never" & cf$Var1!="Don't Know",]
lf <- as.data.frame(table(tools$LOOKUPFunctions))
lf <- lf[lf$Var1!="Never" & lf$Var1!="Don't Know",]
pt <- as.data.frame(table(tools$PivotTables))
pt <- pt[pt$Var1!="Never" & pt$Var1!="Don't Know",]
cw <- as.data.frame(table(tools$ChartWizard))
cw <- cw[cw$Var1!="Never" & cw$Var1!="Don't Know",]
ma <- as.data.frame(table(tools$Macros))
ma <- ma[ma$Var1!="Never" & ma$Var1!="Don't Know",]

# Create new table with count of each tool for "Once a week or less" or more
usedtools <- data.frame(A=character(0), B= numeric(0))
usedtools <- do.call("rbind", list(c("Find/Replace", sum(fr$Freq)),
                      c("Data Sort Tool", sum(dst$Freq)),
                      c("Conditional Frequency", sum(cf$Freq)),
                      c("LOOKUP Functions", sum(lf$Freq)),
                      c("Pivot Tables", sum(pt$Freq)),
                      c("Chart Wizard", sum(cw$Freq)),
                      c("Macros", sum(ma$Freq))))

colnames(usedtools) <- c("Tool", "Frequency")
usedtools <- as.data.frame(usedtools)
usedtools$Frequency <- as.numeric(as.character(usedtools$Frequency))

# Import plyr library to use rounding function
library(plyr)
for(i in 1:nrow(usedtools)) {
  # Take frequency of tool usage as a percent
  usedtools$Frequency[i] <- round_any(usedtools$Frequency[i] / nrow(alldata) * 100, 1)
  # Create new column with percent value
  usedtools$Percent[i] <- paste(usedtools$Frequency[i], "%")
}

# usedtools[rev(order(usedtools$Frequency)),]
# Horizontal bargraph to represent the percent of total users using each tools
library(ggplot2)
positions <- c("Macros", "Chart Wizard", "Pivot Tables", "LOOKUP Functions", "Conditional Frequency", "Find/Replace", "Data Sort Tool")
ggplot(data = usedtools, aes(x = Tool, y = Frequency, fill = Tool)) + 
  geom_bar(stat="identity") +
  geom_text(aes(label=Percent), vjust=0.25, hjust=1.3, size=6, colour="white", fontface="bold") +
  scale_x_discrete(limits = positions) +
  coord_flip() +
  theme(legend.position="none") +
  labs(x= NULL, y = "Percent of users using tool") +
  theme(text=element_text(size=18),
          axis.title=element_text(size=18,face="bold"))