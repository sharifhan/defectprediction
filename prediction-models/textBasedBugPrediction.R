#loading
report.raw <- read.csv("C:/Users/sharifhan/Desktop/defect-reports.csv", quote="'", stringsAsFactors=FALSE)

#tramsform
report.raw$isBug <- factor(ifelse(report.raw$type=="Bug", "True", "False"))

#install.packages("tm")
require(tm)

#build the corpus, which is the collection of report descriptions
report.corpus <- Corpus(VectorSource(report.raw$description))

#clean corpus data
corpus.clean <- tm_map(report.corpus, content_transformer(tolower))
corpus.clean <- tm_map(corpus.clean, removeNumbers)
install.packages("SnowballC")
require(SnowballC)
corpus.clean <- tm_map(corpus.clean, stemDocument)
corpus.clean <- tm_map(corpus.clean, removeWords, stopwords())
corpus.clean <- tm_map(corpus.clean, removePunctuation)
corpus.clean <- tm_map(corpus.clean, stripWhitespace)

#inspect(defect.reports.corpus[1:3])
#inspect(corpus.clean[1:3])

#tokenize the report corpus and create a sparse matrix (dtm)
report.dtm <- DocumentTermMatrix(corpus.clean)
#corpus.tokenize <- DocumentTermMatrix(defect.reports.corpus)

#corpus.tokenize <- DocumentTermMatrix(defect.reports.corpus, control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE), stopwords = TRUE))


#total reports 62414
#60%train=37449, 40%test=24965

report.raw.train <- report.raw[1:37449, ]
report.raw.test <- report.raw[37450:62414, ]

#dtm
report.dtm.train <- report.dtm[1:37449, ]
report.dtm.test <- report.dtm[37450:62414, ]

#dtm leight
report.dtm.train <- report.dtm[1:3000, ]


#heavyweight
report.corpus.train <- corpus.clean[1:37449]
report.corpus.test <- corpus.clean[37450:62414]


#lightweight
report.corpus.train <- corpus.clean[1:3000]
report.corpus.test <- corpus.clean[3001:6000]


#install.packages("wordcloud")
require(wordcloud)
wordcloudreport.corpus.train, min.freq = 100, random.order = FALSE)

bug <- subset(report.raw.train, isBug=="True")
notBug <- subset(report.raw.train, isBug=="False")

wordcloud(bug$description, min.freq = 100, random.order = FALSE)
wordcloud(notBug$description, min.freq = 100, random.order = FALSE)

#Terms(defect.reports.corpas.train)

#defect.reports.dict <- Dictionary(findFreqTerms(defect.reports.corpas.train, 10))
report.dict <- Terms(report.dtm.train)

report.train <- DocumentTermMatrix(report.corpus.train, control = list(dictionary = report.dict ))

report.test <- DocumentTermMatrix(report.corpus.test, list(dictionary = report.dict ))

convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1), labels = c(""No"", ""Yes""))
  return(x)
}

report.train <- apply(report.train, MARGIN = 2, convert_counts)
report.test <- apply(report.test, MARGIN = 2, convert_counts)