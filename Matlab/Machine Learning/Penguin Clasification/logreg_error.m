function [num per]=logreg_error(y,py)
  %Calculo de la cantidad de errores
  rp=round(py);
  num=abs(sum(y)-sum(rp));
  %Calculo del porcentaje de error

  per= abs(100*(sum(rp)-sum(y))/sum(y));
  endfunction
