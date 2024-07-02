###############################################################################
##                          Treinando uma árvore                             ##                    
###############################################################################

tree1 <- rpart(IMDB_Rating~., 
              data=treino,
              control=rpart.control(maxdepth = 4, cp=0)
              )

# Salvando valores previstos (p) e erro (r) no dataset
teste['p'] = predict(tree1, teste)
teste['r'] = teste$IMDB_Rating - teste$p

# Criando uma função para plotar a árvore
plot <- function(tree_){
  palette <- scales::viridis_pal(begin=.75, end=1)(20)
  plot <- rpart.plot::rpart.plot(tree_,
                                 box.palette = palette)
}

# Plotando a árvore
plot(tree1)

###############################################################################
##                          Avaliando tree1                                  ##                    
###############################################################################

teste['p'] = predict(tree1, teste)
teste['r'] = teste$IMDB_Rating - teste$p
metricas(teste, "p", "IMDB_Rating")

###############################################################################
##                  Treinando uma árvore sem restrições                      ##                    
###############################################################################

tree2 <- rpart(IMDB_Rating~.,
                 data=treino[, !(names(treino) %in% c("p", "r"))],
                 xval=10,
                 control = rpart.control(cp = 0, 
                                         minsplit = 2,
                                         maxdepth = 30)
               )

###############################################################################
##                             Avaliando tree2                               ##                    
###############################################################################

teste['p'] = predict(tree2, teste)
teste['r'] = teste$IMDB_Rating - teste$p
metricas(teste, "p", "IMDB_Rating")

###############################################################################
##                       Complexidade dos caminhos                           ##                    
###############################################################################

tab_cp <- rpart::printcp(tree2)
rpart::plotcp(tree2)

tab_cp[which.min(tab_cp[,'xerror']),]

cp_min <- tab_cp[which.min(tab_cp[,'xerror']),'CP']
cp_min

################################################################################
##                   Treinando uma árvore podada (tunada)                     ##
################################################################################

tree_tune <- rpart(IMDB_Rating~., 
                   data=treino[, !(names(treino) %in% c("p", "r", "p_hm", "r_hm"))],
                   xval=0,
                   control = rpart.control(cp = cp_min, 
                                           maxdepth = 30)
)

###############################################################################
##                          Avaliando tree_tune                              ##                    
###############################################################################

teste['p'] = predict(tree_tune, teste)
teste['r'] = teste$IMDB_Rating - teste$p
metricas(teste, "p", "IMDB_Rating")

###############################################################################
##            Prevendo a nota IMDb de "The Shawshank Redemption"             ##                    
###############################################################################

TSR['p'] = predict(tree_tune, TSR)
print(TSR['p'])