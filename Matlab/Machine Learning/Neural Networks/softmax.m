

## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" softmax, que aplica la función softmax
classdef softmax < handle
  properties
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function self=softmax()
      self.outputs=[];
      self.gradient=[];
    endfunction

    ## En funciones de activación el init no hace mayor cosa más que
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

    ## Propagación hacia adelante
    function y=forward(self,a,prediction=false)
      self.outputs = softmax2(a);
      y=self.outputs;
      self.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos
    function g=backward(self,dJds)
      if (size(dJds)!=size(self.outputs))
        error("backward de softmax no compatible con forward previo");
      endif
      #localGrad = self.outputs.*(1-self.outputs);
      #self.gradient = localGrad.*dJds;

      onesvector = ones(columns(self.outputs),1);

      localGrad = (((self.outputs.*dJds)*onesvector)*onesvector').*self.outputs;
      self.gradient = self.outputs.*dJds - localGrad;

      g=self.gradient;

    endfunction
  endmethods
endclassdef


