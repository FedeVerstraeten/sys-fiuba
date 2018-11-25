%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej2_2.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°2.2

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path = '/home/fverstra/Repository/sys-fiuba/tpe/';
img_path = [home_path 'graph/ej2/'];

% Period sampling
fs = 8000;
Ts = 1/fs;

% Duration = 5 seg
D = 5;

% Silence = 0 seg
S = 0;

% Time axis
t = 0:Ts:D;

% Number of samples
N = length(t);

%%
% DTMF signal generator
digit = ['1' '2' '3' 'A' '4' '5' '6' 'B' '7' '8' '9' 'C' '*' '0' '#' 'D'];
dtmf_signal = zeros(16,N);

for i = 1:length(digit)
  [t_out, x_out] = tones_generator(fs,digit(i),D,S);
  dtmf_signal(i,:) = x_out;
end

%%
%Frequency analysis
NFFT = 2^nextpow2(N);

% Freq. axis [Hz]
k = fs/2*linspace(0,1,NFFT/2+1);

for i = 1:length(digit)
  % X(jw) = FFF{x(t)}
  T_x = fft(dtmf_signal(i,:),NFFT)/N;                           

  % Search Max peak |X(jw)|
  [pks,locs] = findpeaks(2*abs(T_x(1:NFFT/2+1)),k','MinPeakHeight',0.8); 

  % Graph coef. Fourier
  figure('Name','analisis coeficientes Fourier','visible','off');
  plot(k ,2*abs(T_x(1:NFFT/2+1)),locs,pks,'ro','Markersize',3);
  text(locs,pks, num2str(locs,'%.0f'));

  axis([0 2000 0 1.1*max(pks)]);
  xlabel('Frecuencia (Hz)');
  ylabel('Amplitud |X(f)|');
  grid minor;
  print([img_path 'ej2_dtmf_coef_fourier_' digit(i) '.png'],'-dpng');
end