###############################################################################
##                            Treinando uma xgbtree                          ##                    
###############################################################################

# Definindo o parâmetro "control"
controlxgb <- caret::trainControl(
  "cv",                              # método de validação cruzada
  number = 2,                        # número de repetições da validação cruzada
  summaryFunction = defaultSummary,  # função de resumo padrão para avaliação
  classProbs = FALSE                 # não calcular probabilidades de classe
)

# Definindo o parâmetro "search_grid"
search_grid <- expand.grid(
  nrounds = 600,                     # número de iterações
  max_depth = 30,                    # profundidade máxima das árvores
  gamma = 0,                         
  eta = c(0.05, 0.4),                # taxa de aprendizado
  colsample_bytree = .7,             # fração de colunas amostradas por árvore
  min_child_weight = 1,              # peso mínimo dos nós 
  subsample = .7                     # fração de observações usadas em cada árvore
)

# Criando o modelo ("XGBoost Tree")
treexgb <- caret::train(
  IMDB_Rating ~ .,                         # preço como função de "tudo"
  data = treino,
  method = "xgbTree",
  trControl = controlxgb,
  tuneGrid = search_grid,
  verbosity = 0
)

###############################################################################
##                          Avaliando treexgb                                ##                    
###############################################################################

teste['p'] = predict(treexgb, teste)
teste['r'] = teste$IMDB_Rating - teste$p
metricas(teste, "p", "IMDB_Rating")

###############################################################################
##            Prevendo a nota IMDb de "The Shawshank Redemption"             ##                    
###############################################################################

TSR['p'] = predict(treexgb, TSR)
print(TSR['p'])