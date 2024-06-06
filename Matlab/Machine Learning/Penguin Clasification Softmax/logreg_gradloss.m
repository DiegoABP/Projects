% Copyright (C) 2022-2023 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2023 <Su Copyright AQUÍ>

% Loss function used in logistic regression
function grad=logreg_gradloss(theta,X,y)
  ## Dummy random implementation
  ## grad=rand(size(theta));
  h=logreg_hyp(theta,X);
  grad=sum((h-y).*X);
endfunction
