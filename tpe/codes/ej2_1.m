%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej2_1.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°2.1

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej2/'];
wav_file=[home_path 'data/output_signal_ej2.wav'];

% Period sampling
fs = 8000;
Ts = 1/fs;

% Duration = 5 s
D = 5;    

% Time axis
t  = 0:Ts:D;

% Number of samples
N  = length(t);

%%
% Signal: f1=800Hz & f2=1200Hz
f1 = 800;
f2 = 1200;
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);

%%
% Graph time
figure('Name','senoidales en tiempo','visible','off')          
plot(t,x);
axis ([0 D/500 -2 2]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
print([img_path 'ej2_two_sin' '.png'],'-dpng');

%%
%Frequency analysis
NFFT = 2^nextpow2(N);

% X(jw) = FFF{x(t)}
T_x = fft(x,NFFT)/N;

% Freq. axis [Hz]
k = fs/2*linspace(0,1,NFFT/2+1);                           

% Search Max peak |X(jw)|
[pks,locs] = findpeaks(2*abs(T_x(1:NFFT/2+1)),k','MinPeakHeight',0.9); 


% Graph coef. Fourier
figure('Name','analisis coeficientes Fourier','visible','off');          
plot(k ,2*abs(T_x(1:NFFT/2+1)),locs,pks,'ro','Markersize',3);
text(locs,pks, num2str(locs,'%.0f'));

axis([0 1500 0 1.1*max(pks)]);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud |X(f)|');
grid minor;
print([img_path 'ej2_coef_fourier' '.png'],'-dpng');

%%
% Export signal
% Normalization limit the range [-1,1]
x = x/max(abs(x)) * (1-eps);   % for mono

% Create WAV file
audiowrite(wav_file,x,fs);