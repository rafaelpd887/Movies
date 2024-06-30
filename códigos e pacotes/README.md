# Desafio Cientista de Dados
Este README.md tem como objetivo responder às perguntas feitas no item 3 da seção "Tarefas" do arquivo "[Lighthouse] Desafio de Cientista de Dados 2024-9".

# Explique como você faria a previsão da nota do imdb a partir dos dados.
Primeiramente, busco entender os dados através do meu conhecimento de mundo. Tento identificar quais variáveis presentes no dataset tendem a ter maior influência na nota do IMDb.

Após isso, começo a preparar os dados para a criação de um modelo preditivo. Removo colunas que considero desnecessárias ou que possam adicionar complexidade desnecessária ao modelo e corrijo qualquer tipo de erro que possa haver nos dados, como valores ausentes ou tipificação equivocada de variáveis, etc.

Em seguida, testo diferentes algoritmos que considero adequados aos dados e ao objetivo preditivo. Avalio os modelos de acordo com as métricas que julgo mais relevantes para o problema em questão, e escolho como definitivo o modelo que apresentar as melhores métricas.

# Qual tipo de problema estamos resolvendo (regressão, classificação)?
Regressão.

# Qual modelo melhor se aproxima dos dados e quais seus prós e contras? 
Para os dados e objetivo apresentados, testei diferentes tipos de modelos: árvore de decisão, floresta aleatória, árvore com gradiente boost e rede neural. Dentre os meus testes, obtive uma previsão levemente superior com a rede neural em comparação com a floresta aleatória e a árvore com gradiente boost. Apesar da floresta aleatória e da árvore com gradiente boost terem apresentado um R² um pouco superior ao da rede neural, a rede neural apresentava um MSE (Erro Quadrático Médio) menor, o que provavelmente fez com que a previsão para o filme "The Shawshank Redemption" fosse mais precisa.

Isso ocorreu porque não havia uma correlação muito alta entre nenhuma das variáveis preditoras utilizadas e a variável alvo. Em casos como esse, o R² pode não ser tão informativo, pois sua relevância está relacionada à influência das variáveis preditoras na variável alvo. Portanto, é compreensível que, apesar de ter um R² menor, a rede neural tenha feito uma previsão um pouco melhor, já que apresentou um MSE menor.

Entre as vantagens da rede neural estão sua flexibilidade, que permite seu uso em uma ampla variedade de tarefas, como reconhecimento de fala, processamento de imagem, além de problemas de regressão ou classificação. Além disso, a rede neural é capaz de capturar padrões complexos e não lineares entre suas variáveis de entrada e saída.

Por outro lado, suas desvantagens incluem o risco de overfitting devido à alta capacidade de modelagem e a complexidade na escolha dos parâmetros durante sua construção.

# Qual medida de performance do modelo foi escolhida e por quê?
Como mencionado anteriormente, neste caso, a medida de desempenho principal escolhida foi o MSE (Erro Quadrático Médio). Inicialmente, eu havia considerado usar o R² (coeficiente de determinação), mas ao perceber que a correlação entre as variáveis preditoras e a variável alvo não era muito alta, optei pelo MSE como uma métrica de desempenho mais relevante para este cenário.

Essa decisão se mostrou acertada, pois o modelo selecionado para fazer a previsão final (rede neural), apesar de ter apresentado um R² menor em comparação com os outros modelos avaliados (floresta aleatória e árvore com gradiente boost), conseguiu fazer previsões mais precisas e apresentou um MSE menor em relação aos demais.
