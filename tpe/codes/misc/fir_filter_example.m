clear all;
close all;
clc;

fs=1000;
fp=70;
orden=50;

% Creo filtro orden 50 con dispersion 5% y ventana de kaiser
b=fir1(2 * orden, [fp*0.95 fp*1.05]/(fs/2),kaiser(2*orden+1,3));

% Respuesta en frecuencia TZ
[H,w]=freqz(b,1,1000,fs);

% Aplico filtro
h=filter(b,1,[1;zeros(orden*2,1)]);

figure;

% Respuesta al impulso en tiempo discreto h[n]
subplot(221),plot(0:length(h)-1,h,'o--')
xlabel('n'),ylabel('h[n]'),axis tight,grid on

% Respuesta en frecuencia de H[w] en dB
subplot(222),plot(w(w<200),20*log10(abs(H(w<200))))
xlabel('\Omega en Hz ;-))'),ylabel('|H[\Omega]| en dB')
axis tight,grid on

% Fase de H
subplot(223),plot(w(w<200),unwrap(angle(H(w<200))))
xlabel('\Omega en Hz ;-))'),ylabel('angle(H[\Omega])')
axis tight,grid on

% TZ plano complejo con polos y ceros
subplot(224),zplane(b,1),axis([-1.1 1.1 -1.1 1.1])
