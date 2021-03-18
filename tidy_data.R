# Load data and libs

library(tidyverse)

DF <- read.table("TCGA_sample.txt", header = T) 

DF.Center <- data.frame(
  "Subtype" = DF$Subtype
)
DF.Center <- cbind(DF.Center, scale(DF[, -1], scale = T, center = T))

write.csv(DF.Center, "derived_data/TCGA.centered.csv")