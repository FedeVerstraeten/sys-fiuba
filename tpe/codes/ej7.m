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

Ejercicio N°7

----------------------------------------------------------- 
%}

close all;
clear all;
clc;

fs = 8000;
Num = ['4' '6' '5' '2' '7' '7' '9' '6']; 
D = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
S = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];

[t, x] = tones_generator(fs, Num, D, S);

sound(x, fs)
plot(t, x)