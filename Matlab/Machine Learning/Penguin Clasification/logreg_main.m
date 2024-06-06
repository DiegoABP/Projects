% Copyright (C) 2022-2023 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2023 <Su Copyright AQUÍ>

% Logistic regression testbench

#Archivo de prueba para la regresion lineal con los datos de los pinguinos

## Borre todo lo que existía hasta ahora
 pkg load image;
clear all; close all;

## Cargue los datos y use como clase a "sex"
## (otras opciones:"island", "species")
[Xtr,Ytr,Xte,Yte,names] = loadpenguindata("sex");

## ADVERTENCIA: Asegúrese SIEMPRE de normalizar los datos
#normalizer_type="normal";
normalizer_type="minmax";


n=normalizer(normalizer_type);

Xtrain=n.fit_transform(Xtr);
Ytrain=Ytr(:,1); # Usar solo columna de "FEMALE" (la otra es el complemento)

Xtest=n.transform(Xte);
Ytest=Yte(:,1);
y=Ytrain;



figure(1,"name","Loss evolution");
hold on;


## Initial configuration for the optimizer
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",500,
              "alpha",0.002);



#Calculo de loss ara 4 parametros
X=[ones(rows(Xtrain),1) Xtrain];
px=[ones(rows(Xtest),1) Xtest];
theta0=rand(columns(X),1); ## Common starting point (column vector)
methods={"batch","sgd","momentum","rmsprop","adam"};



for m=1:numel(methods)
  method=methods{m};
  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends

  try
    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,X,y);
    theta=ts{end};


    py=logreg_hyp(theta,px);


    #Se grfica el loss vs las iteraciones
    hold on;
    figure(1);
    plot(errs,msg,"linewidth",2);


  #Se calcula el error
   [num, per] =logreg_error(Ytest,py);
   printf("Para el metodo '%s' se tiene %d errores con el un error de %d %%.\n",method,num,per);

   printf("De los valores de theta \n %d %d %d %d %d \n Se estima que los parametros mas imporantes para la regresion son  \n %d %d por la relacion entre la magnitud del theta y el dato de entrada\n",theta(1),theta(2),theta(3),theta(4),theta(5),theta(2), theta(5) );

  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
           method,lasterror.message);
  end_try_catch
endfor
figure(1);

xlabel("Iteration");
ylabel("Loss");
grid on;

%Ciclo para calculo  con 2 citas
X_comb=X;
px_comb=px;
%Se alteran los valores de alpha y maxiter para aumentar los errores y observar como varian segun los parametros
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",1000,
              "alpha",0.002);
for i=1:5
for j=(i+1):5
  %Se escoge sgd ya que es en la que mejor se observan los errores y asi tomar una decision
  method="sgd";
  X=[X_comb(:,i) X_comb(:,j)];
  px=[px_comb(:,i),px_comb(:,j)];
  theta0=ones(columns(X),1);

  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends
  try

    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,X,y);
    theta=ts{end};
    py=logreg_hyp(theta,px);
   [num, per] =logreg_error(Ytest,py);
   printf("Para los parametros %d y %d se tiene %d errores con el un error de %d %%.\n",i,j,num,per);

  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
           method,lasterror.message);
  end_try_catch
endfor
endfor
printf("Segun el analisis anterior se obtiene que los parametros mas importantes son el 2 y 4 en este caso seria la culmen length y flipper length, sin embargo a la hora de graficarlos se observo que para la clasificacion se tenian mejores resultados con el culmen depth y body mass \n")




%Se vuelvena mejorar los valores para visualizar mejor las graficas
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",1000,
              "alpha",0.002);

%Plotear la superficie y la frontera de decision
#Parametros a tomar en cuenta se puede visualizar los diferentes parametros con solo cambiar los valores de los P's
P1=2;
P2=4;
P3=3;


minX1=min(Xte(:,P1));
maxX1=max(Xte(:,P1));



minX2=min(Xte(:,P2));
maxX2=max(Xte(:,P2));




%Se crean los vectores con los que se van a mostrar las graficas
Px1=linspace(minX1,maxX1,25);
Px2=linspace(minX2,maxX2,25);

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


theta0=ones(columns(X),1);
%Aqui se puede variar el metodo con el que se va a calcular
method="batch";
printf("Probando método '%s'.\n",method);
msg=sprintf(";%s;",method); ## use method in legends

  try

    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,X,y);
    theta=ts{end};


    py=logreg_hyp(theta,px);

    figure(2);
    [C3]=contour3(pxx1i,pxx2i,reshape(py,size(pxx1i)),"linewidth",4,"r");
     hold on;


    hold on;
    surf(pxx1i,pxx2i,reshape(py,size(pxx1i)));
    hold on;
    hold on;
    figure(2,"name","Probabilidad de ser hembra dada la longitud del culmen y la aleta");
    xlabel("Longitud del culmen(mm)");
    ylabel("Peso(g)");
    zlabel("P(Hembra)")
    grid on;
    #Desnormalizacion
    Xtesti=n.itransform(Xtest);

    XT=[Xtesti(:,P1),Xtesti(:,P2)];

    %Se grafica la linea discriminatoria
    figure(3)
    [C,M]=contour(pxx1i,pxx2i,reshape(py,size(pxx1i)),[0.5,0.5]);

    hold on;
    figure(3,"name"," Peso vs Longitud del culmen");
    legend('Linea de discriminacion')
    xlabel("Longitud del culmen(mm)");
    ylabel("Peso(g)");
    #Se grafican los puntos
    plot(XT(Ytest<0.5,1),XT(Ytest<0.5,2),'ro', XT(Ytest>0.5,1),XT(Ytest>0.5,2),'b+');
    legend('Linea de discriminacion','machos','hembras');
 catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n", method,lasterror.message);
 end_try_catch
%%%%


#Se aumentan las interacion y el alpha para ver mejor el cambio en cada interacion del theta
opt=optimizer("method","sgd",
              "minibatch",8,
              "maxiter",5000,
              "alpha",0.01);


%Grafica de la trayectoria de theta
X=[Xtrain(:,P1),Xtrain(:,P2),Xtrain(:,P3)];
px=[Xtest(:,P1),Xtest(:,P2),Xtest(:,P3)];
theta0=ones(columns(X),1);
printf("Se escoge como tercer parametro el largo del ala ya que junto con los otros parámetros ")
methods={"batch","sgd","momentum","rmsprop","adam"};
for m=1:numel(methods)
  method=methods{m};
  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;\n",method); ## use method in legends

  try
    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,X,y);
    theta=ts{end};

    py=logreg_hyp(theta,px);

    %Pasar de cell a matriz
    thmat=cell2mat(ts);
    thre=reshape(thmat,3,columns(thmat)/3)';

    hold on;

    figure(4);
    # Se grafican segun el theta obtenido de ts
    plot3(thre(:,1),thre(:,2),thre(:,3),msg,"linewidth",2);



  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
          method,lasterror.message);
  end_try_catch
endfor

 figure(4,"name","Recorrido de theta");
 legend('batch','sgd','momentum');
 xlabel("Theta 1");
 ylabel("Theta 2");
 zlabel("Theta 3");
 grid on;




 %%---------------------------------------------Intento para puntos extras----------------------------------------%
# grado del polinomio
grado=4;

 #Grid para la superficie


[pxx1, pxx2]=meshgrid(Px1n,Px2n);


#Grid sin normalizar
[pxx1i pxx2i]=meshgrid(Px1,Px2);



%Matriz de diseño con sus respectivos parametros

X_d=[Xtrain(:,P1),Xtrain(:,P2)];
X=expand(X_d,grado);

%Puntos a predecir

px_d= [pxx1(:), pxx2(:)];

px=expand(px_d,grado);

theta0=ones(columns(X),1);



theta0=ones(columns(X),1);
%Aqui se puede variar el metodo con el que se va a calcular
method="batch";
printf("Probando método '%s'.\n",method);
msg=sprintf(";%s;",method); ## use method in legends

  try

    opt.configure("method",method); ## Just change the method
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,X,y);
    theta=ts{end};


    py=logreg_hyp(theta,px);

    figure(5);
    [C3]=contour3(pxx1i,pxx2i,reshape(py,size(pxx1i)),"linewidth",4,"r");
     hold on;


    hold on;
    surf(pxx1i,pxx2i,reshape(py,size(pxx1i)));
    hold on;
    figure(5,"name","Probabilidad de ser hembra dada la longitud del culmen y la aleta polinomica");
    xlabel("Longitud del culmen(mm)");
    ylabel("Peso(g)");
    zlabel("P(Hembra)")
    grid on;
    #Desnormalizacion
    Xtesti=n.itransform(Xtest);

    XT_d=[Xtesti(:,P1),Xtesti(:,P2)];
    XT=expand(XT,grado);

    %Se grafica la linea discriminatoria
    figure(6)
    [C,M]=contour(pxx1i,pxx2i,reshape(py,size(pxx1i)),[0.5,0.5]);

    hold on;
    figure(6,"name"," Peso vs Longitud del culmen");
    legend('Linea de discriminacion')
    xlabel("Longitud del culmen(mm)");
    ylabel("Peso(g)");
    #Se grafican los puntos
    plot(XT_d(Ytest<0.5,1),XT_d(Ytest<0.5,2),'ro', XT_d(Ytest>0.5,1),XT_d(Ytest>0.5,2),'b+');
    legend('Linea de discriminacion','machos','hembras');
 catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n", method,lasterror.message);
 end_try_catch

