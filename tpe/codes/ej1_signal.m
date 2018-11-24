clear all;
close all;
clc;

path_wav='/home/fverstra/Repository/sys-fiuba/tpe/modemDialing.wav';

% Read file
[x,fs,nb]=wavread(path_wav);

% Time axis
Ts = 1/fs;
N  = (length(x)-1)/fs;
t  = 0:Ts:N;

% Plot figure
figure(1);
plot(t,x);
axis([0 N -1 1]);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid;