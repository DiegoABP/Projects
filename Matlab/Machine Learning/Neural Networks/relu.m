
#capa relu
classdef relu < handle

properties

 ## Resultados después de la propagación hacia adelante
    outputs=[];
    inputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];

endproperties


methods
      ## Constructor ejecuta un forward si se le pasan datos
    function self=relu()
      self.inputs=[];
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

  #funcion de activacion propagada hacia adelante
  function y = forward(self, input,prediction=false)
    self.inputs=input;
    self.outputs= max(0, input);
    y=self.outputs;
    self.gradient = [];
  endfunction

  #propagacion hacia atras del gradiente
  function g = backward(self, j)

    if (size(j)!=size(self.inputs))
        error("backward de relu no compatible con forward previo");
    endif
    localGrad = self.inputs >= 0;
    self.gradient = localGrad.*j;
    g=self.gradient;
  endfunction

endmethods

endclassdef
