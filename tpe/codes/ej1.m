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
spectrogram(x,128,64,128,fs,'yaxis');

%%
%Grafico del silencio inicial y tono base
figure('Name','tono inicial','visible','off')          
plot(t,x);
axis ([0 3.68 -1 1]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
print([img_path 'base_tone' '.png'],'-dpng');

%%
%Grafico de la secuencia del marcado
figure('Name','Marcado','visible','off')          
plot(t,x);
axis ([3.35 4.1 -1 1]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
print([img_path 'dialing' '.png'],'-dpng');

%%
%Grafico del tono de espera de la llamada
figure('Name','tono espera','visible','off')          
plot(t,x);
axis ([4 15.8 -1 1]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
print([img_path 'wait_tone' '.png'],'-dpng');

%%
%Grafico de la señal de fax/dial-up
figure('Name','dial-up','visible','off')          
plot(t,x);
axis ([15.5 26.5 -1 1]);
xlabel ('Tiempo [seg]');
ylabel ('Amplitud');
grid minor;
print([img_path 'fax_dialup_tone' '.png'],'-dpng');