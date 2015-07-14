## bug category
#loading

defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")

#tramsform

defect.metrics$avg_bug_count <- round(defect.metrics$bug_count/defect.metrics$project_count, 2)

#pre-extract
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

#extract
metrics <- metrics[, c("NOC.Category", "WMC.Category", "CBO.Category", "RFC.Category", "LCOM.Category", "Ca.Category", "Ce.Category", "LOC.Category", "Bug.Category")]

#testing
metrics.train <- metrics[1:30, ]
metrics.test <- metrics[31:62, ]

#model fitting
model.bug <- lm(Bug.Category ~ NOC.Category+WMC.Category+CBO.Category+RFC.Category+LCOM.Category+Ca.Category+Ce.Category+LOC.Category, data=metrics.test)


summary(model.bug)
#ave bug count
#metrics.test$pred.Bug.Category <- round(predict(model.3category, newdata=metrics.test), 0)




## critical category
#loading

defect.metrics <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")

#tramsform

defect.metrics$avg_critical_count <- round(defect.metrics$critical_count/defect.metrics$project_count, 2)

#pre-extract
metrics <- defect.metrics[, c("avg_critical_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]


metrics$Critical.Category <- ifelse(metrics$avg_critical_count<0.270, 1, 2)
metrics$Critical.Category <- ifelse(metrics$avg_critical_count>0.440, 3, metrics$Critical.Category)

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

#extract
metrics <- metrics[, c("NOC.Category", "WMC.Category", "CBO.Category", "RFC.Category", "LCOM.Category", "Ca.Category", "Ce.Category", "LOC.Category", "Critical.Category")]

#testing
metrics.train <- metrics[1:30, ]
metrics.test <- metrics[31:62, ]

#model fitting
model.3category <- lm(Critical.Category ~ NOC.Category+WMC.Category+CBO.Category+RFC.Category+LCOM.Category+Ca.Category+Ce.Category+LOC.Category, data=metrics.test)

summary(model.3category)
#ave bug count
#metrics.test$pred.Bug.Category <- round(predict(model.3category, newdata=metrics.test), 0)

