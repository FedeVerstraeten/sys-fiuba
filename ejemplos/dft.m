close all;
clear all;
format long;

x = [1 1 1 1 0 0 1 1 0 0];

Nv = 4;
window = ones(Nv, 1);
overlap = 2;

[S F T] = specgram(x, Nv, 16000, window, overlap);

F
T
%x_r_m = ifft(abs(S).*exp(i.*angle(S)));

x_r = zeros(1, length(x));

%[m n] = size(x_r_m);


subplot(3,1,1),stem(x);
subplot(3,1,2),stem(abs(ifft(abs(S'.*exp(i.*angle(S'))))));
%subplot(3,1,2),stem(x_r_m(1,:));

