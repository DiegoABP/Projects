## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" para calcular la pérdida con "mean absolute error"
##
## Suponemos que cada fila de Y tiene un dato, para el que
## se tiene como 'ground-truth' las etiquetas Ygt.
##
## Esta capa calcula entonces la pérdida como la mitad de la suma de los
## cuadrados de las diferencias
classdef maeloss < handle
  properties
    ## Entrada en la propagación hacia adelante
    diff=[];
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
    m=[];
  endproperties

  methods
    ## Constructor solo incializa los datos
    function self=maeloss()
      self.diff=[];
      self.outputs=[];
      self.gradient=[];
      self.m = [];
    endfunction

    ## En funciones de perdida el init no hace mayor cosa más que
    ## indicar que la dimensión de la salida es la misma que la entrada.
    ##
    ## La función devuelve la dimensión de la salida de la capa
    function outSize=init(self,inputSize)
      outSize=inputSize;
    endfunction

    ## Retorna false si la capa no tiene un estado que adaptar
    function st=hasState(self)
      st=false;
    endfunction

    ## Propagación hacia adelante.
    ##
    ## En las capas de error, se requieren dos argumentos.
    ##
    ## Primero la salida de la última capa de la red y luego las etiquetas
    ## contra las que se comparará y se calculará la pérdida.
    ##
    ## Note que todas las otras capas solo requieren la salida de la capa anterior.
    function J=forward(self,Y,Ygt)
      if (isscalar(Ygt) && isboolean(Ygt))
        error("Capas de pérdida deben ser las últimas del grafo");
      elseif (isreal(Y) && ismatrix(Y) && (size(Y)==size(Ygt)))
        #self.m = (size(Ygt,1)*size(Ygt,2));


        self.m = rows(Y);
        self.diff = Y - Ygt;
        self.outputs = sum(sum(abs(self.diff)))/self.m;
        J = self.outputs;


        #J = mean(abs(Ygt-Y)(:));                   # Probando esta forma

        self.gradient = [];

      else
        error("maeloss espera dos matrices reales del mismo tamaño");
      endif
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos
    function g=backward(self,dJds)
      if (size(dJds)!=size(self.outputs))
        error("backward de maeloss no compatible con forward previo");
      endif
      ## Asumiendo que dJds es escalar (la salida debería serlo)
      #self.gradient = self.diff*dJds;

      self.gradient = sign(self.diff)*dJds/self.m;


      g=self.gradient;
    endfunction
  endmethods
endclassdef
