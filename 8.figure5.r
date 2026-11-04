rm(list=ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(reshape2)
library(tidyverse)
library(ggpubr)
library(rstatix)

df1<-read.csv('alpha.csv',header=T)
mygroup<-read.csv('group.csv',header=T)
colnames(mygroup)[1:2]<-c('sample', 'group')

mygroup$group<-factor(mygroup$group, levels = c("eDNA", "traditional"))
df2<-merge(df1,mygroup,by='sample')
myindex<-'Species_richness'
###The plotting code is identical for all indices; simply change the specific index here

df2$new<-df2[,myindex]

stat.test <- df2 %>%
  wilcox_test(new ~ group) 

# Box plots
stat.test <- stat.test %>% 
  add_xy_position(x = "group", dodge = 0.8,step.increase = 0.1)

stat.test$y.position
mycol<-c(eDNA = "#FDDDB8", traditional = "#8AD2AD")

stat.test$p.adj.signif<-cut(stat.test$p,breaks =c(0,0.001,0.01,0.05,1),
                        labels = c('***','**','*','ns')  )
ggboxplot(df2, x = "group", y = "new", fill = "group",
          add = c('jitter'),shape=21,
          bxp.errorbar = TRUE, bxp.errorbar.width = 0.25,
          add.params = list(size=3,alpha=0.5,width=0.5),
          outlier.shape = NA,
          width = 0.4)+ 
 stat_pvalue_manual(stat.test,   label = "p.adj.signif", tip.length = 0.02,
                    size = 6,
                     hide.ns = T)+
  scale_fill_manual(values = mycol)+
  labs(y=myindex,x=NULL)+
  theme_bw()+theme(legend.title = element_blank(),
                     legend.position = 'none',
    axis.title = element_text(face = 'bold',size=12),
    axis.text.x = element_text(size = 12),  
    axis.text.y = element_text(size = 12))  

stat.test2<-as.data.frame(apply(stat.test,2,as.character))
write.table(stat.test2,paste0('alpha.',myindex,'.boxplot.pdf.stat.xls'),row.names = F,sep = '\t',quote = F)

ggsave(paste0('alpha.',myindex,'.boxplot.pdf'),width = 4,height = 4)
