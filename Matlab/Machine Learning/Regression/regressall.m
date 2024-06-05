## (C) 2022-2023 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## Template file for the whole solution

1;

## Just use 0,1% of the total available data in the experiments
[X,z] = gendata(0.001);

## This is the ground-truth (reference) data to be used for comparison
[RX,rz] = gendata(1,0,0);

## Show the sensed data
close all;

figure(1,"name","Sensed data");
plot3(X(:,1),X(:,2),z',".");
xlabel("x")
ylabel("y")
zlabel("z")
daspect([1,1,0.001]);

## Extract from the ground-truth RX the coordinate range:
minx=min(RX(:,1));
maxx=max(RX(:,1));

miny=min(RX(:,2));
maxy=max(RX(:,2));

## partition is the size of the desired final grid
## the smaller the value, the faster the estimation but
## the coarser the result.
partition=25;
##partition=50;
##partition=75;
[xx,yy]=meshgrid(round(linspace(minx,maxx,partition)),
                 round(linspace(miny,maxy,partition)));

## Flatten the mesh
NX = [xx(:) yy(:)];

printf("Linear regression with no intercept started...");
fflush(stdout);
tic();

## *******  Opciones de gráficos  **********************************************
## *** "n" corresponde al grado del polinomio en la regresión polinomial.
## *** "tau" corresponde al tau del caso de regresión lineal local.
## Regress_type = 1  es la Regresión lineal base de la tarea.
## Regress_type = 2  es la Regresión lineal estándar.
## Regress_type = 3  es la Regresión polinomial.
## Regress_type = 4  es la Regresión lineal local.
## Regress_type = 5  medición del error para corrimiento de "tau" en lowess.
## Regress_type = 6  medición del error para corrimiento de "n" en polinomial.

n=15;
tau=20;
Regress_type = 6;

## ****************************************************************************

if Regress_type == 1

  nz = linreg_nointercept(NX,X,z);

## Insert here the calls to your implementations of:
## - the linear regression with intercept
elseif Regress_type == 2

  nz=linreg(NX,X,z);

## - the polynomial regression with intercept
elseif Regress_type == 3

  nz= polinomial(NX,X,z,n);

## - the locally weighted regression
elseif Regress_type == 4

  nz=lowess(NX,X,z,tau);

elseif Regress_type == 5

  %Para la medicion de error del lowess
gidx=sub2ind([maxy,maxx],yy(:),xx(:));
rval=rz(gidx);
mse = [];
tau = 1:10:100;

for i=[1:length(tau)]
  nz = lowess(NX,X,z,tau(i));
  mse(i) = error(rval,nz);
endfor

figure(3,"name", "Error vs tau")
hold off;
plot(tau,mse,'b',"linewidth",2)
xlabel("Tau")
ylabel("Error")

elseif Regress_type == 6

  %Para la medicion de error del lowess
gidx=sub2ind([maxy,maxx],yy(:),xx(:));
rval=rz(gidx);
mse = [];
n = 1:2:20;

for i=[1:length(n)]
  nz = polinomial(NX,X,z,n(i));
  mse(i) = error(rval,nz);
endfor

figure(3,"name", "Error vs grado n del polinomio")
hold off;
plot(n,mse,'b',"linewidth",2)
xlabel("Grado n")
ylabel("Error")

endif


printf("done.\n");
toc()
fflush(stdout);


figure(2,"name","Linearly regressed data with no intercept");
hold off;
surf(xx,yy,reshape(nz,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
daspect([1,1,0.001]);



