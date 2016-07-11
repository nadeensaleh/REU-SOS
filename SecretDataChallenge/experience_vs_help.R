ehdata = read.csv("/Users/Nadeensterx3/Desktop/REU-SOS/spreadsheets/SurveyAnalysis/data/experience_help.csv", stringsAsFactors=FALSE)
ehdata[is.na(ehdata)] <- 0
colnames(ehdata) <- c("Experience", "Google", "Youtube", "Forums", "Blogs", "Other")

library(dplyr)
# Sums multiple columns within a groupby
# Good reference: http://stackoverflow.com/questions/21644848/summarizing-multiple-columns-with-dplyr
# ehdata <- ehdata %>% group_by(Experience) %>% summarise_each(funs(sum))

# Melt data to feed into graph
library(reshape2)
ehdata <- melt(ehdata, id.vars = 1)
ehdata <- ehdata %>% group_by(Experience, variable) %>% summarise_each(funs(sum))
colnames(ehdata) <- c("Experience", "Resource", "value")

# Change from frequency to percent
for (i in 1:nrow(ehdata)) {
  ee = 0
  se = 0
  ve = 0
  for (k in 1:5) {
    ee = ehdata$value[k] + ee
  }
  for (k in 6:10) {
    se = ehdata$value[k] + se
  }
  for (k in 11:15) {
    ve = ehdata$value[k] + ve
  }
} 
for (i in 1:5) {
  ehdata$value[i] = ehdata$value[i] / ee
}
for (i in 6:10) {
  ehdata$value[i] = ehdata$value[i] / se
}
for (i in 11:15) {
  ehdata$value[i] = ehdata$value[i] / ve
}

# Stacked bar percent graph
library(scales)
ggplot(data = ehdata, aes(x = Experience, y = value, fill = Resource)) + 
  geom_bar(stat="identity", colour="black", lwd=0.2) + 
  labs(x= "Experience", y = "Number of Individuals") +
  theme(text=element_text(size=18),
        axis.title=element_text(size=18,face="bold")) +
  scale_y_continuous(labels = percent_format())