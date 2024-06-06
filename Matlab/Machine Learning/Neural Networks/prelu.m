classdef prelu < handle
    properties
        outputs=[];
        inputs=[];
        gradientY=[];
        gradientA=[];
        alpha=[];
    endproperties

    methods
        function self=prelu()
            self.outputs=[];
            self.gradientY=[];
            self.gradientA=[];
            self.alpha=[];
        endfunction

        function outSize=init(self,inputSize)
            self.alpha=0.01;
            outSize=inputSize;
        endfunction

        function g=stateGradient(self)
            g=self.gradientA;
        endfunction

        function st=state(self)
            st=self.alpha;
        endfunction

        function setState(self,a)
            self.alpha=a;
        endfunction

        function st=hasState(self)
            st=true;
        endfunction

    function y=forward(self,X,prediction=false)
        self.inputs=X;
        self.outputs = max(X,0) + self.alpha .* min(0,X);
        y=self.outputs;
        self.gradientY=[];
        self.gradientA=[];
      endfunction


        function g=backward(self,dJds)
            if (size(dJds)!=size(self.outputs))
                error("backward of prelu not compatible with previous forward");
            endif
            self.gradientY = (self.alpha.*(self.inputs<=0) + (self.inputs>0)) .* dJds;
            self.gradientA = sum(sum(((self.inputs<=0).*self.gradientY),2),1);
            g=self.gradientY;
        endfunction
    endmethods
endclassdef
