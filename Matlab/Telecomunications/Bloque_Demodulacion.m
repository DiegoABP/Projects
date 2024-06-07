%Codigo para la modulacion GFSK

clear all;
close all;

n=10;
%Parametros
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
   else 
       nbit = zeros(1, samp);
   end
   bits = [bits nbit];
end

t1 = tb/samp:tb/samp:samp*length(data)*(tb/samp);
%Modulacion GFSK
fsk=fskmod(data, M, sepfreq, samp, fs);
filter = fspecial('gaussian', [1 samp], 0.5);
senal = conv(fsk, filter);



t = tb/samp:tb:tb*length(senal);
figure(2)
plot(t,senal,'LineWidth',2.5);
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
title('FSK');

%------------------------Demodulacion
tic();

primero=find(senal,1);
senal2=senal(primero:end);


primerof=find(filter,1);
filter2=filter(primerof:end);

senal=[0; senal];
senconv=conv(senal,filter, 'same');
t = tb/samp:tb:tb*length(senconv);
figure(3)
plot(t,senconv,'LineWidth',3);
grid on;




demod=fskdemod(senconv, M, sepfreq, samp, fs);

bits_demod=[];
for k = 1:1:length(demod)
   if demod(k) == 1;
       nbit_demod = ones(1, samp);
   else 
       nbit_demod = zeros(1, samp);
   end
   bits_demod = [bits_demod nbit_demod];
end
t_demod = tb/samp:tb/samp:samp*length(demod)*(tb/samp);

plot(t_demod,bits_demod,'LineWidth',3)
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
title('Demod GFSK');
title('Señal Demodulada');


tt=toc();
disp('El tiempo tomado fue de')
disp(tt)

