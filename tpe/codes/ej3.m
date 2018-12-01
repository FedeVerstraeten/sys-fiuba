%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej3.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°3

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej3/'];
wav_file=[home_path 'data/modemDialing.wav'];

% Read file
[x,fs,nb]=wavread(wav_file);

% Period sampling
Ts = 1/fs;

% Final time = #samples * P.sampling
Tf = (length(x)-1)*Ts;

% Time axis
t  = 0:Ts:Tf;

% Number of samples
N  = length(x);

%%
%Frequency analysis
NFFT = 2^nextpow2(N);

% X(jw) = FFF{x(t)}
T_x = fft(x,NFFT)/N;

% Freq. axis [Hz]
k = fs/2*linspace(0,1,NFFT/2+1);                           

% Search Max peak |X(jw)|
[pks,locs] = findpeaks(2*abs(T_x(1:NFFT/2+1)),k','MinPeakHeight',0.005); 


% Graph coef. Fourier
figure('Name','Trasformada de Fourier del discado completo');%,'visible','off');          
plot(k ,2*abs(T_x(1:NFFT/2+1)));%,locs,pks,'ro','Markersize',3);
text(locs,pks, num2str(locs,'%.0f'));

axis([500 2000 0 0.005]);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud |X(f)|');
grid minor;
%print([img_path 'ej3_TF_discado_completo' '.png'],'-dpng');