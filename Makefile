.PHONY: clean

clean:
	rm derived_data/*.csv
	rm derived_graphics/*.png
	rm README_graphics/*.png
	rm derived_models/*.rds
	
# Tidy data first
derived_data/TCGA.centered.csv:\
 TCGA_sample.txt\
 tidy_data.R
	Rscript tidy_data.R
	
# EDA Plots
README_graphics//Mean.SD.Plot.png\
derived_graphics/Mean.SD.Plot.png\
derived_graphics/Hypothesis.Test.Plot.png\
derived_graphics/Gene.Density.Plot.png:\
 TCGA_sample.txt\
 derived_data/TCGA.centered.csv\
 EDA_plots.R
	Rscript EDA_plots.R
	
# PCA Plots
derived_graphics/PCA.3.Pairs.Plot.png\
derived_graphics/PCA.80.Plot.png\
derived_graphics/PCA.Screeplot.png:\
 derived_data/TCGA.centered.csv\
 PCA_plots.R
	Rscript PCA_plots.R
	
# Cluster Plots
derived_graphics/WSS.Optimal.Cluster.Plot.png\
derived_graphics/silhou.Optimal.Cluster.Plot.png\
README_graphics//K-Means.Cluster.Plot.png\
derived_graphics/K-Means.Cluster.Plot.png\
derived_graphics/Dendrogram.Cluster.Plot.png:\
 derived_data/TCGA.centered.csv\
 cluster_plots.R
	Rscript cluster_plots.R
	
# Classification
README_graphics/Confusion.Table.rds\
derived_graphics/Confusion.Table.rds\
derived_models/Test.Knn.Mod.rds:\
 derived_data/TCGA.centered.csv\
 classification.R
	Rscript classification.R