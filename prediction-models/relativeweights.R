defect.metrics.v2 <- read.csv("C:/Users/sharifhan/Desktop/defect-metrics-v2.csv", quote="'")

metrics <- defect.metrics.v2[, c("bug_count", "NOC", "WMC", "CBO", "RFC", "LCOM", "Ca", "Ce", "LOC")]

model <- lm(bug_count ~ NOC+WMC+CBO+RFC+LCOM+Ca+Ce+LOC, data=metrics)

relweights <- function(fit,...){
  R <- cor(model$model)
  nvar <- ncol(R)
  rxx <- R[2:nvar, 2:nvar]
  rxy <- R[2:nvar, 1]
  svd <- eigen(rxx)
  evec <- svd$vectors
  ev <- svd$values
  delta <- diag(sqrt(ev))
  lambda <- evec %*% delta %*% t(evec)
  lambdasq <- lambda ^ 2
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta ^ 2)
  rawwgt <- lambdasq %*% beta ^ 2
  import <- (rawwgt / rsquare) * 100
  lbls <- names(fit$model[2:nvar])
  rownames(import) <- lbls
  colnames(import) <- "Weights"
  barplot(t(import),names.arg=lbls,
          ylab="% of R-Square",
          xlab="Predictor Variables",
          main="Relative Importance of Software Metrics",
          sub=paste("R-Square=", round(rsquare, digits=3)),
          ...)
  return(import)
}

relweights(model, col="lightgray")
