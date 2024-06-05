## (C) 2022-2023 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## Polynomial regression (with intercept)
##
## Given a set of training points in X with known 'z'-values stored in
## in the vector y, estimate the 'z'-values on the data points p,
## which usually lie somewhere inbetween the points in X.
##
## p: matrix of size m x 2, with m 2D positions on which
##    the z value needs to be regressed
## X: support data (or training data) with all known 2D positions
## y: support data with the corresponding z values for each position
## O: integer specifying the order of the surface (O=1 is linear
##    regression, O=2 parabolic regression, etc.)
##
## The number of rows of X must be equal to the length of y
##
## The function must generate the z position for all data points in p.
function rz=polyreg(p,X,z,O=1)
  ## This code is for polynomial regression

  ## CHANGE THE FOLLOWING CODE
  ## You have to replace this for a proper polynomial regression
  ##
  ## (The following two lines should be removed:)
  theta=pinv(X)*z(:);
  rz=p*theta;
endfunction
