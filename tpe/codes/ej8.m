%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej8.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°8

----------------------------------------------------------- 
%}

%%
close all;
clear all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej8/'];
wav_file=[home_path 'data/output_signal_ej7.wav'];

% Read file
% Example: ['1' '2' '3' 'A' '4' '5' '6' 'B' '7' '8' '9' 'C' '*' '0' '#' 'D']]; 
%[x,fs]=audioread(wav_file);

% Other example
fs = 8000;
[t, x] = tones_generator(fs, ['0' '9' '2' '3' '4'], [70 8 90 80 80].*1e-3, [100 100 100 20 15].*1e-3); 

plot(t,x);

% DTMF decoder
% dtmf_decoder(x_in, fs, e_th=2%, time_div,min_peak)
digits=dtmf_decoder(x,fs,0.01,60,0.2);

%%
% Display decoded digits
disp(digits);