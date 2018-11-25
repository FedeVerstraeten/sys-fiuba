%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej2.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°2.

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
figure('Name','senoidales en tiempo')%,'visible','off')          
plot(t,x);
axis ([0 D/500 -2 2]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
%print([img_path 'base_tone' '.png'],'-dpng');

%%
% Graph coef. Fourier
figure('Name','analisis coef. Fourier')%,'visible','off')          

% Calculo de fft y tomamos valor absoluto de los coef.
x_fft = abs(fft(x));

plot(linspace(-fs/2,fs/2,N),fftshift(x_fft));
axis([-1500 1500 0 1.1*max(x_fft)]);
xlabel('frecuencia (Hz)');
ylabel('abs(X(f))');
grid minor;

%%
% Export signal
% Normalization limit the range [-1,1]
x = x/max(abs(x)) * (1-eps);   % for mono

% Create WAV file
audiowrite(wav_file,x,fs);