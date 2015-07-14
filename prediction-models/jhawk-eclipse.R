rm(list = ls())
jhawkdata <- read.csv("C:/Users/sharifhan/Desktop/eclipse-jhawk-metrics-v2.csv", quote=",", stringsAsFactors=FALSE)
jhawkdata <-  unique(jhawkdata)

heff <- jhawkdata[,c("HVOL1", "HVOL2")] 
write.csv(jhawkdata, file = "C:/Users/sharifhan/Desktop/jhawkdata.csv", quote=FALSE, row.names=FALSE)
heff <- read.csv("C:/Users/sharifhan/Desktop/heff.csv", quote=",", stringsAsFactors=FALSE)
jhawkdata <- cbind(jhawkdata, heff)

jhawkdata <- jhawkdata[,c("id", "class", "jClass", "method", "jMethod", "sLine", "eLine", "COMP", "NOCL", "NOS", "HLTH", "HVOC", "HEFF", "HBUG", "CREF", "XMET", "LMET", "NLOC", "NOC", "NOA", "MOD", "HDIF", "VDEC", "EXCT", "EXCR", "CAST", "TDN", "HVOL", "NAND", "VREF", "MDN", "NOPR", "NEXP", "LOOP", "defective")] 
rownames(jhawkdata) <- NULL

jhawkdata <- jhawkdata[jhawkdata$class == cars[i,1],]
d<-d[!(d$A=="B" & d$E==0),]

jhawkdata <- jhawkdata[!duplicated(jhawkdata[,c('class','jClass', "method")]),]

jhawkdata$defective <- as.factor(jhawkdata$defective)
summary(jhawkdata$defective)

