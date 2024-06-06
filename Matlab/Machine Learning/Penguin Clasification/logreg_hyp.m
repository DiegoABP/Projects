% Copyright (C) 2022-2023 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2023 <Su Copyright AQUÍ>

% Hypothesis function used in logistic regression
function h=logreg_hyp(theta,X)
sigmoid= @(x) 1./(1+exp(-x));
  ## Dummy random implementation
  h=sigmoid(X*theta(:));
endfunction
