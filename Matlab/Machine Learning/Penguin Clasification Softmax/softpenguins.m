#softpenguins


close all;
pkg load statistics;

##################################
## Construct some training data ##
##################################

k=3;   ## Number of classes

mk=100; ## Number of training points per class

[Xtr,Ytr,Xte,Yte,names] = loadpenguindata("species");

## ADVERTENCIA: Asegúrese SIEMPRE de normalizar los datos
#normalizer_type="normal";
normalizer_type="minmax";


n=normalizer(normalizer_type);

Xtrain=n.fit_transform(Xtr);

Xtest=n.transform(Xte);

Ytrain=Ytr;
Ytest=Yte;


y=Ytrain;


## Initial configuration for the optimizer
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",500,
              "alpha",0.002);




#Calculo de loss ara 4 parametros
X=[ones(rows(Xtrain),1) Xtrain];
px=[ones(rows(Xtest),1) Xtest];
if (~exist("Theta","var") || ~prod(size(Theta) == [5,k-1]) )
  Theta=zeros(5,k-1); ## For simplicity we will carry the k-th
endif
methods={"batch","sgd","momentum","rmsprop","adam"};


for m=1:numel(methods)
  method=methods{m};
  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends

  try
    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta,X,y);
    theta=ts{end};


    py=softmax_hyp(theta,px);


    #Se grfica el loss vs las iteraciones
    hold on;
    figure(1);
    plot(errs,msg,"linewidth",2);


  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
           method,lasterror.message);
  end_try_catch
endfor

## *********************************************************************************************
##    Agregado el 24/03/2023

%Ciclo para calculo  con 2 citas
X_comb=X;
px_comb=px;
Theta=zeros(2,k-1);

%Se alteran los valores de alpha y maxiter para aumentar los errores y observar como varian segun los parametros
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",500,
              "alpha",0.002);
for i=1:5
for j=(i+1):5
  %Se escoge sgd ya que es en la que mejor se observan los errores y asi tomar una decision
  method="batch";
  X=[X_comb(:,i) X_comb(:,j)];
  px=[px_comb(:,i),px_comb(:,j)];


  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends
  try

    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta,X,y);
    theta=ts{end};
    py=softmax_hyp(theta,px);
   [num, per] =softmax_error(Ytest,py);   
   printf("Para los parametros %d y %d se tiene %d errores con un error de %d %%.\n\n",i,j,num,per);

  catch
   printf("\n### Error detectado probando método '%s': ###\n %s\n\n",method,lasterror.message);
  end_try_catch
endfor
endfor
printf("\n")
printf("Según el análisis anterior, se obtiene que los parámetros más importantes son el 2 y 4, en este caso seria el *culmen length* y *flipper length*, sin embargo, a la hora de graficarlos se observó que para la clasificación se tenian mejores resultados con el *culmen depth* y *body mass* \n");




%Se vuelvena mejorar los valores para visualizar mejor las graficas
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",2000,
              "alpha",0.0002);

%Plotear la superficie y la frontera de decision
#Parametros a tomar en cuenta se puede visualizar los diferentes parametros con solo cambiar los valores de los P's
P1=1;
P2=2;
P3=3;
parametros={"culmen length [mm]", "culmen depth [mm]", "flipper length [mm]", "body mass [g]"};
pespecies={"P(Adelie)", "P(Chinstrap)","P(Gentoo)"};

minX1=min(Xte(:,P1));
maxX1=max(Xte(:,P1));



minX2=min(Xte(:,P2));
maxX2=max(Xte(:,P2));
%Cambiar los minimos y maximos manualmente

#minX1=0;
#maxX1=30;

#minX1=0;
#maxX2=7000;

%Se crean los vectores con los que se van a mostrar las graficas
Px1=linspace(minX1,maxX1,100);
Px2=linspace(minX2,maxX2,100);

%Se normalizan los vectores
npx=normalizer(normalizer_type);
Px1n=npx.fit_transform(Px1);
Px2n=npx.fit_transform(Px2);




#Grid para la superficie
[pxx1, pxx2]=meshgrid(Px1n,Px2n);


#Grid sin normalizar
[pxx1i pxx2i]=meshgrid(Px1,Px2);



%Matriz de diseño con sus respectivos parametros

X=[Xtrain(:,P1),Xtrain(:,P2)];

%Puntos a predecir

px= [pxx1(:), pxx2(:)];



#Prediccion para la figura
method="batch";
printf("Probando método '%s'.\n",method);
msg=sprintf(";%s;",method); ## use method in legends

opt.configure("method",method); ## Just change the method
[ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta,X,y);
 theta=ts{end};
#Se guarda para el calculo posterior de los colores
theta_lin=theta;
py=softmax_hyp(theta,px);
#Se agrega la columna faltante
pyiter=[py;1-sum(py,1)]';

#Ciclo para crear figuras
    for i=1:3
    figure (i+1);
    hold on;
    py=pyiter(:,i);
    size(py);

    surf(pxx1i,pxx2i,reshape(py,size(pxx1i)));
    hold on;
    figure(i+1,"name","Probabilidad de la especie");
    xlabel(parametros(P1));
    ylabel(parametros(P2));
    zlabel(pespecies(i));
    grid on;
  endfor
#---------------------------------Inicio para puntos extra 1--------------------------------------#
 %Puntos extra
grado=4;

X=[Xtrain(:,P1),Xtrain(:,P2)];
X=expand(X,grado);
%Puntos a predecir

px= [pxx1(:), pxx2(:)];

px=expand(px,grado);

Theta=zeros(columns(X),k-1);

 #Prediccion para la figura
method="batch";
printf("Probando método '%s'.\n",method);
msg=sprintf(";%s;",method); ## use method in legends

opt.configure("method",method); ## Just change the method
[ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta,X,y);
 theta=ts{end};
 #Se guarda para
 theta_poli=theta;


py=softmax_hyp(theta,px);
#Se agrega la columna faltante
pyiter=[py;1-sum(py,1)]';


#Ciclo para crear figuras
    for i=1:3
    figure (i+4);
    hold on;
    py=pyiter(:,i);
    surf(pxx1i,pxx2i,reshape(py,size(pxx1i)));
    hold on;
    figure(i+4,"name","Probabilidad de la especie, polinómica");
    xlabel(parametros(P1));
    ylabel(parametros(P2));
    zlabel(pespecies(i));
    grid on;
  endfor
#----------------------------------Fin de puntos extra 1-----------------------------------

%Se crean los vectores con los que se van a mostrar las graficas
Px1=linspace(minX1,maxX1,500);
Px2=linspace(minX2,maxX2,500);

%Se normalizan los vectores
npx=normalizer(normalizer_type);
Px1n=npx.fit_transform(Px1);
Px2n=npx.fit_transform(Px2);




#Grid para la superficie
[pxx1, pxx2]=meshgrid(Px1n,Px2n);


#Grid sin normalizar
[pxx1i pxx2i]=meshgrid(Px1,Px2);



px= [pxx1(:), pxx2(:)];
theta=theta_lin;
%Tomado de softmax
FX = px;
FZ = softmax_hyp(theta,FX);
FZ = [FZ; ones(1,columns(FZ))-sum(FZ)]; ## Append the last probability


## A figure with the winners
[maxprob,maxk]=max(FZ);


figure(8);
hold on;
winner=flip(uint8(reshape(maxk,size(pxx1))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1];
wimg=ind2rgb(winner,cmap);
imshow(wimg);
hold on;

figure(8,"name","Clases ganadoras");
xlabel(parametros(P1));
ylabel(parametros(P2));




figure(9);
hold on;
winner=flip(uint8(reshape(maxk,size(pxx1))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1];
wimg=ind2rgb(winner,cmap);


FZ1=FZ(1,:);
FZ2=FZ(2,:);
FZ3=FZ(3,:);

fz1=flip(reshape(FZ1,size(pxx1)),1);
fz2=flip(reshape(FZ2,size(pxx1)),1);
fz3=flip(reshape(FZ3,size(pxx1)),1);

wimg2(:,:,1)= fz1;

wimg2(:,:,2)= fz2;

wimg2(:,:,3)= fz3;

imshow(wimg2);
hold on;


figure(9,"name","Winner classes");
xlabel(parametros(P1));
ylabel(parametros(P2));
#----------------------------------------Puntos extra 2--------------------------------------
theta=theta_poli;
px=(expand(px,grado));
FX = px;
FZ = softmax_hyp(theta,FX);
FZ = [FZ; ones(1,columns(FZ))-sum(FZ)]; ## Append the last probability



## A figure with the winners
[maxprob,maxk]=max(FZ);


figure(10);
hold on;
winner=flip(uint8(reshape(maxk,size(pxx1))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1];
wimg=ind2rgb(winner,cmap);
imshow(wimg);
hold on;

figure(10,"name","Clases ganadoras (polinomial)");
xlabel(parametros(P1));
ylabel(parametros(P2));




figure(11);
hold on;
winner=flip(uint8(reshape(maxk,size(pxx1))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1];
wimg=ind2rgb(winner,cmap);


FZ1=FZ(1,:);
FZ2=FZ(2,:);
FZ3=FZ(3,:);

fz1=flip(reshape(FZ1,size(pxx1)),1);
fz2=flip(reshape(FZ2,size(pxx1)),1);
fz3=flip(reshape(FZ3,size(pxx1)),1);

wimg2(:,:,1)= fz1;

wimg2(:,:,2)= fz2;

wimg2(:,:,3)= fz3;

imshow(wimg2);
hold on;

figure(11,"name","Winner classes (poly)");
xlabel(parametros(P1));
ylabel(parametros(P2));


