[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-c66648af7eb3fe8bc4f294546bfd86ef473780cde1dea487d3c4ff354943c9ae.svg)](https://classroom.github.com/online_ide?assignment_repo_id=10257581&assignment_repo_type=AssignmentRepo)
# Tarea 2
EL5857 Aprendizaje automático

Estos son los archivos base para la tarea 2.

- heightmap.png
  Datos de profundidad codificados como imagen
- gendata.m
  Archivo que toma la imagen heightmap.png y la carga como datos de
  posición y profundidad.
- showdata.m
  Archivo de ejemplo, solo para obtener datos aleatorios y mostrarlos 
- regressall.m
  Archivo central, que llama a todas las otras funciones.
- linreg_nointercept.m
  Implementación de regresión lineal sin sesgo, que obliga al hiperplano
  encontrado a pasar por cero.  La implementación es completa
- linreg.m
  Plantilla para la regresión lineal completa, que puede tener sesgo
  (no necesariamente pasa por el origen).
  Tiene una implementación de relleno igual a la de linreg_nointercept.m
- polyreg.m
  Plantilla para la regresión polinomial, con sesgo
  (no necesariamente pasa por el origen).
  Tiene una implementación de relleno igual a la de linreg_nointercept.m
- lowess.m
  Plantilla para la regresión ponderada localmente.
  Tiene una implementación de relleno igual a la de linreg_nointercept.m

Este código necesita el paquete '''image''' que puede instalar dentro de
octave con:

     pkg install -forge image
     
     
