# Desafio Lighthouse - Cientista de Dados

Este diretório contém arquivos relacionados ao desafio Lighthouse da Indicium.

- Os arquivos de requisitos com todos os pacotes utilizados podem ser encontrados em "códigos e pacotes" no script "pacotes.R".

- EDA e perguntas relacionadas podem ser encontradas em "EDA".

- Os códigos de modelagem podem ser encontrados em "códigos e pacotes" no script "rede_neural.R".

- Códigos referentes à etapa de processamento dos dados e à função para avaliar os modelos podem ser encontrados em "códigos e pacotes" no script "preparação.R".
  
- Os códigos dos outros modelos que foram testados podem ser encontrados em "códigos e pacotes/outros modelos".

# Como instalar e executar o projeto?

O projeto foi feito utilizando a linguagem R através do IDE "RStudio". Portanto, para executar os códigos disponíveis neste repositório, recomendo que o faça em um computador com R e RStudio instalados. Ambos estão disponíveis neste [link](https://posit.co/download/rstudio-desktop/).

Com o R e o RStudio instalados, basta abrir e executar os arquivos "pacotes.R", "preparação.R" e "rede_neural.R" em sequência através do RStudio. O arquivo "pacotes.R" instala os pacotes necessários, "preparação.R" prepara os dados para serem usados no modelo e cria uma função para avaliá-lo, e "rede_neural.R" cria o modelo. É possível usar "Ctrl+A" para selecionar todo o código e "Ctrl+Enter" para executar todas as linhas em sequência.

O modelo usado para fazer a previsão também pode ser encontrado em "códigos e pacotes" no objeto "rede_neural.RData". Para carregá-lo no RStudio, basta usar load("rede_neural.RData"). No entanto, para fazer previsões utilizando este modelo, é necessário tratar os dados conforme o script "rede_neural.R" e padronizá-los conforme o script "padronizacao.R". Além disso, as previsões ainda precisam ser despadronizadas tabém conforme o script "rede_neural.R".

