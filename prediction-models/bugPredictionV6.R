# bug/not-bug, larges-dataset, input=title+description, missing-field(?)=no
#
# auc=0.8478918
# table(report.raw$pred.class, report.raw$category)
#       0    1
# "0" 13101  3763
# "1"  2853  9776


report <- read.csv("C:/Users/sharifhan/Desktop/defect-reports.csv", quote="'", stringsAsFactors=FALSE)
#Conditionally Remove Rows with "?"
report<-report[!(report$type=="?") & !(report$title=="?") & !(report$description=="?") & !(report$project=="?") & !(report$priority=="?"),]

report$category <- factor(ifelse(report$type=="Bug", "1", "0"))
report.raw <- report[, c("title", "description", "category")]

remove(report)
str(report.raw)

#distribution of bug and not-bug
table(report.raw$category)

require(tm)
doc <- c(report.raw$title, report.raw$description)
report.corpus <- Corpus(VectorSource(doc))
corpus.clean <- tm_map(report.corpus, content_transformer(tolower))
corpus.clean <- tm_map(corpus.clean, removeNumbers)
#install.packages("SnowballC")
require(SnowballC)
corpus.clean <- tm_map(corpus.clean, stemDocument)
corpus.clean <- tm_map(corpus.clean, removeWords, stopwords())
corpus.clean <- tm_map(corpus.clean, removePunctuation)
corpus.clean <- tm_map(corpus.clean, stripWhitespace)

report.dtm <- DocumentTermMatrix(corpus.clean)

#Parcentage of each dataset to check if the bugs are divided equally
prop.table(table(report.raw$category))

report.corpus <- corpus.clean[1:29493]

#build a dictionary with most frequent words that appear at 10 times in the corpus.
report.dict <- c(findFreqTerms(report.dtm, 10))

#build a sparse matrix with the dictionary of most frequent words
report.freq.dtm <- DocumentTermMatrix(report.corpus, list(dictionary = report.dict ))


#convert no of occurance of each word in the sparse matix to yes or no for bayesian analysis
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}

report.freq.dtm <- apply(report.freq.dtm, MARGIN = 2, convert_counts)


library(e1071)
options(scipen=999)

report.nb.model <- naiveBayes(report.freq.dtm, report.raw$category, cross=50)

report.nb.prediction.class <- predict(report.nb.model, report.freq.dtm)

table(report.nb.prediction.class, report.raw$category)


report.nb.prediction.raw <- predict(report.nb.model, report.freq.dtm, type="raw")


write.csv(report.nb.prediction.raw, file = "C:/Users/sharifhan/Desktop/report.nb.prediction.raw.csv", row.names=FALSE)
write.csv(report.nb.prediction.class, file = "C:/Users/sharifhan/Desktop/report.nb.prediction.class.csv", row.names=FALSE)
report.nb.prediction.raw <- read.csv("C:/Users/sharifhan/Desktop/report.nb.prediction.raw.csv", quote="'", stringsAsFactors=FALSE)
report.nb.prediction.class <- read.csv("C:/Users/sharifhan/Desktop/report.nb.prediction.class.csv", quote="'", stringsAsFactors=FALSE)

report.raw$pred.class <- report.nb.prediction.class$X
report.raw$X.0. <- report.nb.prediction.raw$X.0.
report.raw$X.1. <- report.nb.prediction.raw$X.1.

#write.csv(report.raw.test, file = "C:/Users/sharifhan/Desktop/report.raw.test.csv", row.names=FALSE)

# print("*************JAVA******************")
# print("**********************************************")
# print("**********************************************")
# print("C:/Users/sharifhan/Desktop/report.raw.test.csv")
# print("**********************************************")
# print("**********************************************")
# print("**********************************************")

#report.raw.test.out <- read.csv("C:/Users/sharifhan/Desktop/report.raw.test.out.csv", quote="'", stringsAsFactors=FALSE)
#report.raw.test$pred.raw <- report.raw.test.out$X.pred.raw.

report.raw$pred.raw <- ifelse(report.raw$pred.class=="0", report.raw$X.0., report.raw$X.1.)


prop.table(table(report.raw$category))
prop.table(table(report.raw$pred.class))

table(report.nb.prediction.class$X, report.raw$category)
table(report.raw$pred.class, report.raw$category)

#install.packages("ROCR")
library(ROCR)

eval <- prediction(report.raw$pred.raw, report.raw$category)

#eval <- prediction(report.raw.test.out$X.pred.raw., report.raw.test$category)


plot(performance(eval,"tpr","fpr"))
print(attributes(performance(eval,'auc'))$y.values[[1]])
