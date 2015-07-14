#least square regression

# Model 1: all continuous - bug

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}

#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#metrics <- metrics[1:30, ]
#training
model <- lm(avg_bug_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)
#result
summary(model)
#crossvalidate
shrinkage(model)

#Model 2: discritize bug (2 categories) and continuous metrices

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}

#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#transform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#2 category
metrics$Bug.Category <- ifelse(metrics$avg_bug_count<0.370, 1, 2)
#training
model.2 <- lm(Bug.Category ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)
summary(model.2)
#crossvalidate
shrinkage(model)


#Model 3: discritize bug (3 categories) and continuous metrices

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]

#3 category
metrics$Bug.Category <- ifelse(metrics$avg_bug_count<0.270, 1, 2)
metrics$Bug.Category <- ifelse(metrics$avg_bug_count>0.440, 3, metrics$Bug.Category)
#training
model <- lm(Bug.Category ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)
summary(model)
#crossvalidate
shrinkage(model)



#Model 4: discritize critical (3 categories) and continuous metrices

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_critical_count <- round(defect.metrics$critical_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_critical_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#3 category
metrics$Critical.Category <- ifelse(metrics$avg_critical_count<0.01000, 1, 2)
metrics$Critical.Category <- ifelse(metrics$avg_critical_count>0.04000, 3, metrics$Critical.Category)
#training
model.4 <- lm(Critical.Category ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)
summary(model.4)
#crossvalidate
shrinkage(model)


#Model 5: discritize blocker (3 categories) and continuous metrices

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_blocker_count <- round(defect.metrics$blocker_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_blocker_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#3 category
metrics$Blocker.Category <- ifelse(metrics$avg_blocker_count<0.01000, 1, 2)
metrics$Blocker.Category <- ifelse(metrics$avg_blocker_count>0.04000, 3, metrics$Blocker.Category)
#training
model.5 <- lm(Blocker.Category ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)
summary(model.5)
#crossvalidate
shrinkage(model)


#Model 6: discritize bug (3 categories) and discritize (2 categories) metrices

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#2 category
metrics$Bug.Category <- ifelse(metrics$avg_bug_count<0.270, 1, 2)
metrics$Bug.Category <- ifelse(metrics$avg_bug_count>0.440, 3, metrics$Bug.Category)
metrics$NOC.Category <- ifelse(metrics$NOC < 879, 1, 2)
metrics$WMC.Category <- ifelse(metrics$WMC < 3.915, 1, 2)
metrics$CBO.Category <- ifelse(metrics$CBO < 4.480, 1, 2)
metrics$RFC.Category <- ifelse(metrics$RFC < 11.140, 1, 2)
metrics$LCOM.Category <- ifelse(metrics$LCOM < 29.46, 1, 2)
metrics$Ca.Category <- ifelse(metrics$Ca < 1.760, 1, 2)
metrics$Ce.Category <- ifelse(metrics$Ce < 2.965, 1, 2)
metrics$LOC.Category <- ifelse(metrics$LOC < 85.86, 1, 2)
#training
model <- lm(Bug.Category ~ NOC.Category+WMC.Category+CBO.Category+RFC.Category+LCOM.Category+Ca.Category+Ce.Category+LOC.Category, data=metrics)
summary(model)
#crossvalidate
shrinkage(model)


#Model 7: discritize bug (3 categories) and discritize (3 categories) metrices

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#3 category
metrics$Bug.Category <- ifelse(metrics$avg_bug_count<0.270, 1, 2)
metrics$Bug.Category <- ifelse(metrics$avg_bug_count>0.440, 3, metrics$Bug.Category)
metrics$NOC.Category <- ifelse(metrics$NOC < 359, 1, 2)
metrics$NOC.Category <- ifelse(metrics$NOC > 1894, 3, metrics$NOC.Category)
metrics$WMC.Category <- ifelse(metrics$WMC < 3.175, 1, 2)
metrics$WMC.Category <- ifelse(metrics$WMC > 4.765, 3, metrics$WMC.Category)
metrics$CBO.Category <- ifelse(metrics$CBO < 3.708, 1, 2)
metrics$CBO.Category <- ifelse(metrics$CBO > 5.400, 3, metrics$CBO.Category)
metrics$RFC.Category <- ifelse(metrics$RFC < 9.435, 1, 2)
metrics$RFC.Category <- ifelse(metrics$RFC > 13.340, 3, metrics$RFC.Category)
metrics$LCOM.Category <- ifelse(metrics$LCOM < 16.33, 1, 2)
metrics$LCOM.Category <- ifelse(metrics$LCOM > 57.50, 3, metrics$LCOM.Category)
metrics$Ca.Category <- ifelse(metrics$Ca < 1.050, 1, 2)
metrics$Ca.Category <- ifelse(metrics$Ca > 2.360, 3, metrics$Ca.Category)
metrics$Ce.Category <- ifelse(metrics$Ce < 2.180, 1, 2)
metrics$Ce.Category <- ifelse(metrics$Ce > 3.555, 3, metrics$Ce.Category)
metrics$LOC.Category <- ifelse(metrics$LOC < 68.41, 1, 2)
metrics$LOC.Category <- ifelse(metrics$LOC > 115.20, 3, metrics$LOC.Category)
#training
model <- lm(Bug.Category ~ NOC.Category+WMC.Category+CBO.Category+RFC.Category+LCOM.Category+Ca.Category+Ce.Category+LOC.Category, data=metrics)
summary(model)
#crossvalidate
shrinkage(model)



#Model 8: Reduced model (discritize bug and continous predictor)

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "WMC", "CBO", "Ce")]
metrics$Bug.Category <- ifelse(metrics$avg_bug_count<0.270, 1, 2)
metrics$Bug.Category <- ifelse(metrics$avg_bug_count>0.440, 3, metrics$Bug.Category)
#training
model <- lm(Bug.Category ~ WMC+CBO+Ce, data=metrics)
summary(model)
#crossvalidate
shrinkage(model)


#Model 9: Reduced model (discritize bug and metrices)

#cross-validation method
shrinkage <- function(model, k=7){
  require(bootstrap)
  theta.fit <- function(x,y){lsfit(x,y)}
  theta.predict <- function(fit,x){cbind(1,x)%*%model$coef}
  x <- model$model[,2:ncol(model$model)]
  y <- model$model[,1]
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k)
  r2 <- cor(y, model$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2-r2cv, "\n")
}
#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "WMC", "CBO", "Ce")]
#3 category
metrics$Bug.Category <- ifelse(metrics$avg_bug_count<0.270, 1, 2)
metrics$Bug.Category <- ifelse(metrics$avg_bug_count>0.440, 3, metrics$Bug.Category)
metrics$WMC.Category <- ifelse(metrics$WMC < 3.175, 1, 2)
metrics$WMC.Category <- ifelse(metrics$WMC > 4.765, 3, metrics$WMC.Category)
metrics$CBO.Category <- ifelse(metrics$CBO < 3.708, 1, 2)
metrics$CBO.Category <- ifelse(metrics$CBO > 5.400, 3, metrics$CBO.Category)
metrics$Ce.Category <- ifelse(metrics$Ce < 2.180, 1, 2)
metrics$Ce.Category <- ifelse(metrics$Ce > 3.555, 3, metrics$Ce.Category)
#training
model <- lm(Bug.Category ~ WMC.Category+CBO.Category+Ce.Category, data=metrics)
summary(model)
#crossvalidate
shrinkage(model)



#data-mining

#loading
defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")
#tramsform
defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)
#extract
metrics <- defect.metrics[, c("avg_bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]
#3 category
metrics$Bug.Category <- factor(ifelse(metrics$avg_bug_count<0.270, 1, 2))
metrics$Bug.Category <- factor(ifelse(metrics$avg_bug_count>0.440, 3, metrics$Bug.Category))
metrics$NOC.Category <- ifelse(metrics$NOC < 359, 1, 2)
metrics$NOC.Category <- ifelse(metrics$NOC > 1894, 3, metrics$NOC.Category)
metrics$WMC.Category <- ifelse(metrics$WMC < 3.175, 1, 2)
metrics$WMC.Category <- ifelse(metrics$WMC > 4.765, 3, metrics$WMC.Category)
metrics$CBO.Category <- ifelse(metrics$CBO < 3.708, 1, 2)
metrics$CBO.Category <- ifelse(metrics$CBO > 5.400, 3, metrics$CBO.Category)
metrics$RFC.Category <- ifelse(metrics$RFC < 9.435, 1, 2)
metrics$RFC.Category <- ifelse(metrics$RFC > 13.340, 3, metrics$RFC.Category)
metrics$LCOM.Category <- ifelse(metrics$LCOM < 16.33, 1, 2)
metrics$LCOM.Category <- ifelse(metrics$LCOM > 57.50, 3, metrics$LCOM.Category)
metrics$Ca.Category <- ifelse(metrics$Ca < 1.050, 1, 2)
metrics$Ca.Category <- ifelse(metrics$Ca > 2.360, 3, metrics$Ca.Category)
metrics$Ce.Category <- ifelse(metrics$Ce < 2.180, 1, 2)
metrics$Ce.Category <- ifelse(metrics$Ce > 3.555, 3, metrics$Ce.Category)
metrics$LOC.Category <- ifelse(metrics$LOC < 68.41, 1, 2)
metrics$LOC.Category <- ifelse(metrics$LOC > 115.20, 3, metrics$LOC.Category)

metrics.dm <- metrics[, c("NOC.Category", "WMC.Category", "CBO.Category", "RFC.Category", "LCOM.Category", "Ca.Category", "Ce.Category", "LOC.Category", "Bug.Category")]

#naiveBayes
require(e1071)
?naiveBayes
nb <- naiveBayes(Bug.Category ~ ., data = metrics.dm, cross=5)
nb.pred <- predict(nb, metrics.dm)
table(nb.pred, metrics.dm$Bug.Category)

#svm
?svm
svm <- svm(Bug.Category ~ ., data = metrics.dm, cross=5)
svm.pred <- predict(svm, metrics.dm)
table(svm.pred, metrics.dm$Bug.Category)
