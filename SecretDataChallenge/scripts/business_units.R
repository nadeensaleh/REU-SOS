alldata = read.csv("/Users/Nadeensterx3/Desktop/REU-SOS/spreadsheets/SurveyAnalysis/data/SurveyData_Text_Cleaned.csv", na.strings = "")
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
groupbyunit <- as.data.frame(table(units$unit))

# Pretty graphs
library(plyr)
library(ggplot2)
library(dplyr) # for the chaining (%>%) operator
library(RColorBrewer)

positions <- c("ZC", "PG", "DM", "PA", "EP")
colnames(groupbyunit) <- c("unit", "freq")

# Blue bar graph by division with counts
ggplot(data=groupbyunit, aes(x=unit, y=freq, fill=unit)) +
  scale_fill_manual(values = rep(brewer.pal(8, "Greens")[3:8], times=2)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=freq), vjust=1.3, size=8, colour="white", fontface="bold") + 
  theme(legend.position="none") +
  labs(x= "Division", y = "Number of Individuals") +
  theme(text=element_text(size=18),
        axis.title=element_text(size=18,face="bold"))

# Group by both 
groupbyboth <- units %>% group_by(unit,subunit) %>% tally()

# Get the position of label based on frequency (n) 
groupbyboth <- group_by(groupbyboth,unit) %>%
  mutate(pos = cumsum(n) - (0.5 * n))

# Randomly fucking stopped working?...
# groupbyboth <- count(groupbyunit, vars=c("unit", "subunit"))

# Blue stacked bar graph by unit
ggplot(data = groupbyboth, aes(x = unit, y = n, fill = subunit)) + 
  scale_fill_manual(values = rep(brewer.pal(9, "Greens")[3:9], times=4)) +
  geom_bar(stat="identity", colour="white", lwd=0.2) +
  geom_text(aes(label=paste0(subunit,": ", n), y=pos), colour="white", size=4, fontface="bold") + 
  theme(legend.position="none") +
  labs(x= "Division", y = "Number of Individuals") +
  theme(text=element_text(size=18),
        axis.title=element_text(size=18,face="bold"))

# Horizontal bar graph with legend and lots of colors
ggplot(data = groupbyboth, aes(x = unit, y = n, fill = subunit)) + 
  geom_bar(stat="identity", colour="white", lwd=0.2) +
  geom_text(aes(label=paste0(n), y=pos), colour="white", size=4, fontface="bold") + 
  labs(x= "Division", y = "Number of Individuals") +
  theme(text=element_text(size=18),
        axis.title=element_text(size=18,face="bold")) +
  coord_flip() 

# Colorful stacked bar graph by unit
ggplot(data = groupbyboth, aes(x=unit, y=n, fill=subunit) ) + 
  geom_bar(stat="identity", colour="black", lwd=0.2) + 
  geom_text(aes(label=paste0(subunit,": ", n), y=pos), colour="grey20", size=4, fontface="bold") +
  guides(fill=FALSE) +
  labs(x= "Division", y = "Number of Individuals") +
  theme(text=element_text(size=18),
        axis.title=element_text(size=18,face="bold"))