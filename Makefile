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