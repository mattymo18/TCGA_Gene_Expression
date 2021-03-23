library(tidyverse)

DF.Center <- read.csv("derived_data/TCGA.centered.csv") %>% 
  select(-X)

PCA <- prcomp(DF.Center[,-1])

###### screeplot #####
png(file = "derived_graphics/PCA.Screeplot.png", width = 1000, height = 1000)
screeplot(PCA, type = "line", npcs = 60)
dev.off()

##### 80% Plot ######
pcaCharts <- function(x) {
  x.var <- x$sdev ^ 2
  x.pvar <- x.var/sum(x.var)
  plot(cumsum(x.pvar), 
       xlab="Principal component", 
       ylab="Cumulative Proportion of Variance Explained", 
       ylim=c(0,1),
       type='b')
  abline(h = .8, col = "blue")
  abline(v = 58, col = "blue")
}


png(file = "derived_graphics/PCA.80.Plot.png", width = 1000, height = 1000)
pcaCharts(PCA)
dev.off()

##### pairs plot #####
Subtype <- factor(DF.Center[,1])


png(file = "derived_graphics/PCA.3.Pairs.Plot.png", width = 1000, height = 1000)
pairs(PCA$x[,1:3], col = Subtype)
dev.off()

