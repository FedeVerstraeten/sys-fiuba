%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Se�ales y sistemas
 @Project: TPE - Demodulaci�n de tonos de discado de tel�fono
--------------------------------------------------------------
 @Filename: ej3_1.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N�3.1

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej3/'];
wav_file=[home_path 'data/modemDialing.wav'];


[x, fs] = audioread([datos_path senial]);

%Tono inicial
[frecs, pot] = buscar_armonicos(x(1.6*fs:3.6*fs),fs,0.1,1,'espectro_tonoini');

%%
% Tonos de marcado
inicio_fin = [3.375 3.445 3.525 3.595 3.681 3.750 3.833 3.902 3.990 4.058];
%Inicio y fin de cada tono de marcado.
for r = 1:5
    x2 = x(inicio_fin(r*2-1)*fs : inicio_fin(2*r)*fs);
    N = length(x2); 
    NFFT = 2^nextpow2(N);           %Siguiente potencia de 2 de la long de x2
    T_x2 = fft(x2,NFFT)/N;          %Transformada de la se�al.
    k = fs/2*linspace(0,1,NFFT/2+1);                            %creo un eje de frecuencias en Hz
    [pks,locs] = findpeaks(2*abs(T_x2(1:NFFT/2+1)),k','MinPeakHeight',0.09);   %busco los m�ximos
    figure%('visible','off') 
    plot(k ,2*abs(T_x2(1:NFFT/2+1)),locs,pks,'ro','Markersize',3)
    text(locs,pks, num2str(locs,'%.0f'));
    axis ([0 1700 0 max(pks)*1.1]);
    xlabel ('Frecuencia [Hz]');
    ylabel ('Amplitud');
    grid minor;
    nombre_archivo = sprintf('marcado_%i',r);
    print([img_path nombre_archivo '.png'],'-dpng');
end


%%
%Tono de llamada
inicio = 4.4;    %Inicio y fin del tono de llamada.
fin = 6.4;
x3 = x(inicio*fs : fin*fs);
N3 = length(x3); 
NFFT3 = 2^nextpow2(N3);           %Siguiente potencia de 2 de la long de x2
T_x3 = fft(x3,NFFT3)/N3;          %Transformada de la se�al.
k3 = fs/2*linspace(0,1,NFFT3/2+1);                            %creo un eje de frecuencias en Hz

[pks,locs] = findpeaks(2*abs(T_x3(1:NFFT3/2+1)),k3','MinPeakHeight',0.003); %busco los m�ximos

figure('Name','Espectro tono de llamada')%,'visible','off')          
plot(k3 ,2*(abs(T_x3(1:NFFT3/2+1))),locs,pks,'ro','Markersize',3)
text(locs,pks, num2str(locs,'%.0f'));
axis ([0 0.5*fs 0 max(pks)*1.1]);
xlabel ('Frecuencia [Hz]');
ylabel ('Amplitud');
grid minor;
print([img_path 'espectro_tonollam' '.png'],'-dpng');


%%
%Se�al dial-up
inicio = 15.8;    %Inicio y fin de la se�al dial-up
fin = 26.2;
x4 = x(inicio*fs : fin*fs);
N4 = length(x4); 
NFFT4 = 2^nextpow2(N4);           %Siguiente potencia de 2 de la long de x2
T_x4 = fft(x4,NFFT4)/N4;          %Transformada de la se�al.
k4 = fs/2*linspace(0,1,NFFT4/2+1);                            %creo un eje de frecuencias en Hz

[pks,locs] = findpeaks(2*abs(T_x4(1:NFFT4/2+1)),k4','MinPeakHeight',0.0045,'MinPeakDistance',40);

figure('Name','Espectro dial-up')%,'visible','off')          
plot(k4 ,2*(abs(T_x4(1:NFFT4/2+1))),locs,pks,'ro','Markersize',3)
text(locs,pks, num2str(locs,'%.0f'));
axis ([0 0.5*fs 0 max(pks)*1.1]);
xlabel ('Frecuencia [Hz]');
ylabel ('Amplitud');
grid minor;
print([img_path 'espectro_dialup' '.png'],'-dpng');