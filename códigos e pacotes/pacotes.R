# Definindo os pacotes necessários
packages <- c(
  "dplyr",                # funções para análise estatística
  "PerformanceAnalytics", # adiciona outras funções para análise
  "fastDummies",          # codificação de variáveis qualitativas (One Hot Coding)
  "ggplot2",              # funções para plotagem de gráficos
  "car",                  # funções para análise estatística
  "caret",                # xgbtree entre outras funções
  "readr"                 # permite salvar arquivos "csv"
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

