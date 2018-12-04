%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej9.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°9.

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej9/'];
wav_file=[home_path 'data/modemDialing.wav'];

% Usando discado modemDialing
[x, fs] = audioread(wav_file);
t_init = 3.375;    
t_fin = 4.058;
xs = x(t_init*fs : t_fin*fs);
t=t_init:(1/fs):t_fin;

%Other example
%fs = 8000;
%[t, xs] = tones_generator(fs, ['0' '9' '8' '2' 'A'], [70 40 9 8 8].*1e-2, [30 40 50 20 15].*1e-3); 

f1 = 697; f2 = 770; f3 = 852; f4 = 941;
f5 = 1209; f6 = 1336; f7 = 1477; f8 = 1633;

% Filtros pasabanda
% h697 hasta h1633 son los filtros
% La funcion "disenio_filtro" que le pasas los parametros del filtro
% Tiene fijo el tipo de ventana y la amplitud de los lobulos
% laterales (40 dB)

h697 = disenio_filtro(f1-50, f1-1, f1+1, f1+(f2-f1)/2-5); 
h770 = disenio_filtro(f2-(f2-f1)/2+5, f2-1, f2+1, f2+(f3-f2)/2-5);
h852 = disenio_filtro(f3-(f3-f2)/2+5, f3-1, f3+1, f3+(f4-f3)/2-5);
h941 = disenio_filtro(f4-(f4-f3)/2+5, f4-1, f4+1, f4+(f5-f4)/2-5);
h1209 = disenio_filtro(f5-(f5-f4)/2+5, f5-1, f5+1, f5+(f6-f5)/2-5);
h1336 = disenio_filtro(f6-(f6-f5)/2+5, f6-1, f6+1, f6+(f7-f6)/2-5);
h1477 = disenio_filtro(f7-(f7-f6)/2+5, f7-1, f7+1, f7+(f8-f7)/2-5);
h1633 = disenio_filtro(f8-(f8-f7)/2+5, f8-1, f8+1, f8+(1750-f8)/2-5);

% Salida banco de filtros
% Filtrado a partir de la deficinicion anterior
y697 = filter(h697.Numerator,1,xs);
y770 = filter(h770.Numerator,1,xs);
y852 = filter(h852.Numerator,1,xs);
y941 = filter(h941.Numerator,1,xs);
y1209 = filter(h1209.Numerator,1,xs);
y1336 = filter(h1336.Numerator,1,xs);
y1477 = filter(h1477.Numerator,1,xs);
y1633 = filter(h1633.Numerator,1,xs);

% Estimadores salida de filtros
% Modificar los parametros e_th y time_div segun se considere
% energy_estimator(output_filter,energy_threshold,time_division)
e697 = energy_estimator(y697',1,50);
e770 = energy_estimator(y770',1,50);
e852 = energy_estimator(y852',1,50);
e941 = energy_estimator(y941',1,50);
e1209 = energy_estimator(y1209',1,50);
e1336 = energy_estimator(y1336',1,50);
e1477 = energy_estimator(y1477',1,50);
e1633 = energy_estimator(y1633',1,50);


digits=digit_decoder(e697,e770,e852,e941,e1209,e1336,e1477,e1633);

%grafico salidas estimador on/off
%{
subplot(8,1,1);plot(t,e697);
subplot(8,1,2);plot(t,e770);
subplot(8,1,3);plot(t,e852);
subplot(8,1,4);plot(t,e941);
subplot(8,1,5);plot(t,e1209);
subplot(8,1,6);plot(t,e1336);
subplot(8,1,7);plot(t,e1477);
subplot(8,1,8);plot(t,e1633);
%}
disp(digits);