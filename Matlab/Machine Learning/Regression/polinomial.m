function rz=polinomial(p,X,z,n)
%expande las matrices
x_exp=expand(X,n);
p_exp= expand(p,n);
%calculo de la inversa
theta = pinv(x_exp)*z(:);
%obtiene los resultados
rz=p_exp*theta;
endfunction
