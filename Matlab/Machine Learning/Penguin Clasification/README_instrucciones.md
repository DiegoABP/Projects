
Instrucciones del funcionamiento del código:

	El código se encuentra centralizado en el archivo logreg_main.m en el branch llamado logreg. 
	Al ejecutar el código se muestran: la gráfica de "Loss evolution" con las optimizaciones solicitadas, la gráfica de superficie de probabilidades en función de dos características, la gráfica de la frontera de decisión en la clasificación y la gráfica de trayectoria de parámetros durante el entrenamiento.

Contextualización:
Se mencionan todos los detalles respectivos mediante comentarios en el código. Algunos se resumen a continuación:

 - El método de normalización seleccionado fue el "minmax", pero es posible seleccionar otro.
 - Es posible cambiar las características observadas en las gráficas de probabilidad de la siguiente forma:
 	
 	Se encuentran las variables P1, P2 y P3, donde se le asignan 4 posibles valores correspondientes a las características de los pinguinos, 
 		1 = Culmen length
 		2 = Culmen depth
 		3 = Flipper length
 		4 = Body mass
 	P1 y P2 son las cualidades utilizadas para obtener las gráficas solicitadas, mientras que las anteriores y P3 se utilizan para la obtención de los valores \theta.
 
 - Se seleccionó "batch" para la generación de las gráficas, esto debido a que generó las gráficas de mejor apreciación.
 
 - Las capturas de las gráficas solicitadas se encuentran en el repositorio junto a los otros archivos. Tienen los nombres "Loss evolution.png", "Superficie de probabilidades.png", "Línea de frontera del clasificador.png", "Trayectoria de parámetros.png".
<<<<<<< HEAD
 
 - Se agregó el archivo expand.m que aplica la regresión polinimial en el generador de la superficies de probabilidades. Para cambiar el grado del polinomio utilizado, se cambia la variable "grado". Se agrega la figura "Superficie de probabilidades (regrepoly).png" para demostrar la función.
 
=======

- Se agregó el archivo expand.m que aplica la regresión polinimial en el generador de la superficies de probabilidades. Para cambiar el grado del polinomio utilizado, se cambia la variable "grado". Se agrega la figura "Superficie de probabilidades (regrepoly).png" para demostrar la función.
>>>>>>> 079c47c92f2b0fb2c07d1f6e8fe88558c7e93e00
