# -*- coding: utf-8 -*-
"""
Created on Mon Aug 12 15:04:04 2024

@author: rafae
"""
import tensorflow as tf
import keras
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
import categorical_embedder as ce

###############################################################################
##                          Data Preprocessing                               ##                         
###############################################################################

# Loading the dataset
filmes = pd.read_csv("imdb_movies.csv")

# Removing the enumeration column
filmes = filmes.drop(filmes.columns[0], axis=1)

# Removing the title column
filmes = filmes.drop(columns=["Series_Title"], errors='ignore')

# Removing the overview column
filmes = filmes.drop(columns=["Overview"], errors='ignore')

# Adding release year for the movie Apollo 13, which was incorrectly labeled as "PG"
filmes['Released_Year'] = filmes['Released_Year'].replace('PG', 1995)

# Converting Released_Year from object to int
filmes['Released_Year'] = filmes['Released_Year'].astype('int32')

# Removing " min" from the Runtime column
filmes['Runtime'] = filmes['Runtime'].str.replace(' min','', regex=False)

# Converting Runtime from object to int
filmes['Runtime'] = filmes['Runtime'].astype('int32')

# Removing observations that have any empty values
filmes = filmes.dropna()

# Converting Gross from object to int and removing commas
filmes['Gross'] = filmes['Gross'].str.replace(',', '', regex=False).astype(float)
filmes[['Gross']] = filmes[['Gross']].astype('int32')

###############################################################################
##                               Embedding                                   ##                         
###############################################################################

print(filmes.shape)

# Seperate features from the target
X = filmes.drop(['IMDB_Rating'], axis = 1)
y = filmes['IMDB_Rating']

# ce.get_embedding_info identifies the categorical variables.
# The function returns a dictionary, with tuples of
# (number of categories, embedding size)
# Note: The default is that the size of embedding to be half as the number of categories.
# We can also change the default by handcrafting the dictionary.
embedding_info = ce.get_embedding_info(X, max_dim=2)
embedding_info

# ce.get_label_encoded_data integer encodes the categorical variables 
# and prepares it to feed it to neural network.
X_encoded, encoders = ce.get_label_encoded_data(X)
X_encoded.head()

# fixing the variables' types 

print(filmes.dtypes)

X_encoded[['Certificate', 'Genre', 'Director', 'Star1', 'Star2', 'Star3', 'Star4']] = X_encoded[['Certificate', 'Genre', 'Director', 'Star1', 'Star2', 'Star3', 'Star4']].astype('int32')

# Show the encoders schema
encoders

# Split the data into train and test
X_train, X_test, y_train, y_test = train_test_split(X_encoded, y)

# ce.get_embeddings trains a neural network model, 
# extracts embeddings and returns a dictionary containing the embeddings
embeddings = ce.get_embeddings(
  # Provide the train set
  X_train, y_train, 
  # Provide the embedding info
  categorical_embedding_info = embedding_info, 
  # Our target is a continuous on healthcare expenditure
  is_classification = False,  
  # Specify epochs and batch size 
  epochs = 100, batch_size = 64)

# Take a look at the learned embeddings
embeddings

# Shapes of embeddings
print(embeddings['Certificate'].shape)
print(embeddings['Genre'].shape)
print(embeddings['Director'].shape)
print(embeddings['Star1'].shape)
print(embeddings['Star2'].shape)
print(embeddings['Star3'].shape)
print(embeddings['Star4'].shape)

# If you don't like the dictionary format; 
# we can convert it to dataframe for easy readibility
dfs = ce.get_embeddings_in_dataframe(
  embeddings = embeddings, 
  encoders = encoders)

# Embeddings for Certificate
dfs['Certificate']
# Embeddings for Genre
dfs['Genre']
# Embeddings for Director
dfs['Director']
# Embeddings for Star1
dfs['Star1']
# Embeddings for Star2
dfs['Star2']
# Embeddings for Star3
dfs['Star3']
# Embeddings for Star4
dfs['Star4']

# Include these embeddings in the dataset
movies_embed = ce.fit_transform(
  X, 
  embeddings = embeddings, 
  encoders = encoders, 
  # Remove the original categorical variables
  drop_categorical_vars = True)
movies_embed.head()