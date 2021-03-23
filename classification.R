# data and libs
library(tidyverse)
library(class)
library(knitr)
library(kableExtra)
webshot::install_phantomjs()

DF.Center <- read.csv("derived_data/TCGA.centered.csv") %>% 
  select(-X)

#set seed
set.seed(315)

# Break into train and test sets.
#Sample the rows for the training set
index <-sample(1:nrow(DF.Center),round(nrow(DF.Center)*0.8)) 
DF_train<-DF.Center[index,-1] #Training set
train_class<-as.factor(DF.Center[index,1]) #classifications of training set
DF_test<-DF.Center[-index,-1] #Test set
test_class<-as.factor(DF.Center[-index,1]) #Classifications of test set

# Run classification algorithm.
CL_train=knn(DF_train, DF_train, train_class, k=3)

# Compute accuracy on test set.
CL_test=knn(DF_train, DF_test, train_class, k=3)


# Find classes where the algorithm performed best / worst.
confusion.mat <- as.matrix(table(Actual = test_class, Predicted = CL_test))
Confusion <- kable(confusion.mat) %>% 
  kable_styling() %>% 
  save_kable(file = "derived_graphics/Confusion.Table.png", zoom = 1)
Confusion <- kable(confusion.mat) %>% 
  kable_styling() %>% 
  save_kable(file = "README_graphics/Confusion.Table.png", zoom = 1)


saveRDS(CL_test, "derived_models/Test.Knn.Mod.rds")