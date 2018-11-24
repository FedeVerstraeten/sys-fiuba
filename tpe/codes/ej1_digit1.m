clear all;
close all;
clc;

path_wav='/home/fverstra/Repository/sys-fiuba/tpe/data/modemDialing.wav';

% Read file
[x,fs,nb]=wavread(path_wav);

% Period sampling
Ts = 1/fs;

% Crop first dial from input signal
x2 = x(3.35*fs:3.47*fs);

% Final time = #samples * P.sampling
N  = (length(x2)-1)*Ts;

% Time axis
t2 = 0:Ts:N;
t2 = t2+3.35;

% Fourier transform
y2 = fft(x2);

%Clear base tone

% Plot
figure()
plot(t2,x2)

f2 = linspace(0, fs, length(y2)); 
figure()
plot(f2, abs(y2))