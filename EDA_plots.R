library(tidyverse)
library(gridExtra)
library(ggrepel)

DF <- read.table("TCGA_sample.txt", header = T) 
DF.Center <- read.csv("derived_data/TCGA.centered.csv")

##### Density Plots #####

g1 <- DF.Center %>% 
  ggplot(aes(x=Gene.1)) +
  geom_density(col = "Blue") +
  theme_minimal() +
  labs(title = "Density of Gene 1", 
       y = "Density", 
       x = "Gene 1")

g2 <- DF.Center %>% 
  ggplot(aes(x=Gene.100)) +
  geom_density(col = "Red") +
  theme_minimal() +
  labs(title = "Density of Gene 100", 
       y = "Density", 
       x = "Gene 100")

g3 <- DF.Center %>% 
  ggplot(aes(x=Gene.1000)) +
  geom_density(col = "Green") +
  theme_minimal() +
  labs(title = "Density of Gene 1000", 
       y = "Density", 
       x = "Gene 1000")

graph1 <- grid.arrange(g1, g2, g3)

ggsave("derived_graphics/Gene.Density.Plot.png", plot = graph1)

##### Hypothesis test plot #####

Hypo.dat <- data.frame("Gene 2" = DF$Gene.2, 
                       "Gene 200" = DF$Gene.200)
graph2 <- Hypo.dat %>% 
  pivot_longer(cols = c(1, 2), names_to = "Gene", values_to = "Value") %>% 
  ggplot(aes(x=Gene, y=Value)) +
  geom_violin(aes(col = Gene)) +
  stat_summary(fun=mean, geom="point", shape=20, size=5, color="red", fill="red") +
  theme_minimal()

ggsave("derived_graphics/Hypothesis.Test.Plot.png", plot = graph2)

##### Mean Vs. SD Plot #####

Means <- rowMeans(DF[,-1])
SDs <- apply(DF[,-1], 1, sd)

M.SD <- data.frame(
  "Mean" = Means, 
  "SD" = SDs
)

graph3 <- M.SD %>% 
  ggplot(aes(x=Mean, y=SD)) +
  geom_point(fill = "Purple", alpha = .75, col = "black", pch = 21) +
  labs(title = "Mean vs. Standard Deviation") +
  geom_text_repel(data = M.SD %>% filter(SD>1.9), aes(label = "Potential Outlier"), hjust = -.5) +
  theme_minimal()

ggsave("derived_graphics/Mean.SD.Plot.png", plot = graph3)
ggsave("README_graphics//Mean.SD.Plot.png", plot = graph3)