alldata = read.csv("spreadsheets/SurveyAnalysis/data/SurveyData_Text_Cleaned.csv", na.strings = "")
alldata = alldata[-1,] # Delete first row

# Extract business subunit associations where not NA
gender <- as.character(alldata[,"Q12.2"])
gender <- gender[!is.na(gender)]
genders <- as.data.frame(gender)
groupbygender <- as.data.frame(table(genders$gender))

source_github <- function(u) {
  # load package
  require(RCurl)
  
  # read script lines from website and evaluate
  script <- getURL(u, ssl.verifypeer = FALSE)
  eval(parse(text = script),envir=.GlobalEnv)
}

source_github("https://raw.githubusercontent.com/robertgrant/pictogram/master/pictogram.R")

library(png)
library(reshape)
male <- readPNG("man.png")
female <- readPNG("woman.png")

pictogram(icon=list(female,male),
          n=c(60,83),
          grouplabels=c("Female", "Male"))