rm(list = ls())

setwd("~/环科院/paper/Reviews in Fish Biology and Fisheries/code")

library(reshape2)
library(ggplot2)
library(ggalluvial)
library(ggh4x)

###traditional methods
data <- read.csv("species.csv", header = TRUE, row.names = 1, sep = ",")

data$sum <- rowSums(data)

data1 <- data[order(data$sum, decreasing = TRUE), ]

data1 <- data1[, -which(names(data1) == "sum")]

top10_OTUs <- rownames(data1)[1:10]

data_top10 <- data1[rownames(data1) %in% top10_OTUs, ]
data2 <- sweep(data_top10, 2, colSums(data1), FUN = "/")

data3 <- 1 - apply(data2, 2, sum)

data3 <- rbind(data2, data3)
rownames(data3)[nrow(data3)] <- "Others"

data3$Taxonomy <- factor(rownames(data3), levels = rev(rownames(data3)))

data4 <- melt(data3, id = "Taxonomy")

colors <- c("#B2182B", "#E69F00", "#56B4E9", "#009E73", "#F0E442",
            "#0072B2", "#D55E00", "#CC79A7",
            "#9999CC", "#66CC99", 
            "#F39B7FB2", "#91D1C2B2", "#CC6666",
            "#8491B4B2", "#DC0000B2",
            "#7E6148B2", "yellow", "#3C5488B2", "#00A087B2",
            "darkolivegreen1", "lightskyblue")

num_categories <- length(unique(data4$Taxonomy))

if (length(colors) < num_categories) {
  warning("The number of colors is less than the number of categories. Colors will be recycled.")
}

p1 <- ggplot(data4, aes(x = variable, y = value, fill = Taxonomy)) + 
  geom_bar(stat = "identity", position = 'stack', width = 0.6) + 
  scale_fill_manual(values = colors) +  
  ylab("Relative abundance") + 
  xlab("Sampling sites") +  
  theme(panel.background = element_rect(fill = "white", color = "black"),
        panel.grid = element_blank(),
        legend.position = "right",
        legend.text = element_text(size = 13, face = "italic"),  
        axis.text.x = element_text(angle = 30, hjust = 1, size = 12),  
        axis.text.y = element_text(size = 12),  
        axis.title.x = element_text(size = 13),  
        axis.title.y = element_text(size = 13))+  
  guides(fill = guide_legend(ncol = 1))  

p1

ggsave("species.pdf", plot = p1, width = 8, height = 6)



###eDNA metabarcoding
data <- read.csv("species_eDNA.csv", header = TRUE, row.names = 1, sep = ",")

data$sum <- rowSums(data)

data1 <- data[order(data$sum, decreasing = TRUE), ]

data1 <- data1[, -which(names(data1) == "sum")]

top10_OTUs <- rownames(data1)[1:10]

data_top10 <- data1[rownames(data1) %in% top10_OTUs, ]
data2 <- sweep(data_top10, 2, colSums(data1), FUN = "/")

data3 <- 1 - apply(data2, 2, sum)

data3 <- rbind(data2, data3)
rownames(data3)[nrow(data3)] <- "Others"

data3$Taxonomy <- factor(rownames(data3), levels = rev(rownames(data3)))

data4 <- melt(data3, id = "Taxonomy")

### Use consistent colors for the same species
colors <- c("#B2182B","#CC79A7", "#009E73","#E69F00","#7E6148B2", "yellow", "#3C5488B2", "#00A087B2",
            "darkolivegreen1", "lightskyblue","#9999CC")

num_categories <- length(unique(data4$Taxonomy))

if (length(colors) < num_categories) {
  warning("The number of colors is less than the number of categories. Colors will be recycled.")
}

p1 <- ggplot(data4, aes(x = variable, y = value, fill = Taxonomy)) + 
  geom_bar(stat = "identity", position = 'stack', width = 0.6) + 
  scale_fill_manual(values = colors) +
  ylab("Relative abundance") + 
  xlab("Sampling sites") +  
  theme(panel.background = element_rect(fill = "white", color = "black"),
        panel.grid = element_blank(),
        legend.position = "right",
        legend.text = element_text(size = 13, face = "italic"),  
        axis.text.x = element_text(angle = 30, hjust = 1, size = 12),  
        axis.text.y = element_text(size = 12),  
        axis.title.x = element_text(size = 13),  
        axis.title.y = element_text(size = 13))+  
  guides(fill = guide_legend(ncol = 1)) 

p1

ggsave("species_eDNA.pdf", plot = p1, width = 8, height = 6)
