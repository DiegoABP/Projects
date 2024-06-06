Instrucciones de funcionamiento
**********************************

Cada método tiene implementado un cuaderno de Jupyter con sus códigos correspondientes, indicado con su nombre respectivo como lo indica el enunciado.

El proceso, partiendo desde la base brindada, comienza con normalización, la cual es posible variar entre metodonormalizar=1 o metodonormalizar=2, correspondientemente a normalización estándar o mínmax.
El "scaler" correspondiente se guarda en la carpeta Normalizadores para su utilización en predict_digit.ipynb.

Luego se entrena el modelo con configuración por defecto y se genera la matriz de confusión correspondiente, se guarda en la carpeta Modelos con el nombre Modelo_SVM.sav, por ejemplo.

Luego se llama a la función Mejores_Parametros(), encargada de probar cada combinación de parámetros dada en la variable params_grid.
Carga las combinaciónes para luego enviarselas al archivo proceso_pareto.py, encargado de encontrar la mejor combinación y generar el gráfico del Frente de Pareto.
Por último, se guarda el nuevo modelo optimizado con el nombre Modelo_SVM_op.sav, por ejemplo, agregando la términación _op que indica la optimización
Luego se genera la matriz de confusión de dicho nuevo modelo.

El proceso es igual para los cuadro modelos, los cuales cuentan con su propio cuaderno, por lo que solo es necesario "correr" el cuaderno.

Se adjunta el enlace al Drive con los modelos guardados https://drive.google.com/drive/folders/16n6mzjNoF-FrqC0cCV8_Zy-bbf2VwsYK?usp=share_link
Se deben pegar en la carpeta Modelos.

*******************************

En el caso de predict_digit.ipynb, solo se debe correr el código y se cargarán los modelos necesarios.

En el método de carga se puede cambiar la variable "tipomodelo", donde con valor 1 carga los modelos por defecto y con valor 2 carga los modelos optimizados.

El resto del proceso es por defecto; dibujar, seleccionar el método y su resultado se muetra en la consola del cuaderno.

****************************

Todo el código fue desarrollado con la ayuda de ChatGPT y Bing chat.
