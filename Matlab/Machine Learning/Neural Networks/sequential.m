## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Modelo secuencial
##
## Esta clase encapsula una red neuronal hacia adelante, con métodos para
## agregar capas, almacenar, cargar, entrenar y predecir.
##
## El método add() permite agregar capas al modelo.  La primera capa debe
## ser del tipo "input_layer" para indicar la dimensión de los datos de entrada.
##
## Luego se agregan capas de normalización, combinación, activación.
##
## La última capa de la red debe ser una capa de error o pérdida.
classdef sequential < handle

  properties ( Access = public )
    ## Constantes:
    layers={};

    ## Training parameters
    maxiter=2000;
    minibatch=128;

    alpha=0.01;     ## Learning rate
    beta1 = 0.95    ## Momentum: 0 para no usar momentum
    beta2 = 0.99    ## Polo de filtro de cuadrados (0: no usar Adam))
    epsilon = 1e-9; ## Evite divisiones por cero en Adam

    method = 'adam';  ## "batch", "sgd", "momentum", "rmsprop", "adam", "autoclip"
    mbmode = 'withrep';  ## Minibatch mode with replacement
    show   = 'progress';


    ## Remaining samples used while training with no-replacement
    remainingIndices=[];

    ## Last output dimension of a layer while adding layers
    lastOutput = -1;

    ## States for each layer, which depend on the optimization method.
    filteredGradients={};
     #estados para radam
      p_max=199;
      t = {};
      m = {};
      v = {};

  endproperties

  methods (Access = private)

    ## ----------------------------------------------------------------------
    ## Show progress methods

    ## Shows nothing (silent mode)
    function showNothing(self,iteration,currentError)
      ## Nothing is done
    endfunction

    ## Shows a dot at each iteration
    function showDots(self,iteration,currentError)
       printf(".");
    endfunction

    ## Shows iteration number and loss value
    function showLoss(self,iteration,currentError)
       printf("Iteration %i/%i: %f\n",iteration,self.maxiter,currentError);

    endfunction

    ## Show progress with 70 steps
    function showProgress(self,iteration,currentError)

      pc=round(100*iteration/self.maxiter);
      done=round(pc*0.7);
      printf("%03i%% %s\r",pc,repmat('=',1,done));
    endfunction

    ## Sampling without replacement
    function idx=samplerMBnr(self,X)
      while (length(self.remainingIndices) < self.minibatch)
        newIdx=randperm(rows(X))';
        self.remainingIndices = [self.remainingIndices;newIdx];
      endwhile
      idx=self.remainingIndices(1:self.minibatch);
      self.remainingIndices=self.remainingIndices(self.minibatch:end);
    endfunction

    ## ----------------------------------------------------------------------
    ## Updaters
    ##
    ## Each updater is used to update the theta parameter vector/matrix
    ## It needs the current parameters tc, and the current gradient g
    ## and it returns the updated parameters vector tn depending on the
    ## method.

    ## State update for batch and SGD
    function newState = updateSimple(self,layerIdx,
                                     currentState,
                                     stateGradient)
      newState = currentState - self.alpha*stateGradient;
    endfunction


    ## State update with momentum
    function newState = updateMomentum(self,layerIdx,
                                       currentState,
                                       stateGradient)

      if ((layerIdx>length(self.filteredGradients)) ||
          isempty(self.filteredGradients{layerIdx}))
        ## Momentum needs an initial filtered gradient.  If not
        ## available yet, it means this is the first time we pass by,
        ## and we must provide a meaningful value
        self.filteredGradients{layerIdx}=stateGradient;
      endif

      self.filteredGradients{layerIdx} = ...
        self.beta1*self.filteredGradients{layerIdx} + ...
        (1-self.beta1)*stateGradient;

      newState = currentState - self.alpha*self.filteredGradients{layerIdx};
    endfunction
 function newState = updateadam(self,layerIdx,
                                  currentState
                                  ,stateGradient)



      g=stateGradient;
      s = g.^2;
      V = g;
      s = self.beta2*s + (1-self.beta2)*(g.^2);
      V = self.beta1*V + (1-self.beta1)*g;
      gg = g./(sqrt(s + self.epsilon) );   # Elimina divisiones por cero
      newState = currentState - self.alpha*gg;
    endfunction


     function newState = updatermsprop(self,layerIdx,
                                 currentState,
                                 stateGradient)
      g=stateGradient;
      s = stateGradient.^2;
      s = self.beta2*s + (1-self.beta2)*(stateGradient.^2);
      gg = g./(sqrt(s + self.epsilon) );   # Elimina divisiones por cero
      newState = currentState - self.alpha*gg;

    endfunction

    function newState = updateradam(self,layerIdx,
                                  currentState
                                  ,stateGradient)
     #Metodo basado en
     #https://github.com/TannerGilbert/Machine-Learning-Explained/blob/master/Optimizers/radam/code/radam.py
     #se da el valor a p
     self.p_max = 2 / (1 - self.beta2) - 1;


         if ((layerIdx>length(self.m)) ||
          isempty(self.m{layerIdx}))

            self.m{layerIdx} = zeros(size(stateGradient));
            self.v{layerIdx} = zeros(size(stateGradient));
            self.t{layerIdx}=0;
       endif

         self.t{layerIdx} = self.t{layerIdx} + 1;

         self.m{layerIdx} = self.beta1 * self.m{layerIdx} + (1 - self.beta1) * stateGradient;
         self.v{layerIdx} = 1 / self.beta2 * self.v{layerIdx} + (1 - self.beta2) * (stateGradient .^ 2);

         m_hat = self.m{layerIdx} / (1 - self.beta1 ^ self.t{layerIdx});
         p_t = self.p_max - 2 * self.t{layerIdx} * self.beta2 ^ self.t{layerIdx} / (1 - self.beta2 ^ self.t{layerIdx});

         if p_t > 4
            l_t = sqrt((1 - self.beta2 ^ self.t{layerIdx}) ./ self.v{layerIdx});
            r_t = sqrt(((p_t - 4) .* (p_t - 2) .* self.p_max) ./ ((self.p_max - 4) .* (self.p_max - 2) .* p_t));
            w_update = self.alpha * r_t .* m_hat .* l_t;
         else
            w_update = self.alpha * m_hat;
         endif

         newState = currentState - w_update;
    endfunction


  endmethods

  methods (Access = public)

    % Construct a sequential model with the desired configuration.
    % See the configure method for available options
    function self=sequential(varargin)

      warning('off','Octave:shadowed-function');
      pkg load statistics;

      self.configure(varargin{:});

      layers={};
    endfunction



    % Configure the optimizer
    %
    % The following parameter pairs are possible (if ommited, the current value
    % is kept):
    % "method", (string): Use "batch","sgd", "momentum", "rmsprop", "adam"
    % "alpha", (float): learning rate (default: 0.05)
    % "beta1", (float): beta1 parameter for momenum (default: 0.7)
    % "beta2",(float): beta2 parameter for adam (default: 0.99)
    % "maxiter",(int): maximum number of iterations (default: 200)
    % "epsilon",(float): tolerance error for convergence (default: 0.001)
    % "minibatch",(int): size of minibatch (default: 16)
    % "mbmode", (strint): Use "withrep","norep" (default: "withrep")
    % "show", (string): Use "nothing","dots","loss","progress"
    function configure(self,varargin)

      parser = inputParser();

      validMethods={"batch","sgd","momentum","rmsprop","adam","autoclip","radam"};
      checkMethod = @(x) any(validatestring(x,validMethods));
      addParameter(parser,'method',self.method,checkMethod);

      checkBeta = @(x) isreal(x) && isscalar(x) && x>=0 && x<=1;
      checkRealPosScalar = @(x) isreal(x) && isscalar(x) && x>0;

      addParameter(parser,'alpha',self.alpha,checkBeta);
      addParameter(parser,'beta1',self.beta1,checkBeta);
      addParameter(parser,'beta2',self.beta2,checkBeta);
      addParameter(parser,'maxiter',self.maxiter,checkRealPosScalar);
      addParameter(parser,'epsilon',self.epsilon,checkRealPosScalar);
      addParameter(parser,'minibatch',self.minibatch,checkRealPosScalar);

      validMBMode={"withrep","norep"};
      checkMBMode=@(x) any(validatestring(x,validMBMode));
      addParameter(parser,"mbmode",self.mbmode,checkMBMode);

      validShow={"nothing","dots","loss","progress"};
      checkShow=@(x) any(validatestring(x,validShow));
      addParameter(parser,'show',self.show,checkShow);

      parse(parser,varargin{:});

      self.method    = parser.Results.method;    ## String with desired method
      self.alpha     = parser.Results.alpha;     ## Learning rate
      self.beta1     = parser.Results.beta1;     ## Momentum parameters beta1
      self.beta2     = parser.Results.beta2;     ## ADAM paramter beta2
      self.maxiter   = parser.Results.maxiter;   ## maxinum number of iterations
      self.epsilon   = parser.Results.epsilon;   ## convergence error tolerance
      self.minibatch = parser.Results.minibatch; ## minibatch size
      self.mbmode    = parser.Results.mbmode;    ## minibatch replacement mode
      self.show      = parser.Results.show;      ## show progress information

    endfunction



    function add(self,layer)
      ## Agregue una capa al modelo secuencial
      ## La primera capa debe ser una capa del tipo "input_layer" para así
      ## indicar la dimensión esperada de cada dato de entrada
      ## La última capa debe ser una capa con la función de pérdida/error.
      ##
      ## Esa capa será ignorada en la predicción.
      if (isa(layer,"cell"))
        add(self,layer{1}); ## Llame de nuevo la función con solo una capa
        if (length(layer)>1)
          add(self,{layer{2:end}}); ## y luego con el resto
        endif
      elseif (isa(layer,"input_layer"))
        self.lastOutput=layer.units;
        printf("Input layer configured with dimension %i\n",self.lastOutput);
      else
        if (self.lastOutput>0)
          printf("Agregando capa '%s'(%i -> ",class(layer),self.lastOutput);
          self.layers = {self.layers{:},layer};
          self.lastOutput=self.layers{end}.init(self.lastOutput);
          printf("%i)\n",self.lastOutput);
        else
          error("Debe agregar primero una capa de entrada");
        endif
      endif
    endfunction

    function losslog=train(self,X,Y,valSetX=[],valSetY=[])

      ## Entrene el modelo
      ## X: matriz de diseño (datos de entrenamiento en filas)
      ## y: matriz de salida, cada file codificada one-hot
      ## valSetX: set de validación (opcional) (entradas en filas)
      ## valSetY: set de validación (opcional) (salidas en filas)
      ## losslog: protocolo con loss por época, para set de
      ##          entrenamiento y opcionalmente el set de validación

      ## Number of layers
      numLayers = length(self.layers);

      if (numLayers<1)
        error("No network structure configured yet.  Layers need to be added first.\n");
      endif

      ## Set up the progress information
      progress = [];

      switch (self.show)
        case "nothing"
          progress = @(it,err) self.showNothing(it,err);
        case "dots"
          progress = @(it,err) self.showDots(it,err);
        case "loss"
          progress = @(it,err) self.showLoss(it,err);
        case "progress"
          progress = @(it,err) self.showProgress(it,err);
        otherwise
          error("Unknown show method");
      endswitch


      ## The samplers are functions to get some/all samples from
      ## the design matrix.  "samplerB" is used for batch training
      ## and it simply returns the whole set, while "samplerMB" is
      ## used to randomly peek a subset of samples used in minibatch
      ## training.
      ##
      ## Depending on the minibatch mode (mbmode) the subset returned
      ## by samplerMB uses sampling with-replacement or
      ## without-replacement.

      ## batch sampler, just passes through the indices of the whole input set
      samplerB = @(X) [1:rows(X)]';
      samplerMB=[];

      switch(self.mbmode)
        case "withrep"
          ## "With-replacement" means that the random samples can appear
          ## several times, since once taken, they are placed back into the
          ## whole set.
          samplerMB = @(X) round(unifrnd(1,rows(X),self.minibatch,1));
        case "norep"
          ## "Without-replacement" means that the samples are unique,
          ## because once taken, they are not returned back to the set.
          samplerMB = @(X) self.samplerMBnr(X);
        otherwise
          error("Minibatch mode unknown");
      endswitch


      switch (self.method)
        case "batch"
          sampler=samplerB;
          updater=@(li,tc,g) self.updateSimple(li,tc,g);
        case "sgd"
          sampler=samplerMB;
          updater=@(li,tc,g) self.updateSimple(li,tc,g);
        case "momentum"
          sampler=samplerMB;
          updater=@(li,tc,g) self.updateMomentum(li,tc,g);
        case "adam"
          sampler=samplerMB;
          updater=@(li,tc,g) self.updateadam(li,tc,g);
        case "rmsprop"
          sampler=samplerMB;
          updater=@(li,tc,g) self.updatermsprop(li,tc,g);
         case "radam"
          sampler=samplerMB;
          updater=@(li,tc,g) self.updateradam(li,tc,g);
        otherwise
          error("Method not implemented yet");
      endswitch


      ## Initialize loss history tracking
      losslog=[];
      loss=0;
      samplesProcessed=0;


      ## Iterate on minibatches
      for ep=1:self.maxiter

        idx=sampler(X); # Which sample indices to use next

        subX=X(idx,:);
        subY=Y(idx,:);

        ## Forward propagation
        y=self.layers{1}.forward(subX);
        for l=2:numLayers-1
          y=self.layers{l}.forward(y);
        endfor
        currentLoss=self.layers{numLayers}.forward(y,subY);
        loss+=currentLoss;

        ## Back propagation
        g=self.layers{numLayers}.backward(1);
        for l=numLayers-1:-1:1
          g=self.layers{l}.backward(g);
          ## If the layer has a state, use the updater to compute the
          ## next state
          if (self.layers{l}.hasState())

            self.layers{l}.setState(updater(l,
                                            self.layers{l}.state(),
                                            self.layers{l}.stateGradient()));
          endif
        endfor

        ## An epoch is the presentation of all samples in the training
        ## set.  We iterate a minibatch at a time (except in batch
        ## mode), so we have to check when an epoch has passed.

        samplesProcessed += rows(subX);
        if (samplesProcessed>=rows(X))
          # an epoch has passed
          if (isempty(valSetX))
            ## No validation data available: just store thre training loss
            losslog = vertcat(losslog,[loss]);
          else
            ## Compute validation loss, and store both: training and validation
            [vY,vL]=computeLoss(self,valSetX,valSetY);
            losslog = vertcat(losslog,[loss vL]);
          endif

          progress(ep,losslog(end));

          samplesProcessed=0;
          loss=0;


        endif

      endfor ## for each iteration


      printf("\n");

    endfunction


    ## Predicción con modelo preentrenado
    function y=test(self,X)
      numLayers=length(self.layers);

      y=self.layers{1}.forward(X,true); % true indica que es predicción
      for l=2:numLayers-1
        y=self.layers{l}.forward(y,true); % true indica que es predicción
      endfor

    endfunction

    ## Predicción con modelo preentrenado
    function [y,loss]=computeLoss(self,vX,vY)
      numLayers=length(self.layers);

      ## Forward prop
      y=self.layers{1}.forward(vX);
      for l=2:numLayers-1
        y=self.layers{l}.forward(y);
      endfor
      loss=self.layers{numLayers}.forward(y,vY);

    endfunction


    function layer=convertStructToLayer(self,structure,layertype)
      ## Método usado para coercionar la estructura self en una clase de tipo
      ## layertype.
      ##
      ## Es necesaria para solventar el problema de que octave no puede
      ## serializar classdef aún.
      layer=eval(layertype);
      for fn=fieldnames(structure)'
        try
          layer.(fn{1}) = structure.(fn{1});
        catch
          warning("Could not copy field %s",fn{1});
        end_try_catch
      endfor
    endfunction


    function save(self,file)
      ## Guarde red en el archivo.  Posteriormente puede cargar el archivo
      ## con load()
      ##
      ## Octave convierte las classdef a struct y por tanto pierde el tipo
      ## concreto de cada capa.
      ##
      ## Como camino alterno almacenamos los nombres de los tipos primero,
      ## para luego poder recrearlos, y una vez que se tienen instancias
      ## vacías podemos convertir las estructuras almacenadas en las clases
      ## concretas.

      ## Extraemos primero los nombres de las clases en un cell-array
      ## y convertimos las capas a estructuras de octave
      names={};
      layers={};
      warning('off','Octave:classdef-to-struct');

      for i=1:length(self.layers)
        names = { names{:} , class(self.layers{i}) };
        layers = { layers{:}, struct(self.layers{i}) };
      endfor

      ## save no entiende atributos de una clase, así que necesitamos
      ## pasar los parámetros de la clase a una estructura
      param.maxiter=self.maxiter;
      param.minibatch=self.minibatch;
      param.alpha=self.alpha;
      param.beta1=self.beta1;
      param.beta2=self.beta2;
      param.epsilon=self.epsilon;
      param.method=self.method;

      save("-v7",file,"param","names","layers");
    endfunction

    function o=load(self,file)

      ## Cargue red desde el archivo almacenado con save.
      names={};
      layers={};
      param=[];

      load("-v7",file,"param","names","layers");

      if (length(names) != length(layers))
        error("Corrupted file.  Inconsistent number of stored layers and types");
        return
      endif

      for fn=fieldnames(param)'
        try
          self.(fn{1}) = param.(fn{1});
        catch
          warning("Could not copy field %s",fn{1});
        end_try_catch
      endfor

      ## De los nombres, recreemos las instancias con los tipos correctos
      for i=1:length(names)
        printf("Loading layer %s\n",names{i});
        self.layers{i}=self.convertStructToLayer(layers{i},names{i});
      endfor
    endfunction

  endmethods
endclassdef
