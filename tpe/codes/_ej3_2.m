%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej3_2.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°3.2

----------------------------------------------------------- 
%}

clear all
close all

%-----------------------------------------------------------------------
%Defino algunas variables 
datos_path = '../datos/';
img_path = '../graficos/';
senial = 'modemDialing.wav';

%#######################################################################
%Analisis de la Señal
%#######################################################################

% 3b. Realizar la transformada de Fourier del discado completo. 
% Se puede identificar la secuencia a partir de este espectro?
% Realizar la transformada de corto tiempo de la señal y caracterizarla a partir del
% mismo. Comprobar el efecto de distintas ventanas en la visualización del
% espectrograma.


[x, fs] = audioread([datos_path senial]);
%spectrogram(tonos,kaiser(128),64,128,fs,'yaxis')


%%
%Espectro del discado completo
%--------------------------------------------------------------------------
inicio = 3.375;    %Inicio y fin del discado completo
fin = 4.058;
x1 = x(inicio*fs : fin*fs);

%Análisis en frecuencia
N = length(x1); 
NFFT = 2^nextpow2(N);           %Siguiente potencia de 2 de la long de x2
X1 = fft(x1,NFFT)/N;          %Transformada de la señal.
k = fs/2*linspace(0,1,NFFT/2+1);                            %creo un eje de frecuencias en Hz
[pks,locs] = findpeaks(2*abs(X1(1:NFFT/2+1)),k','MinPeakHeight',0.01,'MinPeakProminence',0.015,'MinPeakDistance',10);   %busco los máximos

figure('Name','Espectro discado completo')%,'visible','off')          
plot(k ,2*abs(X1(1:NFFT/2+1)),locs,pks,'ro','Markersize',3)
text(locs,pks, num2str(locs,'%.0f'));
axis ([0 1700 0 max(pks)*1.1]);
xlabel ('Frecuencia [Hz]');
ylabel ('Amplitud');
grid minor;
print([img_path 'espectro_discado' '.png'],'-dpng');

%%
%Diseño un filtro pasa banda para eliminar el tono inicial
%--------------------------------------------------------------------------

A_sl = 80;
Delta_ml = 20;
[beta, M] = param_kaiser2(A_sl, Delta_ml, fs)
f1 = 2*550/fs;   %frecuencia normalizada
hpfilter = fir1(N-1,f1,'high');%,kaiser(N,beta));
HPF = fft(hpfilter,NFFT)/N;
Y = X1.*HPF';
plot(k ,2*abs(Y(1:NFFT/2+1)))
%plot(abs(HPF(1:NFFT/2+1)))