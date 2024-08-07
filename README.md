# Movie data analysis

This directory contains files related to the analysis of an IMDB movie dataset.

- The requirements files with all the packages used can be found in "codes and packages" in the script "packages.R".
- EDA and related questions can be found in "EDA".
- Modeling codes can be found in "codes and packages" in the script "neural_network.R".
- Codes related to data processing and the function for evaluating the models can be found in "codes and packages" in the script "preparation.R".
- Codes for other models that were tested can be found in "codes and packages/other_models".

## How to Install and Run the Project

The project was created using the R language through the IDE "RStudio". Therefore, to run the codes available in this repository, I recommend doing so on a computer with R and RStudio installed. Both can be downloaded from this [link](https://posit.co/download/rstudio-desktop/).

With R and RStudio installed, simply open and execute the files "packages.R", "preparation.R", and "neural_network.R" in sequence through RStudio. The "packages.R" file installs the necessary packages, "preparation.R" prepares the data for use in the model and creates a function to evaluate it, and "neural_network.R" creates the model. You can use "Ctrl+A" to select all the code and "Ctrl+Enter" to run all lines in sequence.

The model used for making predictions can also be found in "codes and packages" in the object "neural_network.RData". To load it in RStudio, use `load("neural_network.RData")`. However, to make predictions using this model, you need to process the data according to the "neural_network.R" script and standardize it according to the "standardization.R" script. Additionally, predictions need to be unstandardized according to the "neural_network.R" script.


