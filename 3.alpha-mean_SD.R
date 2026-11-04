rm(list = ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(dplyr)
library(openxlsx)

alpha<-read.csv("alpha.csv",header=T, row.names=1,sep=",")
head(alpha) 

#taxonomic diversity
Species_richness_mean <- mean(alpha$Species_richness)
Species_richness_sd <- sd(alpha$Species_richness)

Pielou_mean <- mean(alpha$Pielou)
Pielou_sd <- sd(alpha$Pielou)

Shannon_mean <- mean(alpha$Shannon)
Shannon_sd <- sd(alpha$Shannon)

#phylogenetic diversity
PD_whole_tree_mean <- mean(alpha$PD_whole_tree)
PD_whole_tree_sd <- sd(alpha$PD_whole_tree)

PSE_mean <- mean(alpha$PSE)
PSE_sd <- sd(alpha$PSE)

PSC_mean <- mean(alpha$PSC)
PSC_sd <- sd(alpha$PSC)

#functional diversity
FRic_mean <- mean(alpha$FRic)
FRic_sd <- sd(alpha$FRic)

FEve_mean <- mean(alpha$FEve)
FEve_sd <- sd(alpha$FEve)

FDiv_mean <- mean(alpha$FDiv)
FDiv_sd <- sd(alpha$FDiv)

result <- data.frame(  Variable = c("Species_richness", "Pielou", "Shannon", "FPD_whole_tree", "PSE", "PSC","FEve","FDiv","FRic"),  
                       Mean = c(Species_richness_mean, Pielou_mean, Shannon_mean, PD_whole_tree_mean, PSE_mean, PSC_mean,FEve_mean, FDiv_mean, FRic_mean),  
                       SD = c(Species_richness_sd, Pielou_sd, Shannon_sd, PD_whole_tree_sd, PSE_sd, PSC_sd,FEve_sd, FDiv_sd, FRic_sd))

result$Mean_SD <- paste(round(result$Mean, 2), "±", round(result$SD, 2))

wb <- createWorkbook()

addWorksheet(wb, "Mean and SD")

writeData(wb, "Mean and SD", result, startRow = 1, startCol = 1)

saveWorkbook(wb, "alpha_mean_sd.xlsx", overwrite = TRUE)
