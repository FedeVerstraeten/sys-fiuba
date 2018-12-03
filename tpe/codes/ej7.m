%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej7.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°7

----------------------------------------------------------- 
%}

%%
close all;
clear all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej7/'];
wav_file=[home_path 'data/output_signal_ej7.wav'];

%%
% Set tones parameters

fs = 8000;

Num = ['1' '2' '3' 'A' '4' '5' '6' 'B' '7' '8' '9' 'C' '*' '0' '#' 'D']; 
D = ones(1,16).*70e-3; % digit min duration - standard
%D = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
S = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];

[t, x] = tones_generator(fs, Num, D, S);


%%
% Period sampling
Ts = 1/fs;

% Final time = #samples * P.sampling
N  = (length(x)-1)*Ts;

% Time axis
t  = 0:Ts:N;

%%
% Plot signal
figure('Name','generacion de tonos','visible','off')          
plot(t,x);
axis ([0 N -2 2]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
print([img_path 'ej7_tones_generator' '.png'],'-dpng');

%%
% Export signal
% Normalization limit the range [-1,1]
x = x/max(abs(x)) * (1-eps);   % for mono

% Create WAV output file
audiowrite(wav_file,x,fs);
