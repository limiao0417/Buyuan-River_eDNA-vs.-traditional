rm(list=ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(eulerr)

fit <- euler(c(eDNA = 5, traditional = 1, "eDNA&traditional" = 7))

pdf("Family.pdf", width = 6, height = 5)

plot(fit, 
     quantities = TRUE, 
     labels = c("eDNA", "traditional"),
     fills = c("#FDDDB8", "#8AD2AD"),
     main = "Family level")

dev.off()
###The plotting code for the genus and species taxonomic levels is the same as that described above