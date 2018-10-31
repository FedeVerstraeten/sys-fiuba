%% Ejemplo 1: 2 senoidales superpuestas
clear all;
close all;
clc;


fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

figure(1);
x = 0.5*sin(2*pi*f1*t) + sin(2*pi*f2*t);
plot(t,x);
axis([0 1 -2 2]);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid;

figure(2);
X = abs(fft(x));
plot(linspace(-fs/2,fs/2,N),fftshift(X));
axis([-1000 1000 0 5000]);
xlabel('frecuencia (Hz)');
ylabel('abs(X(f))');
grid;

%% Ejemplo 2: 2 senoidales no superpuestas
clear all;
clc;

fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

w1 = [ones(1,(N-1)/2)   zeros(1,(N-1)/2 + 1)];
w2 = [zeros(1,(N-1)/2)  ones(1,(N-1)/2 + 1) ];

figure(3);
x = 0.5*sin(2*pi*f1*t).*w1 + sin(2*pi*f2*t).*w2;
plot(t,x);
axis([0 1 -2 2]);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid;

figure(4);
X = abs(fft(x));
plot(linspace(-fs/2,fs/2,N),fftshift(X));
axis([-1000 1000 0 2500]);
xlabel('frecuencia (Hz)');
ylabel('abs(X(f))');
grid;

%% Ejemplo 3: 2 senoidales no superpuestas - analisis con ventanas
clear all;
clc;

fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

w1 = [ones(1,(N-1)/2)   zeros(1,(N-1)/2 + 1)];
w2 = [zeros(1,(N-1)/2)  ones(1,(N-1)/2 + 1) ];

figure(5);
x = 0.5*sin(2*pi*f1*t).*w1 + sin(2*pi*f2*t).*w2;

Nw = (N-1)/5;
W  = hanning(Nw)';
W1 = [W zeros(1,4*Nw + 1)];
W2 = [zeros(1,Nw) W zeros(1,3*Nw + 1)];
W3 = [zeros(1,2*Nw) W zeros(1,2*Nw + 1)];
W4 = [zeros(1,3*Nw) W zeros(1,Nw + 1)];
W5 = [zeros(1,4*Nw + 1) W];

plot(t,x,t,2*W1,t,2*W2,t,2*W3,t,2*W4,t,2*W5);
axis([0 1 -2 2]);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid;

figure(6);
subplot(5,2,1),plot(t,x.*W1),axis([0 1 -2 2]);
subplot(5,2,2),plot(linspace(-fs/2,fs/2,N),fftshift(abs(fft(x.*W1)))),grid,axis([-1000 1000 0 500]);
subplot(5,2,3),plot(t,x.*W2),axis([0 1 -2 2]);
subplot(5,2,4),plot(linspace(-fs/2,fs/2,N),fftshift(abs(fft(x.*W2)))),grid,axis([-1000 1000 0 500]);
subplot(5,2,5),plot(t,x.*W3),axis([0 1 -2 2]);
subplot(5,2,6),plot(linspace(-fs/2,fs/2,N),fftshift(abs(fft(x.*W3)))),grid,axis([-1000 1000 0 500]);
subplot(5,2,7),plot(t,x.*W4),axis([0 1 -2 2]);
subplot(5,2,8),plot(linspace(-fs/2,fs/2,N),fftshift(abs(fft(x.*W4)))),grid,axis([-1000 1000 0 500]);
subplot(5,2,9),plot(t,x.*W5),axis([0 1 -2 2]);
subplot(5,2,10),plot(linspace(-fs/2,fs/2,N),fftshift(abs(fft(x.*W5)))),grid,axis([-1000 1000 0 500]);

%% Ejemplo 4: Espectrogramas

% B = SPECGRAM(A,NFFT,Fs,WINDOW,NOVERLAP);

clear all;
clc;

fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

w1 = [ones(1,(N-1)/2)   zeros(1,(N-1)/2 + 1)];
w2 = [zeros(1,(N-1)/2)  ones(1,(N-1)/2 + 1) ];

x = 0.5*sin(2*pi*f1*t).*w1 + sin(2*pi*f2*t).*w2;

figure(7);
specgram(x,[],fs);
colormap(gray);
axis([0 D 0 1000]);

%% Ejemplo 5: Espectrogramas - Longitud de la ventana (senoidales no
%% superpuestas)

% B = SPECGRAM(A,NFFT,Fs,WINDOW,NOVERLAP);

clear all;
clc;

fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

w1 = [ones(1,(N-1)/2)   zeros(1,(N-1)/2 + 1)];
w2 = [zeros(1,(N-1)/2)  ones(1,(N-1)/2 + 1) ];

x = 0.5*sin(2*pi*f1*t).*w1 + sin(2*pi*f2*t).*w2;

figure(8);
subplot(2,2,1),specgram(x,1024,fs,128),colormap(gray),axis([0 D 0 500]),title('N=128');
subplot(2,2,2),specgram(x,1024,fs,256),colormap(gray),axis([0 D 0 500]),title('N=256');
subplot(2,2,3),specgram(x,1024,fs,512),colormap(gray),axis([0 D 0 500]),title('N=512');
subplot(2,2,4),specgram(x,1024,fs,1024),colormap(gray),axis([0 D 0 500]),title('N=1024');

%% Ejemplo 5: Espectrogramas - Longitud de la ventana (senoidales
%% superpuestas)

clear all;
clc;

fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

x = 0.5*sin(2*pi*f1*t) + sin(2*pi*f2*t);

figure(9);
subplot(2,2,1),specgram(x,1024,fs,128),colormap(gray),axis([0 D 0 500]),title('N=128');
subplot(2,2,2),specgram(x,1024,fs,256),colormap(gray),axis([0 D 0 500]),title('N=256');
subplot(2,2,3),specgram(x,1024,fs,512),colormap(gray),axis([0 D 0 500]),title('N=512');
subplot(2,2,4),specgram(x,1024,fs,1024),colormap(gray),axis([0 D 0 500]),title('N=1024');


%% Caracteristicas espectrales de las distintas ventanas
clear all;
clc;

f = linspace(-pi,pi,1024);
M = 30;

rect = ones(1,M+1);
hann = 0.5 -  0.5 *cos(2*pi*(0:M)/M);
hamm = 0.54 - 0.46*cos(2*pi*(0:M)/M);

RECT = fftshift(20*log10(abs(fft(rect,1024))/max(abs(fft(rect,1024)))));
HANN = fftshift(20*log10(abs(fft(hann,1024))/max(abs(fft(hann,1024)))));
HAMM = fftshift(20*log10(abs(fft(hamm,1024))/max(abs(fft(hamm,1024)))));

figure(10);
plot(0:M,rect,'r',0:M,hann,'g',0:M,hamm,'b'),grid,legend('rectangular','hanning','hamming'),axis([-5 35 -0.1 1.1]);
figure(11);
plot(f,RECT,'r',f,HANN,'g',f,HAMM,'b'),grid,axis([-pi pi -100 5]),xlabel('w (rad)'),ylabel('20*log10(abs(W(w)))'),legend('rectangular','hanning','hamming');

%% Senoidales superpuestas - Analisis con distintas ventanas

clear all;
clc;

fs = 8000;
Ts = 1/fs;

f1 = 100;
f2 = 200;
D  = 1;    % duracion = 1seg
t  = 0:Ts:D;
N  = length(t);

x = 0.5*sin(2*pi*f1*t) + sin(2*pi*f2*t);

figure(12);
M = 512;
subplot(2,2,1),specgram(x,1024,fs,ones(M+1,1)),colormap(gray),caxis([-100 50]),axis([0 D 0 1000]),title('rectangular');
subplot(2,2,2),specgram(x,1024,fs,hanning(M)),colormap(gray), caxis([-100 50]),axis([0 D 0 1000]),title('hanning');
subplot(2,2,3),specgram(x,1024,fs,hamming(M)),colormap(gray), caxis([-100 50]),axis([0 D 0 1000]),title('hamming');

%% señal de habla
close all;

[x,fs] = wavread('habla.wav');
specgram(x,2048,fs,512,400),caxis([-30 30]),colorbar;