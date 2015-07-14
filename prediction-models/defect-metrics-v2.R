defect.metrics <- read.csv("C:/Users/sharifhan/Downloads/defect-metrics-v2.csv", quote="'")

defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
defect.metrics$avg_critical_count <- round(defect.metrics$critical_count/defect.metrics$project_count, 2)
defect.metrics$avg_blocker_count <- round(defect.metrics$blocker_count/defect.metrics$project_count, 2)

#defect.metrics$avg_critical_count_no_zero <- ifelse(defect.metrics$avg_critical_count==0, 0.01, defect.metrics$avg_critical_count)

metrics <- defect.metrics[, c("avg_critical_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]

#metrics <- defect.metrics.v2[, c("bug_count", "CBO", "Ce")]

metrics.train <- metrics[1:30, ]
metrics.test <- metrics[31:62, ]

remove(model.glm)
remove(model.lm)

model.lm <- lm(avg_critical_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics.train)
model.glm <- glm(avg_bug_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, metrics.train, family=gaussian)
model.cross <- lm(avg_bug_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)

#ave bug count
metrics.test$pred_avgBugCount_LM <- round(predict(model.lm, newdata=metrics.test), 2)
metrics.test$pred_avgBugCount_GLM <- round(predict(model.glm, newdata=metrics.test, type="response"), 2)

#ave critical bug
metrics.test$pred_criticalBugCount_LM <- round(predict(model.lm, newdata=metrics.test), 2)


#Discretization bug count
metrics.test$trueBugCategory <- ifelse(metrics.test$avg_bug_count<0.2000, "Low", "999")
metrics.test$predBugCategory <- ifelse(metrics.test$pred_avgBugCount_LM<0.2000, "Low", "999")

metrics.test$trueBugCategory <- ifelse(metrics.test$avg_bug_count>0.3800, "High", metrics.test$trueBugCategory)
metrics.test$predBugCategory <- ifelse(metrics.test$pred_avgBugCount_LM>0.3800, "High", metrics.test$predBugCategory)

metrics.test$trueBugCategory <- ifelse(metrics.test$trueBugCategory==999, "Medium", metrics.test$trueBugCategory)
metrics.test$predBugCategory <- ifelse(metrics.test$predBugCategory==999, "Medium", metrics.test$predBugCategory)

#Discretization critical bug
metrics.test$trueCriticalCategory <- ifelse(metrics.test$avg_critical_count<0.02000, "Low", "999")
metrics.test$predCriticalCategory <- ifelse(metrics.test$pred_criticalBugCount_LM<0.02000, "Low", "999")

metrics.test$trueCriticalCategory <- ifelse(metrics.test$avg_critical_count>0.02781, "High", metrics.test$trueCriticalCategory)
metrics.test$predCriticalCategory <- ifelse(metrics.test$pred_criticalBugCount_LM>0.02781, "High", metrics.test$predCriticalCategory)

metrics.test$trueCriticalCategory <- ifelse(metrics.test$trueCriticalCategory==999, "Medium", metrics.test$trueCriticalCategory)
metrics.test$predCriticalCategory <- ifelse(metrics.test$predCriticalCategory==999, "Medium", metrics.test$predCriticalCategory)


#Plotting average bug

plot (c(-0.6, 1), c(0.0, 5), type="n", cex=4, xlab="Average reported bugs", ylab="Density")
lines(density(metrics.test$avg_bug_count), col="blue", lwd=2.5)
lines(density(metrics.test$pred_avgBugCount_LM), col="red", lwd=1.5, lty = "dashed")
legend("topleft", c("True", "Prediction"), lty=c(1,1), lwd=c(2.5,2.5),col=c("blue","red"))

cM <- table(truth=metrics.test$trueBugCategory, prediction=metrics.test$predBugCategory)
#library(caret)
confusionMatrix(cM)

#Plotting critical bug

plot (c(-0.1, 0.2), c(0.0, 35), type="n", cex=4, xlab="Average reported critical bugs", ylab="Density")
lines(density(metrics.test$avg_critical_count  ), col="blue", lwd=2.5)
lines(density(metrics.test$pred_criticalBugCount_LM), col="red", lwd=1.5, lty = "dashed")
legend("topright", c("True", "Prediction"), lty=c(1,1), lwd=c(2.5,2.5),col=c("blue","red"))
cM <- table(truth=metrics.test$trueCriticalCategory, prediction=metrics.test$predCriticalCategory)
#library(caret)
print(cM)
confusionMatrix(cM)


# cross validated with entire data set
metrics$predBug_CountLM <- round(predict(model.cross, newdata=metrics), 2)

metrics$actualBugCategory <- ifelse(metrics$bug_count<84.0, "Low", "999")
metrics$predBugCategory <- ifelse(metrics$predBug_CountLM<84.0, "Low", "999")

metrics$actualBugCategory <- ifelse(metrics$bug_count>137.8, "High", metrics$actualBugCategory)
metrics$predBugCategory <- ifelse(metrics$predBug_CountLM>137.8, "High", metrics$predBugCategory)

metrics$actualBugCategory <- ifelse(metrics$actualBugCategory==999, "Medium", metrics$actualBugCategory)
metrics$predBugCategory <- ifelse(metrics$predBugCategory==999, "Medium", metrics$predBugCategory)

cM <- table(truth=metrics.test$trueBugCategory, prediction=metrics.test$predBugCategory)
print(cM)



#


ggplot(data=metrics.test,aes(x=predLogBug_Count,y=log(bug_count,base=10))) + geom_point(alpha=0.2,color="black")  + geom_smooth(aes(x=predLogBug_Count, y=log(bug_count,base=10)),color="black")  + geom_line(aes(x=log(bug_count,base=10), y=log(bug_count,base=10)),color="blue",linetype=2)

ggplot(data=metrics.test,aes(x=predLogBug_Count, y=predLogBug_Count-log(bug_count,base=10))) + geom_point(alpha=0. ,color="black") + geom_smooth(aes(x=predLogBug_Count, y=predLogBug_Count-log(bug_count,base=10)), color="black")

rsq <- function(y,f) { 1 - sum((y-f)^2)/sum((y-mean(y))^2) }

rsq(log(metrics.train$bug_count,base=10),predict(model,newdata=metrics.train))

rsq(log(metrics.test$bug_count,base=10),predict(model,newdata=metrics.test))

rmse <- function(y, f) { sqrt(mean( (y-f)^2 )) }

rmse(log(metrics.train$bug_count,base=10),predict(model,newdata=metrics.train))

rmse(log(metrics.test$bug_count,base=10),predict(model,newdata=metrics.test))

round(coefficients(model), 5)

summary(model)
