rm(list = ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(vegan)
library(FD)
library(ape)
library(phytools)
library(betapart)

fish<-read.csv("species.csv",header=T, row.names=1,sep=",")
fish <- ifelse(fish > 0, 1, 0)
fish <- as.data.frame(fish)
t_fish<-t(fish)

trait<-read.csv("trait.csv",header=T, row.names=1, sep=",")

tree <- read.tree("fish_tree.nwk")

gower.f<-gowdis(trait)   # Gower’s distance analysis
pcoa.f<-pcoa(gower.f,rn=NULL )   # PCoA analysis
Fun_pcoa<-pcoa.f$vectors[,1:3]    # keep the first three axes of PCoA as the synthetic functional traits

SR_beta<- beta.pair(t_fish, index.family="sorensen")
FD_beta<- functional.beta.pair(t_fish, Fun_pcoa, index.family="sorensen")
PD_beta<- phylo.beta.pair(t_fish, tree, index.family = "sorensen")

SR.sor<-as.matrix(SR_beta$beta.sor)
SR.sim<-as.matrix(SR_beta$beta.sim)
SR.sne<-as.matrix(SR_beta$beta.sne)
FD.sor<-as.matrix(FD_beta$funct.beta.sor)
FD.sim<-as.matrix(FD_beta$funct.beta.sim)
FD.sne<-as.matrix(FD_beta$funct.beta.sne)
PD.sor<-as.matrix(PD_beta$phylo.beta.sor)
PD.sim<-as.matrix(PD_beta$phylo.beta.sim)
PD.sne<-as.matrix(PD_beta$phylo.beta.sne)
#average beta between sampling sites, for M sampling sites, the summary should be divided by (M-1).
Beta_bs<-cbind(colSums(FD.sor)/ (6-1), colSums(FD.sim)/ (6-1), colSums(FD.sne)/ (6-1), 
               colSums(PD.sor)/ (6-1), colSums(PD.sim)/ (6-1), colSums(PD.sne)/ (6-1),
               colSums(SR.sor)/ (6-1), colSums(SR.sim)/ (6-1), colSums(SR.sne)/ (6-1))
colnames(Beta_bs)=c('avg_FD.sor', 'avg_FD.sim', 'avg_FD.sne',  'avg_PD.sor', 'avg_PD.sim', 'avg_PD.sne', 
                    'avg_SR.sor',  'avg_SR.sim',  'avg_SR.sne')

write.csv(Beta_bs, file = "tax_phy_fun.beta.csv", row.names = FALSE)