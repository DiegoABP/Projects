function [num per]=softmax_error(y,py)
  %Calculo de la cantidad de errores
  py_1=1-sum(py,1);
  py=[py;py_1]';


rp=round(py);
  num=max(abs(sum(y)-sum(rp)));
  %Calculo del porcentaje de error

  per= abs(100*(sum(rp)-sum(y))/sum(y));
  endfunction
