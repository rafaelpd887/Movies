# About

This README.md aims to give details about this project.

## What variables and/or transformations where used and why?

The variables/columns excluded from the dataset for building the IMDb rating prediction model were: Series_Title, Genre, Overview, Director, Star1, Star2, Star3, Star4, as well as the first column, which referred to the enumeration of observations. They were excluded from the dataset before building the model because, as explained in the Exploratory Data Analysis (EDA), they all showed statistically insignificant significance for the target variable, considering a 95% confidence level.

As for transformations, dummy encoding was applied to the categorical variable Certificate, and for building the neural network, I chose to normalize all numerical values between 0 and 1. Therefore, it was also necessary to standardize the data for the movie "The Shawshank Redemption" before making predictions for it. The standardization of "The Shawshank Redemption" data was done using the same maximum and minimum values from the data used in the model creation.

After prediction, it was necessary to unstandardize the result, as it was on the same scale as the standardized data, to obtain the actual IMDb rating for "The Shawshank Redemption."

## How a Prediction for the IMDb Rating Could Be Made?

First, I sought to understand the data using my domain knowledge. I aimed to identify which variables in the dataset are likely to have the most influence on the IMDb rating.

Next, I prepared the data for creating a predictive model. I removed columns that I considered unnecessary or that might add undue complexity to the model, and I corrected any errors in the data, such as missing values or incorrect variable typing.

Then, I tested various algorithms that I deemed suitable for the data and the predictive goal. I evaluated the models based on metrics that I found most relevant to the problem at hand, and I selected the model that exhibited the best metrics as the final one.


## What type of problem is this?

Regression.

## Which model best fits the data and what are its pros and cons?

For the data and goal presented, I tested different types of models: decision tree, random forest, gradient boosting tree, and neural network. Among my tests, I obtained a slightly superior prediction with the neural network compared to the random forest and gradient boosting tree. Although the random forest and gradient boosting tree had a slightly higher R² than the neural network, the neural network had a lower MSE (Mean Squared Error), which likely made the prediction for the movie "The Shawshank Redemption" more accurate.

This happened because there was not a very high correlation between any of the predictor variables used and the target variable. In such cases, R² may not be very informative as its relevance is related to the influence of the predictor variables on the target variable. Therefore, it is understandable that, despite having a lower R², the neural network made a slightly better prediction as it had a lower MSE.

Advantages of the neural network include its flexibility, which allows it to be used in a wide range of tasks such as speech recognition and image processing, as well as regression or classification problems. Additionally, the neural network is capable of capturing complex and nonlinear patterns between its input and output layers.

On the other hand, its disadvantages include the risk of overfitting due to its high modeling capacity and the complexity in choosing parameters during its construction.

## What performance measure was chosen and why?

As mentioned earlier, in this case, the main performance measure chosen was the MSE (Mean Squared Error). Initially, I had considered using R² (coefficient of determination), but upon realizing that the correlation between the predictor variables and the target variable was not very high, I opted for MSE as a more relevant performance metric for this scenario.

This decision proved to be correct, as the model selected for the final prediction (neural network), despite having a lower R² compared to other models evaluated (random forest and gradient boosting tree), managed to make more accurate predictions and had a lower MSE compared to the others.

## What would be the predicted IMDb rating for "The Shawshank Redemption"?

9.284687
