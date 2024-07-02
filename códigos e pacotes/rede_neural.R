###############################################################################
##                           Padronizando os dados                           ##                    
###############################################################################

# Separando as variáveis a serem padronizadas
cols <- c("Released_Year", 'Runtime', 'IMDB_Rating', 'Meta_score', 
          'No_of_Votes', 'Gross')

# Função para padronização/escalonamento
range01 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

# Salvando valores mínimos e máximos das variáveis que serão usados na padronização
min_vals <- sapply(filmes[cols], min)
max_vals <- sapply(filmes[cols], max)

# Preparando dados para padronização
filmes_neural <- filmes

# Padronização
filmes_neural[cols] <- lapply(filmes_neural[cols], range01)

# Dividindo "filmes_neural" em teste e treino
nn <- sample(1:2, 
             size = nrow(filmes_neural), 
             replace = TRUE, 
             prob = c(0.8, 0.2))                 

treino_neural <- filmes_neural[nn == 1,]                    
teste_neural <- filmes_neural[nn == 2,] 

###############################################################################
##                         Treinando uma rede neural                         ##                    
###############################################################################

# Criando o modelo
rede_neural <- neuralnet(IMDB_Rating ~ .,
                         data = treino_neural, 
                         hidden = c(0), 
                         linear.output = TRUE,
                         )


###############################################################################
##                         Avaliando rede_neural                             ##                    
###############################################################################

teste_neural['p'] = predict(rede_neural, teste_neural)
teste_neural['r'] = teste_neural$IMDB_Rating - teste_neural$p
metricas(teste_neural, "p", "IMDB_Rating")


###############################################################################
##           Padronizando os dados de "The Shawshank Redemption"             ##                    
###############################################################################

TSR_neural <- TSR

cols_tsr <- c("Released_Year", 'Runtime', 'Meta_score', 'No_of_Votes', 'Gross')

# Aplicando a padronização nos dados de "The Shawshank Redemption"
TSR_neural[cols_tsr] <- mapply(function(x, min_val, max_val) {
  (x - min_val) / (max_val - min_val)}, 
  TSR_neural[cols_tsr], min_vals[cols_tsr], 
  max_vals[cols_tsr])

###############################################################################
##            Prevendo a nota IMDb de "The Shawshank Redemption"             ##                    
###############################################################################

TSR_neural['p'] = predict(rede_neural, TSR_neural)

# Função para despadronização do valor previsto
inverse_range01 <- function(x, min_val, max_val) {
  x * (max_val - min_val) + min_val
}

# Despadronizando e visualizando a previsão
TSR_neural['IMDB_Rating_real'] = inverse_range01(TSR_neural['p'], 
                                                 min_vals["IMDB_Rating"], 
                                                 max_vals["IMDB_Rating"])

print(TSR_neural['IMDB_Rating_real'])