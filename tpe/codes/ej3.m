%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej3.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°3

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej3/'];
wav_file=[home_path 'data/modemDialing.wav'];

[x, fs] = audioread([datos_path senial]);
A_sl = 0;      %Relación en dB lóbulo ppal y sec.
N = 512;        %Long de la ventana.
Dml_HHB = 4*8000/(N+1) %Anchura del lóbulo ppal para las ventanas de Hann
                        %Hamming y Bartlett.
[beta1, A_sl] = param_kaiser2(0, Dml_HHB,N, fs),

A_sl2 =60;
[beta2, D_ml2] = param_kaiser2(A_sl2, 0 ,N, fs);
Delta_ml2 = D_ml2*fs/(2*pi)

Delta_ml3 = 100;
[beta3, A_sl3] = param_kaiser2(0 , Delta_ml3 ,N, fs);

wvtool(rectwin(N),bartlett(N),hann(N),kaiser(N,beta1),hamming(N),kaiser(N,beta2));

%Tonos de marcado
%--------------------------------------------------------------------------
guardar = true;
% [frecs, pot] = buscar_armonicos(x(3.375*fs:3.445*fs),kaiser(N,beta2),fs,[0.05 1],[1 guardar],'marcado_1');
% [frecs, pot] = buscar_armonicos(x(3.375*fs:3.445*fs),kaiser(N,beta3),fs,[0.05 1],[1 guardar],'marcado_1');
% [frecs, pot] = buscar_armonicos(x(3.525*fs:3.595*fs),kaiser(N,beta2),fs,[0.05 1],[1 guardar],'marcado_2');
% [frecs, pot] = buscar_armonicos(x(3.681*fs:3.750*fs),kaiser(N,beta2),fs,[0.05 1],[1 guardar],'marcado_3');
% [frecs, pot] = buscar_armonicos(x(3.833*fs:3.902*fs),kaiser(N,beta2),fs,[0.05 1],[1 guardar],'marcado_4');
% [frecs, pot] = buscar_armonicos(x(3.990*fs:4.058*fs),kaiser(N,beta2),fs,[0.05 1],[1 guardar],'marcado_5');
% 
% %Tono inicial y de llamada. Longitud de la señal 16000 muestras aprox.
% %--------------------------------------------------------------------------
N4 = length(x(1.6*fs:3.6*fs));
A_sl4 = A_sl2;
[beta4, D_ml4] = param_kaiser2( A_sl4, 0 ,N4, fs)
%[frecs, pot] = buscar_armonicos(x(1.6*fs:3.6*fs),kaiser(N4,beta4),fs,[0.05 1],[1 guardar],'espectro_tonoini'); 
%[frecs, pot] = buscar_armonicos(x(4.4*fs:6.4*fs),kaiser(N4,beta4),fs,[0.05 1],[1 guardar],'espectro_tonollam');
Delta_ml4 = D_ml4*fs/(2*pi)

%Señal dial-up
%--------------------------------------------------------------------------
N5 = floor((26.2-15.8)*fs)
A_sl5 = 100;
[beta5, D_ml5] = param_kaiser2(A_sl5 , 0 ,N5, fs);
Delta_ml5 = D_ml5*fs/(2*pi);
%[frecs, pot] = buscar_armonicos(x(15.8*fs:26.2*fs),kaiser(N5,beta5),fs,[0.0015 5],[1 guardar],'espectro_dialup');

%Discado Completo
%--------------------------------------------------------------------------
N6 = floor((4.058-3.375)*fs);
A_sl6 = A_sl2;
[beta6, D_ml6] = param_kaiser2(A_sl6 , 0 ,N6, fs)
Delta_ml6 = D_ml6*fs/(2*pi);
Delta_ml6 = 4;
[beta6, A_sl6] = param_kaiser2(0 , Delta_ml6 ,N6, fs)
wvtool(kaiser(N6,beta6),rectwin(N6))
[frecs, pot] = buscar_armonicos(x(3.375*fs:4.058*fs),kaiser(N6,beta6),fs,[0.006 50],[1 guardar],'espectro_discado');
%[frecs, pot] = buscar_armonicos(x(3.375*fs:4.058*fs),rectwin(N6),fs,[0.015 10],[1 guardar],'espectro_discado');

%--------------------------------------------------------------------------
datos = [A_sl, Dml_HHB, N, 2^((nextpow2(N+1))+2),beta1;...
        A_sl2, Delta_ml2, N, 2^((nextpow2(N+1))+2),beta2;...
        A_sl3, Delta_ml3, N, 2^((nextpow2(N+1))+2), beta3;...
        A_sl4, Delta_ml4, N4, 2^((nextpow2(N4+1))+2), beta4;...
        A_sl5, Delta_ml5, N5, 2^((nextpow2(N5+1))+2) beta5;...
        A_sl6, Delta_ml6, N6, 2^((nextpow2(N6+1))+2) beta6]
        
%Pruebo con el tono de mayor exigencia en cuanto a resolución en frecuen    cia
%f1 = 941 Hz f2 = 1209 Hz. Y le agrego ruido blanco.


% f1 = 941; 
% f2 = 1209;
% t = 1/fs*(0:N-1);
% %t = 0:1/fs:1;
% x1 = cos(2*pi*f1.*t) + cos(2*pi*f2.*t);
% Pot_x1 = 10*log10(sum(x1.^2));
% M = length(x1);
% noise = randn(1,M);
% Pot_noise = 10*log10(sum(noise.^2));
% SNR = Pot_x1-Pot_noise
% y = x1+noise;
%
% [frecs, pot] = buscar_armonicos(y,kaiser(N,beta1)',fs,0.2,1,'espect_1ernro_kbeta1');
% [frecs, pot] = buscar_armonicos(y,kaiser(N,beta2)',fs,0.2,1,'espect_1ernro_kbeta2');
% frecs, pot] = buscar_armonicos(y,kaiser(N,beta3)',fs,0.2,1,'espect_1ernro_kbeta3');
% frecs, pot] = buscar_armonicos(y,hamming(N)',fs,0.2,1,'espect_1ernro_hamming');

