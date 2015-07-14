

report <- read.csv("C:/Users/sharifhan/Desktop/defect-reports.csv", quote="'", stringsAsFactors=FALSE)
#Conditionally Remove Rows with "?"
report<-report[!(report$type=="?") & !(report$title=="?") & !(report$description=="?") & !(report$project=="?") & !(report$priority=="?"),]

report$category <- factor(ifelse(report$type=="Bug", "1", "0"))
report.raw <- report[, c("title", "description", "category")]

remove(report)
str(report.raw)

report.raw$text <- paste(report.raw$title, report.raw$description)
report.raw <- report.raw[, c("text", "category")]

rownames(report.raw) <- NULL

#once opened in notepad++ remove the backslash \ character so that weka arff can view this properly
write.csv(report.raw, file = "C:/Users/sharifhan/Desktop/text-mining.csv", quote=c(1), row.names=FALSE)
