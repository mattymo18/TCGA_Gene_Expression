# load data and libs
library(tidyverse)
library(factoextra)
library(ggrepel)
library(cluster)

DF.Center <- read.csv("derived_data/TCGA.centered.csv") %>% 
  select(-X)

#set seed
set.seed(315)

#seems like 2 clusters might be a good option

graph1 <- fviz_nbclust(DF.Center[, -1], kmeans, method = "wss")
ggsave("derived_graphics/WSS.Optimal.Cluster.Plot.png", plot = graph1)
#confirms two is probably good

graph2 <- fviz_nbclust(DF.Center[, -1], kmeans, method = "silhouette")
ggsave("derived_graphics/silhou.Optimal.Cluster.Plot.png", plot = graph2)
#another method just to be safe that 2 is reasonable

# Proceed with kmeans 2 clusters

k2 <- kmeans(DF.Center[, -1], centers = 2, nstart = 10)

graph3 <- fviz_cluster(k2, data = DF.Center[, -1], geom = "point") +
  geom_point(aes(shape = DF.Center$Subtype), alpha = .7) +
  theme_minimal() +
  guides(col = F) +
  guides(fill = F) +
  scale_shape_discrete(name = "Cluster", breaks = c("Basal", "Normal")) 
ggsave("derived_graphics/K-Means.Cluster.Plot.png", plot = graph3)
ggsave("README_graphics//K-Means.Cluster.Plot.png", plot = graph3)

#Let's try one hierarchichal to see if it reaches a similar conclusion
res.hc <- eclust(DF.Center[, -1], "hclust", nboot = 5)
graph4 <- fviz_dend(res.hc, rect = TRUE) 
ggsave("derived_graphics/Dendrogram.Cluster.Plot.png", plot = graph4)
#I think it is fairly safe to say there are two clusters