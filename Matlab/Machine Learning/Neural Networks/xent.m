classdef xent < handle
  properties
    diff=[];
    outputs=[];
    gradient=[];
    eps=1e-9; # Small number to avoid division by zero
  endproperties

  methods
    function self=xent()
      self.diff=[];
      self.outputs=[];
      self.gradient=[];
      self.eps=1e-9;
    endfunction

    function outSize=init(self,inputSize)
      outSize=inputSize;
    endfunction

    function st=hasState(self)
      st=false;
    endfunction

    function J=forward(self,Y,Ygt)
      if (isscalar(Ygt) && isboolean(Ygt))
        error("Loss layers must be the last layers of the graph");
      elseif (isreal(Y) && ismatrix(Y) && (size(Y,2)==size(Ygt,2)))

        Y_norm = Y ./ (sum(Y, 2) + self.eps);
        self.diff=-Ygt .* log(Y_norm);
        self.outputs = sum(self.diff(:));
        J=self.outputs;
        self.gradient = [];
      else
        error("xent expects two matrices of compatible sizes");
      endif
    endfunction

    function g=backward(self,dJds)
      if (size(dJds)!=size(self.outputs))
        error("backward of xent not compatible with previous forward");
      endif
      self.gradient = -self.diff .* dJds / numel(dJds);
      g=self.gradient;
    endfunction
  endmethods
endclassdef
