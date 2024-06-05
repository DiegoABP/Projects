%Expande una matriz para un polinomio de grado n
 function x_expand =  expand(X,n)
 x1=X(:,1);
 x2=X(:,2);
% Generar una matriz de diseño de tamaño adecuado
X_design = ones(size(x1));
for i = 1:n
  for j = 0:i
    X_design = [X_design x1.^(i-j) .* x2.^j];
  end
end
x_expand=X_design;
endfunction