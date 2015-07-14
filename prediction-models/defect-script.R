## type - bug count

#loading

defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")

#tramsform

defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)

#extract

metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]


#scallter plot matrix

pairs(metrics[1:9], main="Scatterplot for Reported Bug and C&K Metrics", pch=18)

#preparaion

metrics.train <- metrics[1:30, ]
metrics.test <- metrics[31:62, ]

#discretize

metrics.test$trueBugCategory <- ifelse(metrics.test$avg_bug_count<0.3425, "Low", "999")
metrics.test$predBugCategory <- ifelse(metrics.test$pred_avg_bug_count<0.3425, "Low", "999")

metrics.test$trueBugCategory <- ifelse(metrics.test$avg_bug_count>0.4600, "High", metrics.test$trueBugCategory)
metrics.test$predBugCategory <- ifelse(metrics.test$pred_avg_bug_count>0.4600, "High", metrics.test$predBugCategory)

metrics.test$trueBugCategory <- ifelse(metrics.test$trueBugCategory==999, "Medium", metrics.test$trueBugCategory)
metrics.test$predBugCategory <- ifelse(metrics.test$predBugCategory==999, "Medium", metrics.test$predBugCategory)

#training

model.lm <- lm(avg_bug_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics.train)


#testing

metrics.test$pred_avg_bug_count <- round(predict(model.lm, newdata=metrics.test), 2)

#plotting true vs. pred

plot (c(-0.5, 1), c(0.0, 5), type="n", cex=4, xlab="Average reported bugs", ylab="Density")
lines(density(metrics.test$avg_bug_count), col="blue", lwd=2.5)
lines(density(metrics.test$pred_avg_bug_count), col="red", lwd=1.5, lty = "dashed")
legend("topright", c("True", "Prediction"), lty=c(1,2), lwd=c(2.5,2.5),col=c("blue","red"))

#regression summary
summary(metrics.test$avg_bug_count)
summary(metrics.test$pred_avg_bug_count)
summary(model.lm)

#confusion matrix (requires caret)

cM <- table(truth=metrics.test$trueBugCategory, prediction=metrics.test$predBugCategory)
confusionMatrix(cM)




## priority - critical count


#loading

defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")

#tramsform

defect.metrics$avg_critical_count <- round(defect.metrics$critical_count/defect.metrics$project_count, 2)

#extract

metrics <- defect.metrics[, c("avg_critical_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]

#scallter plot matrix

pairs(metrics[1:9], main="Scatterplot for Critical Bug and C&K Metrics", pch=18)

#preparaion

metrics.train <- metrics[1:30, ]
metrics.test <- metrics[31:62, ]


#discretize

metrics.test$trueCriticalCategory <- ifelse(metrics.test$avg_critical_count<0.1000, "Low", "999")
metrics.test$predCriticalCategory <- ifelse(metrics.test$pred_avg_critical_count<0.1000, "Low", "999")

metrics.test$trueCriticalCategory <- ifelse(metrics.test$avg_critical_count>0.0400, "High", metrics.test$trueCriticalCategory)
metrics.test$predCriticalCategory <- ifelse(metrics.test$pred_avg_critical_count>0.0400, "High", metrics.test$predCriticalCategory)

metrics.test$trueCriticalCategory <- ifelse(metrics.test$trueCriticalCategory==999, "Medium", metrics.test$trueCriticalCategory)
metrics.test$predCriticalCategory <- ifelse(metrics.test$predCriticalCategory==999, "Medium", metrics.test$predCriticalCategory)

#training

model.lm <- lm(avg_critical_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics.train)

#testing

metrics.test$pred_avg_critical_count <- round(predict(model.lm, newdata=metrics.test), 2)


#plotting true vs. pred

plot (c(-0.05, 0.2), c(0.0, 30), type="n", cex=4, xlab="Average critical bugs", ylab="Density")
lines(density(metrics.test$avg_critical_count), col="blue", lwd=2.5)
lines(density(metrics.test$pred_avg_critical_count), col="red", lwd=1.5, lty = "dashed")
legend("topright", c("True", "Prediction"), lty=c(1,2), lwd=c(2.5,2.5),col=c("blue","red"))

#regression summary

summary(metrics.test$avg_critical_count)
summary(metrics.test$pred_avg_critical_count)
summary(model.lm)

#confusion matrix (requires caret)

cM <- table(truth=metrics.test$trueCriticalCategory, prediction=metrics.test$predCriticalCategory)
confusionMatrix(cM)






## priority - blocker count


#loading

defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")

#tramsform

defect.metrics$avg_blocker_count <- round(defect.metrics$blocker_count/defect.metrics$project_count, 2)

#extract

metrics <- defect.metrics[, c("avg_blocker_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]

#scallter plot matrix

pairs(metrics[1:9], main="Scatterplot for Blocker Bug and C&K Metrics", pch=18)


#preparaion

metrics.train <- metrics[1:30, ]
metrics.test <- metrics[31:62, ]


#discretize

metrics.test$trueBlockerCategory <- ifelse(metrics.test$avg_blocker_count<0.01000, "Low", "999")
metrics.test$predBlockerCategory <- ifelse(metrics.test$pred_avg_blocker_count<0.01000, "Low", "999")

metrics.test$trueBlockerCategory <- ifelse(metrics.test$avg_blocker_count>0.04000, "High", metrics.test$trueBlockerCategory)
metrics.test$predBlockerCategory <- ifelse(metrics.test$pred_avg_blocker_count>0.03900, "High", metrics.test$predBlockerCategory)

metrics.test$trueBlockerCategory <- ifelse(metrics.test$trueBlockerCategory==999, "Medium", metrics.test$trueBlockerCategory)
metrics.test$predBlockerCategory <- ifelse(metrics.test$predBlockerCategory==999, "Medium", metrics.test$predBlockerCategory)

#training

model.lm <- lm(avg_blocker_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics.train)

#testing

metrics.test$pred_avg_blocker_count <- round(predict(model.lm, newdata=metrics.test), 2)

#plotting true vs. pred

plot (c(-0.05, 0.2), c(0.0, 60), type="n", cex=4, xlab="Average blocker bugs", ylab="Density")
lines(density(metrics.test$avg_blocker_count), col="blue", lwd=2.5)
lines(density(metrics.test$pred_avg_blocker_count), col="red", lwd=1.5, lty = "dashed")
legend("topright", c("True", "Prediction"), lty=c(1,2), lwd=c(2.5,2.5),col=c("blue","red"))

#regression summary

summary(metrics.test$avg_blocker_count)
summary(metrics.test$pred_avg_blocker_count)
summary(model.lm)

#confusion matrix (requires caret)

cM <- table(truth=metrics.test$trueBlockerCategory, prediction=metrics.test$predBlockerCategory)
confusionMatrix(cM)