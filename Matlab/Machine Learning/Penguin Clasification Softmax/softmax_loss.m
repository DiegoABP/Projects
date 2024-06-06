% Copyright (C) 2022-2023 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2023 <Su Copyright AQUÍ>

% Loss function used in softmax
function err=softmax_loss(theta,X,y)
  ##Error tomado de la tarea pasada
  Y_p1 = softmax_hyp(theta,X);
  Y_p2= 1-sum(Y_p1,1);
  Y_p=[Y_p1;Y_p2]';

  err= max(sumsq(y-Y_p))./(size(X,1));  # Error por MSE
endfunction
