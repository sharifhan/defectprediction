report <- read.csv("C:/Users/sharifhan/Desktop/defect-reports.csv", quote="'", stringsAsFactors=FALSE)
#Conditionally Remove Rows with "?"
report<-report[!(report$type=="?"),]
report$category <- factor(ifelse(report$type=="Bug", "BUG", "ISNt"))
report.raw <- report[, c("description", "category")]

require(tm)
report.corpus <- Corpus(VectorSource(report.raw$description))
corpus.clean <- tm_map(report.corpus, content_transformer(tolower))
corpus.clean <- tm_map(corpus.clean, removeNumbers)
#install.packages("SnowballC")
require(SnowballC)
corpus.clean <- tm_map(corpus.clean, stemDocument)
corpus.clean <- tm_map(corpus.clean, removeWords, stopwords())
corpus.clean <- tm_map(corpus.clean, removePunctuation)
corpus.clean <- tm_map(corpus.clean, stripWhitespace)

report.dtm <- DocumentTermMatrix(corpus.clean)
dim(report.dtm)

report.raw.train <- report.raw[1:25000, ]
report.raw.test <- report.raw[25001:53609, ]

report.dtm.train <- report.dtm[1:25000, ]

report.corpus.train <- corpus.clean[1:25000]
report.corpus.test <- corpus.clean[25001:53609]

report.dict <- c(findFreqTerms(report.dtm.train, 5))
report.train <- DocumentTermMatrix(report.corpus.train, list(dictionary = report.dict ))
report.test <- DocumentTermMatrix(report.corpus.test, list(dictionary = report.dict ))


convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}


remove(report)
remove(report.raw)
remove(corpus.clean)
remove(report.corpus)
remove(report.corpus.test)
remove(report.dict)
remove(report.dtm)
remove(report.dtm.train)
remove(report.corpus.train)

report.train <- apply(report.train, MARGIN = 2, convert_counts)



library(e1071)

#onpen cmd and C:\Program Files\RStudio\bin\rstudio.exe --max-mem-size=12GB

report.nb.classifier <- naiveBayes(report.train, report.raw.train$category)
names(report.nb.classifier)

remove(report.train)
remove(report.raw.train)


report.test <- apply(report.test, MARGIN = 2, convert_counts)
report.test.pred <- predict(report.nb.classifier, report.test)

table(report.raw.test$category, report.test.pred)
