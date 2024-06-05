## (C) 2022-2023 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## LOcally WEighted regreSSion (LOWESS)
##
## Given a set of training points in X with known 'z'-values stored in
## in the vector y, estimate the 'z'-values on the data points p,
## which usually lie somewhere inbetween the points in X.
##
## p: matrix of size m x 2, with m 2D positions on which
##    the z value needs to be regressed
## X: support data (or training data) with all known 2D positions
## y: support data with the corresponding z values for each position
## tau: bandwidth of the locally weighted regression
##
## The number of rows of X must be equal to the length of y
##
## The function must generate the z position for all data points in p
function lz=lowess(p,X,z,tau)
%Expande los vectores
X_exp=expand(X,1);
P_exp=expand(p,1);
%prepara la matriz
lz=[];
for i = 1:rows(P_exp)
    %Calcula la w
    w= exp(-sum((X_exp - P_exp(i, :)).^2,2) ./ (2 * tau.^2)); 
    %Diagonaliza
    W = diag(w); % Create a diagonal weight matrix
    %Hace el calculo para los thetas
    theta= pinv((X_exp'*W)*X_exp)*(X_exp'*W)*z';
    
    lz(i)=(P_exp(i,:)*theta)';
    
  end


endfunction
