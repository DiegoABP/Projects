## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Ejemplo de configuración de red neuronal y su entrenamiento



close classes;
clear all;
close all;
1;

warning('off','Octave:shadowed-function');
pkg load statistics;
#-------------------------------PARAMETROS------------------------------
numClasses=5;
numnueronas=16;
##datashape='spirals';
##datashape='curved';
##datashape='voronoi';
##datashape='vertical';
##datashape='pie';
##datashape='radial'
datashape= 'laidar';
#Indica que se puede mostrar
#Estas pueden ser las siguientes:
#   "nothing" "dots" "loss" "progress"
what2show="progress";
#Iteraciones
iterplot=1500;


#Para llammar a las funciones
#Corresponde a:
#-Para graficar el loss con el validation junto con las clases ganadoras
#-Experimento para las diferentes capas
#-Experimento para las funciones de perdida
#-Experimento para las diferentes optimizaciones
#-Experimento para hyperparametros  ******Nota es la que más tarda por diferencia
#-Experimento con datos reales
#IMPORTANTE LAS FUNCIONES DE OPTIMIZACION E HYPERPARAMETROS DEPENDEN DE LA PRIMERA ASI QUE ES IMPORTATE DEJARLA EN 1
#Se recomienda no cprrerlas todas a la vez.
funs2plot=[1,1,1,1,1,1];

#Se utilizan los parametros de la tarea anterior
#1=Culmen Length
#2=Culmen depth
#3=Flipper length
#4=Body mass
P1=1;
P2=3;
#----------------------------------FIN DE LOS PARAMETROS---------------------------------------------
#Numero de la figura
k=1;

[oX,oY]=create_data(numClasses*100,numClasses,datashape); ## Training

## Partition created data into training (60%) and test (40%) sets
idx=randperm(rows(oX));

tap=round(0.6*rows(oX));
idxTrain=idx(1:tap);
idxTest=idx(tap+1:end);

X = oX(idxTrain,:);
Y = oY(idxTrain,:);

vX = oX(idxTest,:);
vY = oY(idxTest,:);


  function cm=matriz_confusion(Y_pred,Y_train)
  Y_pred=Y_pred>=0.5;
  v=zeros(1,size(Y_pred,2));
  v=1:1:size(Y_pred,2);

  Y_pred=v.*Y_pred;
  Y_train=v.*Y_train;
  Y_pred=sum(Y_pred,2);
  Y_train=sum(Y_train,2);

  cm=confusionmat(Y_pred',Y_train');
endfunction


   #-------------metrica presicion y exhaustividad--------------------
    function p=presicion(cm)
      val=zeros(1,size(cm,1));
      for i=1:size(cm,1)
        val(1,i)=cm(i,i);
      endfor
       p=val./sum(cm,1);
    endfunction

   function p=exhaustividad(cm)
      val=zeros(1,size(cm,1));
      for i=1:size(cm,1)
        val(1,i)=cm(i,i);
      endfor

       p=val./sum(cm,2)';
    endfunction

    #-------------metrica presicion y exhaustividad--------------------


if(funs2plot(1))
figure(k,"name","Datos de entrenamiento");
k=k+1;
hold off;
plot_data(X,Y);

ann=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","batch",
               "show",what2show);

file="ann.dat";

reuseNetwork = false;

if (reuseNetwork && exist(file,"file")==2)
  ann.load(file);
else
  ann.add({input_layer(2),
           batchnorm(),
           dense(numnueronas),
           sigmoid(),

           batchnorm(),
           dense(numnueronas),
           lelelu(),

           batchnorm(),
           dense(numnueronas),
           lelu(),

           batchnorm(),
           dense(numnueronas)
           relu(),

           batchnorm(),
           dense(numnueronas)
           prelu(),

           batchnorm(),
           dense(numnueronas)
           softmax(),
%{
           batchnorm(),
           dense(numnueronas),
           softmax(),

           batchnorm(),
           dense(numnueronas),
           sigmoid(),

           batchnorm(),
           dense(numnueronas),
           lelelu(),

           batchnorm(),
           dense(numnueronas)
           relu(),

           batchnorm(),
           dense(numnueronas)
           softmax(),
%}


           dense(numClasses),
           softmax()});


           #ann.add(xent());
           ann.add(olsloss());
endif

loss=ann.train(X,Y,vX,vY);
ann.save(file);

## TODO: falta agregar el resto de pruebas y visualizaciones
#Visualizacion para el loss vs la epoca

figure(k)
k=k+1;
iteration=1:1:rows(loss);
plot(iteration',loss(:,2));
hold on;
xlabel("Epochs")
ylabel("Loss")
plot(iteration',loss(:,1));
legend("Training","Validation")


Xrange=linspace(-1,1,256);
[xx1 xx2]=meshgrid(Xrange);
Xgrid=[xx1(:) xx2(:)];
yp=ann.test(Xgrid)';
yp = [yp; ones(1,columns(yp))-sum(yp)]; ## Append the last probability

## A figure with the winners
[maxprob,maxk]=max(yp);


figure(k,"name","Winner classes");
k=k+1;
winner=flip(uint32(reshape(maxk,size(xx1))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);



## A figure with the weighted winners
figure(k,"name","Weighted winners");
k=k+1;
ccmap = cmap(2:2+numClasses,:);
cwimg = ccmap'*yp;

redChnl   = reshape(cwimg(1,:),size(xx1));
greenChnl = reshape(cwimg(2,:),size(xx1));
blueChnl  = reshape(cwimg(3,:),size(xx1));

mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed);
hold off;
endif


#-----------------------------Diseño con datos artificiales-----------------------------------------------------------

if(funs2plot(2))

#-----------Prueba para diferentes capas-------------






ann2=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","radam",
               "show",what2show);

#Entrenamiento sigmoid
file2="ann2.dat"
if (reuseNetwork && exist(file2,"file")==2)
  ann2.load(file2);
else
  ann2.add({input_layer(2),
            batchnorm(),
            dense(16),
            sigmoid(),
            batchnorm(),
            dense(16),
            sigmoid(),
            batchnorm(),
            dense(numClasses),
            sigmoid()});

  ann2.add(olsloss());
endif
#
loss2=ann2.train(X,Y,vX,vY);
ann2.save(file2);

#Entrenamiento Relu

ann3=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","radam",
               "show",what2show);






file3="ann3.dat"
if (reuseNetwork && exist(file3,"file")==2)
  ann3.load(file3);
else
  ann3.add({input_layer(2),
            batchnorm(),
            dense(16),
            relu(),
            batchnorm(),
            dense(16),
            relu(),
            batchnorm(),
            dense(numClasses),
            relu()});

  ann3.add(olsloss());
endif
#
loss3=ann3.train(X,Y,vX,vY);
ann3.save(file3);
#Entrenamiento prelu


ann4=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","radam",
               "show",what2show);



file4="ann4.dat"
if (reuseNetwork && exist(file4,"file")==2)
  ann4.load(file4);
else
  ann4.add({input_layer(2),
            batchnorm(),
            dense(16),
            prelu(),
            batchnorm(),
            dense(16),
            prelu(),
            batchnorm(),
            dense(numClasses),
            prelu()});

  ann4.add(olsloss());
endif
#
loss4=ann4.train(X,Y,vX,vY);
ann4.save(file4);

#Entrenamiento lelelu
ann5=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","radam",
               "show",what2show);



file5="ann5.dat"
if (reuseNetwork && exist(file5,"file")==2)
  ann5.load(file5);
else
  ann5.add({input_layer(2),
            batchnorm(),
            dense(16),
            lelelu(),
            batchnorm(),
            dense(16),
            lelelu(),
            batchnorm(),
            dense(numClasses),
            lelelu()});

  ann5.add(olsloss());
endif
#
loss5=ann5.train(X,Y,vX,vY);
ann5.save(file5);
#Entrenamiento softmax

ann6=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","radam",
               "show",what2show);



file6="ann6.dat"
if (reuseNetwork && exist(file6,"file")==2)
  ann6.load(file6);
else
  ann6.add({input_layer(2),
            batchnorm(),
            dense(16),
            softmax(),
            batchnorm(),
            dense(16),
            softmax(),
            batchnorm(),
            dense(numClasses),
            softmax()});

  ann6.add(olsloss());
endif
#
loss6=ann6.train(X,Y,vX,vY);
ann6.save(file5);

#Entrenamiento lelu(extra)
ann7=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","radam",
               "show",what2show);



file7="ann7.dat"
if (reuseNetwork && exist(file5,"file")==2)
  ann7.load(file7);
else
  ann7.add({input_layer(2),
            batchnorm(),
            dense(16),
            lelu(),
            batchnorm(),
            dense(16),
            lelu(),
            batchnorm(),
            dense(numClasses),
            lelu()});

  ann7.add(olsloss());
endif
#
loss7=ann7.train(X,Y,vX,vY);
ann7.save(file7);
#graficas de loss






iteration=1:1:rows(loss2);
figure(k);
k=k+1;

plot(iteration',loss2(:,1));
hold on;
plot(iteration',loss3(:,1));
hold on;
plot(iteration',loss4(:,1));
hold on;
plot(iteration',loss5(:,1));
hold on;
plot(iteration',loss6(:,1));
hold on;
plot(iteration',loss7(:,1));
hold on;




xlabel("Epochs");
ylabel("Loss");

legend("Sigmoid","Relu","Prelu","Lelelu","Softmax","Lelu");

endif




if(funs2plot(3))


### ---------------------------------------------------Para funciones de perdida--------------------------------


#OLS
ltest1=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","radam",
               "show",what2show);

filelt1="ltest1.dat";



if (reuseNetwork && exist(filelt1,"file")==2)
  ltest1.load(filelt1);
else
  ltest1.add({input_layer(2),
           batchnorm(),
           dense(numnueronas),
           sigmoid(),

           batchnorm(),
           dense(numnueronas),
           lelelu(),

           batchnorm(),
           dense(numnueronas)
           relu(),

           batchnorm(),
           dense(numnueronas)
           softmax(),

           dense(numClasses),
           softmax()});

           ltest1.add(olsloss());
endif

losslt1=ltest1.train(X,Y,vX,vY);
ltest1.save(filelt1);


#xent
ltest2=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","radam",
               "show",what2show);

filelt2="ltest2.dat";



if (reuseNetwork && exist(filelt2,"file")==2)
  ltest2.load(filelt2);
else
  ltest2.add({input_layer(2),
           batchnorm(),
           dense(numnueronas),
           sigmoid(),

           batchnorm(),
           dense(numnueronas),
           lelelu(),

           batchnorm(),
           dense(numnueronas)
           relu(),

           batchnorm(),
           dense(numnueronas)
           softmax(),

           dense(numClasses),
           softmax()});

           ltest2.add(xent());
endif

losslt2=ltest2.train(X,Y,vX,vY);
ltest2.save(filelt2);






#MAE
ltest3=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","radam",
               "show",what2show);

filelt3="ltest3.dat";



if (reuseNetwork && exist(filelt3,"file")==2)
  ltest3.load(filelt3);
else
  ltest3.add({input_layer(2),
           batchnorm(),
           dense(numnueronas),
           sigmoid(),

           batchnorm(),
           dense(numnueronas),
           lelelu(),

           batchnorm(),
           dense(numnueronas)
           relu(),

           batchnorm(),
           dense(numnueronas)
           softmax(),

           dense(numClasses),
           softmax()});

           ltest3.add(maeloss());
endif

losslt3=ltest3.train(X,Y,vX,vY);
ltest3.save(filelt3);



figure(k)
k=k+1;
iteration=1:1:rows(losslt2);
plot(iteration',losslt1(:,1));
hold on;
plot(iteration',losslt2(:,1));
hold on;
plot(iteration',losslt3(:,1));
hold on;

xlabel("Epochs")
ylabel("Loss")

legend("OLS","XENT","MAE")

endif


#------------------------------------------Metodos de optimizacion-------------------------------------
if funs2plot(4)
methods={"batch","sgd","momentum","rmsprop","adam","radam"};


ann.maxiter=iterplot;

for l=1:length(methods)
ann.method=methods{l};
lossopt=ann.train(X,Y,vX,vY);

iteration=1:1:rows(lossopt);
figure(k);
plot(iteration',lossopt(:,1));
hold on;
hold on;
endfor
#
figure(k)

xlabel("Epochs")
ylabel("Loss")
legend("batch","sgd","momentum","rmsprop","adam","radam")
k=k+1;
hold off;
endif

if funs2plot(5)
#-------------------------Para calculo con hyperparametros------------------


#para alpha
#alphas=linspace(0.0001,0.1,20);
alphas=[0.00001,0.00005 ,0.0001,0.0005 ,0.001 ,0.005, 0.01,0.05,0.1,0.5];
ann.show=what2show;
ann.alpha=0.01;
ann.maxiter=iterplot;
for i=1:length(alphas)
ann.alpha=alphas(i);
hypalphloss=ann.train(X,Y,vX,vY);
lastloss(i)=hypalphloss(end,1);
endfor
#
logalpha=log(alphas);

figure(k)
k=k+1;
plot(logalpha,lastloss');
hold on;
#Se utiliza log de alpha para poder apreciar bien en cambio
xlabel("log(Alpha)")
ylabel("Loss")

betas1=[0.7,0.8,0.9,0.925,0.95,0.975,0.99,0.999];
#Para beta 1
ann.alpha=0.01;
ann.maxiter=iterplot;
for i=1:length(betas1)
ann.beta1=betas1(i);
hypbetaloss=ann.train(X,Y,vX,vY);
lastlossb1(i)=hypbetaloss(end,1);
endfor
figure(k)
k=k+1;
plot(betas1,lastlossb1')
hold on;
xlabel("Beta1")
ylabel("Loss")
#Para beta2
#betas2=linspace(0.7,0.99,20);
betas2=[0.7,0.8,0.9,0.925,0.95,0.975,0.99,0.999];
ann.beta1=0.99;
ann.maxiter=iterplot;
for i=1:length(betas2)
ann.beta2=betas2(i);
hypbeta2loss=ann.train(X,Y,vX,vY);
lastlossb2(i)=hypbeta2loss(end,1);
endfor
figure (k)
k=k+1;
plot(betas2,lastlossb2')
xlabel("Beta2")
ylabel("Loss")



ann.beta2=0.9;


###Para tamaño del batch
ann.method="radam";
minibatches=[8,16,32,64,128,256,512];
for i=1:length(minibatches)
ann.minibatch=minibatches(i);
hypbatchloss=ann.train(X,Y,vX,vY);
lastlossbat2(i)=hypbatchloss(end,1);
endfor

figure (k)
k=k+1;
plot(minibatches,lastlossbat2')
xlabel("Minibatches")
ylabel("Loss")


neuronas=[4,8,16,32,64,128];
###Para el numero de neuronas
#Se necesita una nueva red
for n=1:length(neuronas)
neur=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","batch",
               "show",what2show);


fileneur="neur.dat"
if (reuseNetwork && exist(fileneur,"file")==2)
  neur.load(fileneur);
else
  neur.add({input_layer(2),
            batchnorm(),
            dense(neuronas(n)),
            sigmoid(),

            batchnorm(),
            dense(neuronas(n)),
            lelelu(),

            batchnorm(),
            dense(neuronas(n)),
            relu(),

            batchnorm(),
            dense(neuronas(n)),
            lelu(),

            batchnorm(),
            dense(neuronas(n)),
            softmax(),

            batchnorm(),
            dense(numClasses),
            softmax()});

  neur.add(olsloss());
endif

lossneur=neur.train(X,Y,vX,vY);
lastneur(n)=lossneur(end,1);

neur.save(fileneur);


endfor
figure(k)
k=k+1;
plot(neuronas,lastneur')
xlabel("Neuronas")
ylabel("Loss")

endif
#-------------------------------PRUEBA CON DATOS REALES ---------------------------
if funs2plot(6)
[Xtr,Ytr,Xte,Yte,names] = loadpenguindata("species");
ann.maxiter=iterplot;



pen=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","batch",
               "show",what2show);


filepen="pen.dat";
numClassespen=3;

if (reuseNetwork && exist(filepen,"file")==2)
  pen.load(filepen);
else
  pen.add({input_layer(4),
           batchnorm(),
           dense(12),
           sigmoid(),

           batchnorm(),
           dense(12),
           relu(),

           batchnorm(),
           dense(12),
           lelu(),

           batchnorm(),
           dense(12),
           lelelu(),
           batchnorm(),
           dense(3),
           softmax()
           })

           #pen.add(xent());
           pen.add(olsloss());
endif

losspen=pen.train(Xtr,Ytr,Xte,Yte);
pen.save(filepen);


#Neurona mas simple unbiased
pen2=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","batch",
               "show",what2show);


filepen2="pen2.dat";
numClassespen2=3;

if (reuseNetwork && exist(filepen2,"file")==2)
  pen2.load(filepen2);
else
  pen2.add({input_layer(4),
           batchnorm(),
           dense_unbiased(12),
           sigmoid(),

           batchnorm(),
           dense_unbiased(12),
           relu(),

           batchnorm(),
           dense(12),
           lelu(),

           batchnorm(),
           dense_unbiased(12),
           lelelu(),

           batchnorm(),
           dense_unbiased(3),
           softmax()
           })

           #pen2.add(xent());
           pen2.add(olsloss());
endif

losspen2=pen2.train(Xtr,Ytr,Xte,Yte);
pen2.save(filepen2);





#Neurona compleja
pen3=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","batch",
               "show",what2show);


filepen3="pen3.dat";
numClassespen3=3;

if (reuseNetwork && exist(filepen3,"file")==2)
  pen3.load(filepen3);
else
  pen3.add({input_layer(4),
           batchnorm(),
           dense(12),
           sigmoid(),

           batchnorm(),
           dense(12),
           relu(),

           batchnorm(),
           dense(12),
           lelu(),

           batchnorm(),
           dense(12),
           lelelu(),
           batchnorm(),
           dense(12),
           softmax()
           batchnorm(),
           dense(12),
           sigmoid(),

           batchnorm(),
           dense(12),
           relu(),

           batchnorm(),
           dense(12),
           lelu(),

           batchnorm(),
           dense(12),
           lelelu(),
           batchnorm(),
           dense(3),
           softmax()


           })

           pen3.add(xent());
          # pen3.add(olsloss());
endif

losspen3=pen3.train(Xtr,Ytr,Xte,Yte);
pen3.save(filepen3);




#Neurona para las clases ganadoras
Xtrain=[Xtr(:,P1),Xtr(:,P2)];
Xtest=[Xte(:,P1),Xte(:,P2)];


#Neurona compleja
pen4=sequential("maxiter",iterplot,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",64,
               "method","batch",
               "show",what2show);


filepen4="pen4.dat";
numClassespen4=3;

if (reuseNetwork && exist(filepen4,"file")==2)
  pen4.load(filepen4);
else
  pen4.add({input_layer(2),
           batchnorm(),
           dense(12),
           sigmoid(),

           batchnorm(),
           dense(12),
           relu(),

           batchnorm(),
           dense(12),
           lelu(),

           batchnorm(),
           dense(12),
           lelelu(),
           batchnorm(),
           dense(12),
           softmax()
           batchnorm(),
           dense(12),
           sigmoid(),

           batchnorm(),
           dense(12),
           relu(),

           batchnorm(),
           dense(12),
           lelu(),

           batchnorm(),
           dense(12),
           lelelu(),
           batchnorm(),
           dense(3),
           softmax()


           })

           pen4.add(xent());

endif
#

losspen4=pen4.train(Xtrain,Ytr,Xtest,Yte);
pen4.save(filepen4);







figure(k);
k=k+1;
iteration=1:1:rows(losspen3);
plot(iteration',losspen(:,2));
hold on;
xlabel("Epochs")
ylabel("Loss")
plot(iteration',losspen2(:,1));
plot(iteration',losspen3(:,1));

legend("Red 1","Red 2","Red 3")

Ypen=pen4.test(Xtest);

#Se imprimen las matrices de confusion, precision y exahustividad
Matriz_de_Confusion=matriz_confusion(Ypen,Yte)
Matriz_de_Precision=presicion(Matriz_de_Confusion)
Matriz_de_exhaustividad=exhaustividad(Matriz_de_Confusion)


X1min=min(Xte(:,P1));
X1max=max(Xte(:,P1));

X2min=min(Xte(:,P2));
X2max=max(Xte(:,P2));



Xrange1=linspace(X1min,X1max,256);
Xrange2=linspace(X2min,X2max,256);
[xx1 xx2]=meshgrid(Xrange1,Xrange2);
Xgrid=[xx1(:) xx2(:)];
yp=pen4.test(Xgrid)';
yp = [yp; ones(1,columns(yp))-sum(yp)]; ## Append the last probability

## A figure with the winners
[maxprob,maxk]=max(yp);


figure(k,"name","Winner classes Penguins");
k=k+1;
winner=flip(uint32(reshape(maxk,size(xx1))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);



## A figure with the weighted winners
figure(k,"name","Weighted winners Penguins");
k=k+1;
ccmap = cmap(2:2+3,:);
cwimg = ccmap'*yp;

redChnl   = reshape(cwimg(1,:),size(xx1));
greenChnl = reshape(cwimg(2,:),size(xx1));
blueChnl  = reshape(cwimg(3,:),size(xx1));

mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed);
endif
#-----------------------------Fin penguins---------------------------







