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
wav_file=[home_path 'data/modemDialing.wav'];


% Read file modemDialing.wav
[xs,fs]=audioread(wav_file);
x=xs(floor(3.601*fs):floor(4.358*fs));
Tf = (length(x)-1)/fs;
tt  = 0:(1/fs):Tf;
plot(tt,x);

% DTMF decoder
% dtmf_decoder(x_in, fs, e_th = 5%, time_div,min_peak)
digits=dtmf_decoder(x,fs,0.05,50,0.1);

%%
% Display decoded digits
disp(digits);