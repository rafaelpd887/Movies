###############################################################################
##                          Data Preprocessing                               ##                         
###############################################################################

# Carregando o dataset
filmes <- read_csv("desafio_indicium_imdb.csv")

# Removendo a coluna de enumeração
filmes <- filmes[, -which(names(filmes) == "...1")]

# Removendo a coluna de títulos
filmes <- filmes[, -which(names(filmes) == "Series_Title")]

# Removendo a coluna de gêneros
filmes <- filmes[, -which(names(filmes) == "Genre")]

# Removendo a coluna de overview
filmes <- filmes[, -which(names(filmes) == "Overview")]

# Removendo a coluna de diretores
filmes <- filmes[, -which(names(filmes) == "Director")]

# Removendo as colunas de atores
filmes <- filmes[, -which(names(filmes) == "Star1")]
filmes <- filmes[, -which(names(filmes) == "Star2")]
filmes <- filmes[, -which(names(filmes) == "Star3")]
filmes <- filmes[, -which(names(filmes) == "Star4")]

# Convertendo Released_Year de caractere para numérico
filmes$Released_Year <- as.numeric(filmes$Released_Year)

# Removendo "min" da coluna Runtime
filmes$Runtime <- gsub(" min", "", filmes$Runtime)

# Convertendo Runtime de caractere para numérico
filmes$Runtime <- as.numeric(filmes$Runtime)

# Removendo observações que possuem algum valor vazio "na"
filmes <- filmes[complete.cases(filmes), ]

###############################################################################
##                             One-Hot Coding                                ##                         
###############################################################################

# Dummizando
filmes <- dummy_columns(.data = filmes,
                        select_columns = "Certificate",
                        remove_selected_columns = TRUE,
                        remove_most_frequent_dummy = TRUE)

# Renomeando algumas coluna cujos nomes não são aceitos por alguns algoritmos
colnames(filmes)[colnames(filmes) == "Certificate_PG-13"] <- "Certificate_PG_13"
colnames(filmes)[colnames(filmes) == "Certificate_TV-PG"] <- "Certificate_TV_PG"
colnames(filmes)[colnames(filmes) == "Certificate_U/A"] <- "Certificate_U_A"

###############################################################################
##                           Divisão Treino/Teste                            ##                         
###############################################################################

# Dividindo em teste e treino
n <- sample(1:2,                                
            size = nrow(filmes),            
            replace = TRUE,                     
            prob=c(0.8, 0.2))                    

treino <- filmes[n==1,]                    
teste <- filmes[n==2,] 

###############################################################################
##       Criando um dataframe para o filme "The Shawshank Redemption"        ##                         
###############################################################################

# Criando um dataframe com o filme a ter a nota prevista (The Shawshank Redemption)
TSR <- data.frame(
  Series_Title = 'The Shawshank Redemption',
  Released_Year = 1994,
  Certificate = 'A',
  Runtime = '142 min',
  Genre = 'Drama',
  Overview = 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
  Meta_score = 80.0,
  Director = 'Frank Darabont',
  Star1 = 'Tim Robbins',
  Star2 = 'Morgan Freeman',
  Star3 = 'Bob Gunton',
  Star4 = 'William Sadler',
  No_of_Votes = 2343110,
  Gross = '28,341,469',
  stringsAsFactors = FALSE
)

# Removendo a coluna de títulos
TSR <- TSR[, -which(names(TSR) == "Series_Title")]

# Removendo a coluna de gêneros
TSR <- TSR[, -which(names(TSR) == "Genre")]

# Removendo a coluna de overview
TSR <- TSR[, -which(names(TSR) == "Overview")]

# Removendo a coluna de diretores
TSR <- TSR[, -which(names(TSR) == "Director")]

# Removendo a colunas de atores
TSR <- TSR[, -which(names(TSR) == "Star1")]
TSR <- TSR[, -which(names(TSR) == "Star2")]
TSR <- TSR[, -which(names(TSR) == "Star3")]
TSR <- TSR[, -which(names(TSR) == "Star4")]

# Convertendo Released_Year de caractere para numérico
TSR$Released_Year <- as.numeric(as.character(TSR$Released_Year))

# Removendo "min" da coluna Runtime
TSR$Runtime <- gsub(" min", "", TSR$Runtime)

# Convertendo Runtime de caractere para numérico
TSR$Runtime <- as.numeric(TSR$Runtime)

# Ajustando a coluna Gross
TSR$Gross <- gsub(",", "", TSR$Gross)

TSR$Gross <- as.numeric(TSR$Gross)

# Criando manualmente as colunas dummy para Certificate
TSR$Certificate_A <- ifelse(TSR$Certificate == 'A', 1, 0)
TSR$Certificate <- NULL 

certificates <- c("Approved", "G", "GP", "Passed", "PG", "PG_13", "R", "TV_PG", "U_A", "UA")
for (cert in certificates) {
  dummy_name <- paste("Certificate", cert, sep = "_")
  TSR[[dummy_name]] <- 0
}

###############################################################################
##                Criando uma função para avaliar os modelos                 ##                         
###############################################################################

# Criando uma função para avaliação
metricas <- function(filmes_in, p_var, IMDB_Rating_var){
  n <- dim(filmes_in)[1]
  SSE <- sum((filmes_in[IMDB_Rating_var] - filmes_in[p_var])^2)
  MSE <- SSE/n
  
  # Cálculo de SST (Soma dos Quadrados Total)
  SST <- sum((filmes_in[IMDB_Rating_var] - (filmes_in[IMDB_Rating_var] %>% sum)/n)^2)
  MST <- SST/n
  
  # Cálculo do R-quadrado
  R_squared <- 1 - SSE/SST
  
  # Imprimindo os resultados
  cat("Soma dos Quadrados dos Erros (SSE): ", SSE, "\n") 
  cat("Erro Quadrático Médio (MSE) : ", MSE, "\n")
  cat("Soma dos Quadrados Total (SST): ", SST, "\n") 
  cat("Quadrado Médio Total (MST): ", MST, "\n")
  cat("R-quadrado (R²): ", R_squared, "\n")
  cat(n)
}