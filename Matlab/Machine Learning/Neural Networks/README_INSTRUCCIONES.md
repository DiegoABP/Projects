Instrucciones de Funcionamiento

El código en general fue trabajado en el branch "evalpeno", sin embargo se procedió a combinar con el "master" del repositorio, en caso de error recurrir a "evalpeno"

En el archivo nombrado "train.m" se centra todo el control de las pruebas y experimentos realizados.

A partir de la línea 19 y hasta aproximadamente la línea 58 se encuentran los parámetros o variables necesarias para el control de las diferentes pruebas y experimentos.
*- En este documento es posible variar las iteraciones de los cálculos de la pérdida con la variable "iterplot".

*- Se puede cambiar el numero de neuronas utilizadas con la variable "numneuronas."

*- En dicho rango tambien se encuentran los cambios para el "datashape", variable que permite realizar cambios en la forma de clasificación de las clases.

*- Por otro lado, se ubica la variable "what2show", la cual permite variar el tipo de show deseado entre "nothing", "dots", "progress" y "loss".

*- También se cuenta con el vector fila "funs2plot = [c1 c2 c3 c4 c5 c6]" de tipo binario y con siete valores.
Los valores de este vector representan activación "1" y desactivación "0" para cada proceso siguiente:

c1 - Muestra las imágenes de las clases ganadoras y las clases ganadoras con pesos.\\
c2 - Imprime una función de pérdida respecto a las epocas y las capas utilizadas.\\
c3 - Se utiliza una misma neurona para diferentes funciones de error (loss).\\
c4 - Optimización que grafica el loss con respecto a las epocas para cada metodo de optimización.\\
c5 - Hiperparámetros: Genera una gráfica para cada hiperparámetro que se evalua (alpha, beta, beta2, tamaño de batch, cantidad de neuronas).\\
c6 - Experimento con datos reales (pinguinos). Genera un plot que muestra tres diferentes redes neuronales con pérdida respectiva y grados de complejidad diferentes. \\
      * También se toma en cuenta los parámetros "culmen length" y "flipper length", los cuales son variables con P1 y P2 en la sección de control del archivo "train.m".
      * Tomando los parámetros seleccionados, se generan las imágenes de clases ganadoras y las clases ganadoras con pesos, matriz de confusión, matriz de presición y exhaustividad.

