#Capa Lelelu
classdef lelelu < handle
  properties
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    inputs=[];
    ## Resultados después de la propagación hacia atrás
    gradientY=[];
    gradientA=[];
    alpha=0;

  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function self=lelelu()
      self.outputs=[];
      self.gradientY=[];
      self.gradientA=[];
      self.alpha=0;
    endfunction

    ## En funciones de activación el init no hace mayor cosa más que
    ## indicar que la dimensión de la salida es la misma que la entrada.
    ##
    ## La función devuelve la dimensión de la salida de la capa
    function outSize=init(self,inputSize)

      self.alpha=0.01;

      outSize=inputSize;

    endfunction


   function g=stateGradient(self)
      g=self.gradientA;
    endfunction

    ## Retorne el estado aprendido
    function st=state(self)
      st=self.alpha;
    endfunction

    ## Reescriba el estado aprendido
    function setState(self,a)
      #alpha=sum(a)
      self.alpha=a;
    endfunction

    ## Retorna false si la capa no tiene un estado que adaptar
    function st=hasState(self)
      st=true;
    endfunction

    ## Propagación hacia adelante
    function y=forward(self,X,prediction=false)
      self.inputs=X;

      self.outputs = (max(X,0)+0.1*min(0,X)).*self.alpha;

      y=self.outputs;

      self.gradientY = [];
      self.gradientA=[];
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos
    function g=backward(self,dJds)
      if (size(dJds)!=size(self.outputs))
        error("backward de sigmoide no compatible con forward previo");
      endif
       self.gradientY = (self.alpha.*(self.inputs>0)+ 0.1*self.alpha.*(0>self.inputs)).*dJds;
       self.gradientA =sum(sum(((max(self.inputs,0)+0.1*min(0,self.inputs)).*dJds),2),1);


      g=self.gradientY;
    endfunction
  endmethods
endclassdef
