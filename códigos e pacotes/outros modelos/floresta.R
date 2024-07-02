###############################################################################
##                       Treinando uma floresta aleatória                    ##                    
###############################################################################

forest <- randomForest::randomForest(
  IMDB_Rating ~ .,
  data = treino,
  ntree = 500
)

###############################################################################
##                            Avaliando forest                               ##                    
###############################################################################

teste['p'] = predict(forest, teste)
teste['r'] = teste$IMDB_Rating - teste$p
metricas(teste, "p", "IMDB_Rating")

###############################################################################
##                              Grid Search                                  ##                    
###############################################################################

control <- caret::trainControl(
  method = 'repeatedcv', 
  number = 4,
  repeats = 2,
  search = 'grid',
  summaryFunction = defaultSummary, 
  classProbs = FALSE 
)

grid <- base::expand.grid(.mtry = 1:10)

###############################################################################
##              Treinando uma floresta aleatória com grid search             ##                    
###############################################################################
forest_grid <- caret::train(
  IMDB_Rating ~ .,  
  data = treino,
  method = 'rf', 
  metric = 'RMSE', # Escolha o melhor modelo baseado no RMSE
  trControl = control,
  ntree = 600,
  tuneGrid = grid
)

###############################################################################
##                         Avaliando forest_grid                             ##                    
###############################################################################

teste['p'] = predict(forest_grid, teste)
teste['r'] = teste$IMDB_Rating - teste$p
metricas(teste, "p", "IMDB_Rating")

###############################################################################
##            Prevendo a nota IMDb de "The Shawshank Redemption"             ##                    
###############################################################################

TSR['p'] = predict(forest_grid, TSR)
print(TSR['p'])
