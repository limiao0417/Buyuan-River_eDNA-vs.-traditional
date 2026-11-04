rm(list = ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(iNEXT)
library(ggplot2) 

mydata <- read.csv("species.csv", header = T,row.names = 1) 

View(mydata)

result<- iNEXT(mydata, q=0, datatype="abundance") 
result$DataInfo 
result$AsyEst
result$iNextEst
write.csv(result$DataInfo , file = "traditional_iNEXT.csv", row.names = FALSE)

ggiNEXT(result, type=1, grey=F)
###The plotting code used for eDNA and traditional methods is the same