## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Normalización por lotes
classdef batchnorm < handle
  properties
    ## TODO: Agregue las propiedades que requiera.  No olvide inicializarlas
    ##       en el constructor o el método init si hace falta.
    u=[];  ##media
    var=[]; ##varianza
    u_pred=[0];
    var_pred=[0]
   std=0;
   x_mu=0;
    m=0;
    ## Parámetro usado por el filtro que estima la varianza y media completas
    beta=0.9;
    
    ## Valor usado para evitar divisiones por cero
    epsilon=1e-10;
 
  endproperties
  
  methods
    ## Constructor
    ##
    ## beta es factor del filtro utilizado para aprender 
    ## epsilon es el valor usado para evitar divisiones por cero
    function self=batchnorm(beta=0.9,epsilon=1e-10)
      self.beta=beta;
      self.epsilon=epsilon;

      
      ## TODO: 
      
    endfunction

    ## Inicializa el estado de la capa (p.ej. los pesos si los hay)
    ##
    ## La función devuelve la dimensión de la salida de la capa y recibe
    ## la dimensión de los datos a la entrada de la capa
    function outSize=init(self,inputSize)
      outSize=inputSize;
      
      ## TODO: 
      
    endfunction
   
    ## La capa de normalización no tiene estado que se aprenda con 
    ## la optimización.
    function st=hasState(self)
      st=false;
    endfunction
   
    ## Propagación hacia adelante normaliza por media del minilote 
    ## en el entrenamiento, pero por la media total en la predicción.
    ##
    ## El parámetro 'prediction' permite determinar si este método
    ## está siendo llamado en el proceso de entrenamiento (false) o en el
    ## proceso de predicción (true)      
    function y=forward(self,X,prediction=false)
      self.m=rows(X);
      if (prediction)       
         ##y=(X-ones(rows(X),1)*(self.u_pred)')*inv(diag(self.var_pred));
         self.x_mu = X - self.u_pred;
          self.std = sqrt(self.var_pred + self.epsilon);
          y = self.x_mu ./ self.std;
      else
        if (rows(X)==1)
          ## Imposible normalizar un solo dato.  Devuélvalo tal y como es
          y=X;          
        else
          self.u=mean(X);
          self.var=var(X);          ##sum(X.^2,1).*1/self.m -(self.u).^2+self.epsilon*ones(rows(X),1);
          self.x_mu = X - self.u;
          self.std = sqrt(self.var + self.epsilon);
          y = self.x_mu ./ self.std;
          
        ##  y=(X-ones(rows(X),1)*(self.u))*inv(diag(self.var));   
        endif
      endif
      self.u_pred=self.beta*self.u_pred+(1-self.beta)*self.u;
      self.var_pred=self.beta*self.var_pred+(1-self.beta)*self.var;
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos del grafo,
    ## y retorna el gradiente necesario para la retropropagación. que será
    ## pasado a nodos anteriores en el grafo.
    function g=backward(self,dJds)      
       m = size(dJds, 1);
    
    u = self.u;
    var = self.var;
    eps = self.epsilon;
    std = sqrt(var + eps);
    x_mu = self.x_mu;
    dJdxhat = dJds .* self.beta;
    dJdvar = sum(dJdxhat .* x_mu, 1) .* (-0.5) .* (std.^(-3));
    dJdu = sum(dJdxhat .* (-1 ./ std), 1) + dJdvar .* (-2/m) .* sum(x_mu, 1);
    g= dJdxhat .* (1 ./ std) + dJdvar .* (2/m) .* x_mu;
   
   endfunction
  endmethods
endclassdef
