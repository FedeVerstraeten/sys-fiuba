%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej1.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°1.

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej1/'];
wav_file=[home_path 'data/modemDialing.wav'];

% Read file
[x,fs,nb]=wavread(wav_file);

% Period sampling
Ts = 1/fs;

% Final time = #samples * P.sampling
N  = (length(x)-1)*Ts;

% Time axis
t  = 0:Ts:N;

%%
% Spectrogram
% S = spectrogram(x,window,noverlap,nfft,fs,OPTIONS)
%spectrogram(x,128,64,128,fs,'yaxis');

%%
%Grafico del silencio inicial y tono base
figure('Name','tono inicial')
plot(t,x);
axis ([4.4 4.5 -1 1]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;