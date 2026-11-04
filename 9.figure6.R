rm(list=ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")
      
library(ggplot2)
library(ggpubr)
library(ggsci)

data <- read.csv("Beta_TD.csv", header = TRUE, row.names = NULL)

head(data)

ggplot(data, aes(x = factor(TD, levels = c("sor", "sim", "sne")), 
                 y = beta_diversity, 
                 color = group)) +
  geom_boxplot(
    outlier.colour = NA,
    size = 0.6,
    width = 0.4,
    fill = "transparent",
    staplewidth = 0,
    position = position_dodge(0.6)
  ) +
  
  scale_color_manual(values = c(eDNA = "#FDDDB8", traditional = "#8AD2AD")) +
  coord_cartesian(ylim = c(0, 1)) +
  labs(x = "phylogenetic_diversity", y = "beta_diversity") +
  theme_classic() +
  stat_compare_means(
    aes(group = group),
    method = "wilcox.test",
    label = "p.format",
    label.y = 1,
    label.x = 1.5,
    size = 3
  )

ggsave("boxplot_PD.pdf", width = 4, height = 4)
###The plotting code for phylogenetic and functional beta diversity is the same as that for taxonomic beta diversity