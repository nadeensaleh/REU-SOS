alldata = read.csv("spreadsheets/SurveyAnalysis/data/SurveyData_Text_Cleaned.csv", na.strings = "")
alldata = alldata[-1,] # Delete first row

# Extract business subunit associations where not NA
subunit <- as.character(alldata[,"Q12.10"])
subunit <- subunit[!is.na(subunit)]
subunits <- as.data.frame(subunit)

# Extract unit from subunit (first 2 characters)
units <- vector("character", ncol(subunits))
for (i in 1:nrow(subunits)) {
  units[i] <- substr(subunits$subunit[i], 1, 2)
}

# Transpose to get a column of business units
units <- t(units)
units <- as.data.frame(t(units))

units$subunit = subunits$subunit
colnames(units) <- c("unit", "subunit")

# Simple stacked bar graph
groupbyunit <- as.data.frame(table(units$unit))
barplot(groupbyunit, main="Business Unit Distribution of Survey Data",
        col=c("darkblue", "maroon", "darkgreen", "darkorange", "violet"))

# Ugly stacked bar graph
s_groupbyunit <- table(subunits$subunit, units$unit)
barplot(s_groupbyunit, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("blue","red", "green", "orange", "purple"),
        legend = rownames(s_groupbyunit))

# Pretty graphs
library(plyr)
library(ggplot2)

positions <- c("ZC", "PG", "DM", "PA", "EP")
colnames(groupbyunit) <- c("unit", "freq")

ggplot(data=groupbyunit, aes(x=unit, y=freq, fill=unit)) +
  geom_bar(stat="identity") +
  scale_x_discrete(limits = positions) +
  guides(fill=FALSE)

groupbyboth <- count(units,vars = c("unit","subunit"))

ggplot(data = groupbyboth, aes(x = unit, y = freq, fill = subunit)) + 
  geom_bar(stat="identity") +
  scale_x_discrete(limits = positions)