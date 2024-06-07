%Codigo para la modulacion GFSK

clear all;
close all;
tic();
n=10;
%Parametros
%Para leer los bits
secuencias_bits = textread('data.txt','%s','delimiter','\n');
n_filas = length(secuencias_bits);
n_columnas = length(secuencias_bits{1});
matriz_bits = zeros(n_filas, n_columnas);
for i = 1:n_filas
    secuencia = secuencias_bits{i};
    for j = 1:n_columnas
        matriz_bits(i,j) = str2double(secuencia(j));
    end
end
transp=matriz_bits';
%Para la prueba de unicamente un dato
%data=matriz_bits(1,:)
%Prueba de todos los datos
data=transp(:);
%Visualizacion solo un dato
data= [0 1 1 1 0 1 1 0 0]';
fs=2.4*10^9;  %Frecuencia de muestreo
tb=1/fs;   %Tiempo de bit
samp=500;  %Cantidad de muestras
M=4;       %Orden de la modulacion 
sepfreq=5*10^6; %Separacion de las fecuencias


%Inicializacion
bits = [];
%Matriz para la representación de los bits
for n = 1:1:length(data)
   if data(n) == 1;
       nbit = ones(1, samp);
   else data(n) == 0;
       nbit = zeros(1, samp);
   end
   bits = [bits nbit];
end

t1 = tb/samp:tb/samp:samp*length(data)*(tb/samp);

plot(t1,bits,'LineWidth',2.5);
grid on;
%axis([0 tb*length(data)/10  -0.5 1.5]); %Para todos los datos
axis([0 tb*length(data)  -0.5 1.5]);     %Para un dato
ylabel('Amplitud [V]');
xlabel('Tiempo [s]');
title('Datos');



%Modulacion GFSK
fsk=fskmod(data, M, sepfreq, samp, fs);
filter = fspecial('gaussian', [1 samp], 0.5);
senal = conv(fsk, filter);

tfs = tb/samp:tb:tb*length(fsk);
figure(2)
plot(tfs,fsk,'LineWidth',2.5);
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
title('FSK');

t = tb/samp:tb:tb*length(senal);
figure(3)
plot(t,senal,'LineWidth',2.5);
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
title('GFSK');
%axis([0 10000*tb  -1.5 1.5]);% Para todos los datos
fid = fopen('senal_modulada.txt', 'w');
dlmwrite('senal_modulada.txt', [t(:), real(senal(:))], ',')
tt=toc();
disp('El tiempo tomado fue de')
disp(tt)

