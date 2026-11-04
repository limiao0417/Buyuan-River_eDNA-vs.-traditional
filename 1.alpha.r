rm(list=ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(vegan)
library(ape)
library(picante)
library(FD)
library(fastDummies)

###Calculation of taxonomic diversity
df<-read.csv("species.csv",header = TRUE, row.names = 1)
Shannon<-diversity(df, index = "shannon", MARGIN = 2)
Richness <- specnumber(df,MARGIN = 2) #spe.rich == sobs
pielou <- Shannon / log(Richness, exp(1))
index<-as.data.frame(cbind(Shannon,Richness,pielou))

write.table(cbind(sample=c(rownames(index)),index),'tax.txt',  row.names = F,sep = '\t',quote = F)

###Calculation of phylogenetic diversity

tree <- read.tree('fish_tree.nwk')
PD_whole_tree <- pd(tdf, tree, include.root = FALSE)
PD_whole_tree
PD_result <- data.frame(PD_whole_tree = PD_whole_tree$PD, row.names = rownames(PD_whole_tree))

PSD <- psd(tdf, tree)
PSD
PSD_result <- as.data.frame(PSD)

all_results <- cbind(PD_result, PSD_result, MPD_result[rownames(PD_result), ], MNTD_result[rownames(PD_result), ])
all_results <- cbind(sample = rownames(all_results), all_results)

write.table(all_results, "phy.txt", row.names = FALSE, sep = "\t", quote = FALSE)

###Calculation of functional diversity
trait <- read.csv("trait.csv",header = TRUE, row.names = 1)

dist_matrix <- gowdis(trait)
head(dist_matrix)

fd <- dbFD(x = trait, a = tdf)
fd
fd <- data.frame(sample = names(fd$FRic), 
                    FRic = fd$FRic,
                    FEve = fd$FEve,
                    FDiv = fd$FDiv,
                    FDis = fd$FDis,
                    RaoQ = fd$RaoQ,
                    check.names = FALSE)
write.table(fd, file = "fun.txt", row.names = FALSE, sep = "\t", quote = FALSE)