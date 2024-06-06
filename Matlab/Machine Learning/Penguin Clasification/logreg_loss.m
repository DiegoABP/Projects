% Copyright (C) 2022-2023 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2023 <Su Copyright AQUÍ>

% Loss function used in logistic regression
function err=logreg_loss(theta,X,y)
%Calculo del MSE
  Y_p = logreg_hyp(theta,X);
  err= sumsq(y-Y_p)/(size(X,1)); ## Error por MSE

endfunction
