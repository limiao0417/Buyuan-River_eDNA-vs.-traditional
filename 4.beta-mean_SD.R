rm(list = ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(dplyr)
library(openxlsx)
beta<-read.csv("Beta.csv",header=T, row.names=1,sep=",")
head(beta) 

#functional diversity
avg_FD.sor_mean <- mean(beta$avg_FD.sor)
avg_FD.sor_sd <- sd(beta$avg_FD.sor)

avg_FD.sim_mean <- mean(beta$avg_FD.sim)
avg_FD.sim_sd <- sd(beta$avg_FD.sim)

avg_FD.sne_mean <- mean(beta$avg_FD.sne)
avg_FD.sne_sd <- sd(beta$avg_FD.sne)

#taxonomic diversity
avg_SR.sor_mean <- mean(beta$avg_SR.sor)
avg_SR.sor_sd <- sd(beta$avg_SR.sor)

avg_SR.sim_mean <- mean(beta$avg_SR.sim)
avg_SR.sim_sd <- sd(beta$avg_SR.sim)

avg_SR.sne_mean <- mean(beta$avg_SR.sne)
avg_SR.sne_sd <- sd(beta$avg_SR.sne)

#phylogenetic diversity
phylosor_mean <- mean(beta$phylosor)
phylosor_sd <- sd(beta$phylosor)

phylosim_mean <- mean(beta$phylosim)
phylosim_sd <- sd(beta$phylosim)

phylosne_mean <- mean(beta$phylosne)
phylosne_sd <- sd(beta$phylosne)

result <- data.frame(  Variable = c("avg_FD.sor", "avg_FD.sim", "avg_FD.sne", "avg_SR.sor", "avg_SR.sim", "avg_SR.sne","phylosim","phylosne","phylosor"),  
                       Mean = c(avg_FD.sor_mean, avg_FD.sim_mean, avg_FD.sne_mean, avg_SR.sor_mean, avg_SR.sim_mean, avg_SR.sne_mean,phylosim_mean, phylosne_mean, phylosor_mean),  
                       SD = c(avg_FD.sor_sd, avg_FD.sim_sd, avg_FD.sne_sd, avg_SR.sor_sd, avg_SR.sim_sd, avg_SR.sne_sd,phylosim_sd, phylosne_sd, phylosor_sd))

result$Mean_SD <- paste(round(result$Mean, 2), "±", round(result$SD, 2))

wb <- createWorkbook()

addWorksheet(wb, "Mean and SD")

writeData(wb, "Mean and SD", result, startRow = 1, startCol = 1)

saveWorkbook(wb, "beta_mean_sd.xlsx", overwrite = TRUE)
