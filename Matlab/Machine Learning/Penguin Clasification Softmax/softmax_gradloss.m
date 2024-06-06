% Copyright (C) 2022-2023 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2023 <Su Copyright AQUÍ>

% Gradient of the loss function used in softmax
%
% The size of the returned gradient must be equal to the size of Theta
function grad=softmax_gradloss(Theta,X,y)

  h=softmax_hyp(Theta,X);
  Y_c=[y(:,1) y(:,2) ];
  grad = [ (h-Y_c')*X ]';
  
endfunction
