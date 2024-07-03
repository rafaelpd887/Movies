# Definindo os pacotes necessários
packages <- c(
  "dplyr",                # funções para análise estatística
  "PerformanceAnalytics", # adiciona outras funções para análise
  "fastDummies",          # codificação de variáveis qualitativas (One Hot Coding)
  "ggplot2",              # funções para plotagem de gráficos
  "car",                  # funções para análise estatística
  "caret",                # xgbtree entre outras funções
  "readr",                # permite ler arquivos "csv"
  "rpart",                # árvores de decisão com RPart
  "rpart.plot",           # plotagem de árvores de decisão
  "randomForest",         # florestas aleatórias
  "xgboost"               # algoritmo de boosting
)

# Verificando e instalando pacotes ausentes
if (sum(!packages %in% installed.packages()) != 0) {
  installer <- packages[!packages %in% installed.packages()]
  for (pkg in installer) {
    install.packages(pkg, dependencies = TRUE)
  }
}

# Carregando os pacotes
sapply(packages, require, character.only = TRUE)

