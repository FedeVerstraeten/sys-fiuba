%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej6.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°6

----------------------------------------------------------- 
%}

clear all;
close all;
clc;

home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
img_path=[home_path 'graph/ej6/'];
wav_file=[home_path 'data/modemDialing.wav'];

% Read file
[x,fs,nb]=wavread(wav_file);

% Period sampling
Ts = 1/fs;

% Final time = #samples * P.sampling
Tf  = (length(x)-1)*Ts;


% Select DTMF signal
xs=x(floor(3.301*fs):floor(4.200*fs));
ts  = 0:Ts:Tf;

%%
% Spectrogram
% S = spectrogram(x,window,noverlap,nfft,fs,OPTIONS)
fftn = 512;
win_size = fftn;
overlap = floor(fftn*0.8);

figure('Name','Espectrograma DTMF','visible','off');
spectrogram(xs, win_size, overlap, fftn,fs,'yaxis');

% Limits of frequencies axis
frq_axis=gca;
ylim(frq_axis, [0 2000]); %Hz
print([img_path 'ej6_spectrogram' '.png'],'-dpng');


%%
% Fourier transform

%Frequency analysis
N = length(xs); 
NFFT = 2^nextpow2(N);

% X(jw) = FFF{x(t)}
T_xs = fft(x,NFFT)/N;

% Freq. axis [Hz]
k = fs/2*linspace(0,1,NFFT/2+1);                           

% Search Max peak |X(jw)|
%[pks,locs] = findpeaks(2*abs(T_xs(1:NFFT/2+1)),k','MinPeakHeight',0.05)


% Graph coef. Fourier
figure('Name','transformada de fourier');%,'visible','off');          
plot(k ,2*abs(T_xs(1:NFFT/2+1)));%,locs,pks,'ro','Markersize',3);
%text(locs,pks, num2str(locs,'%.0f'));

axis([670 1700 0 1.5e-5]);
%axis([0 1500 0 max(pks)]);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud |X(f)|');
grid minor;
%print([img_path 'ej6_trans_fourier' '.png'],'-dpng');
