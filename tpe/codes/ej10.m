%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej10.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°10

----------------------------------------------------------- 
%}

%Diseño los filtros pasabanda

f1 = 697; f2 = 770; f3 = 852; f4 = 941;
f5 = 1209; f6 = 1336; f7 = 1477; f8 = 1633;
%--------------------------------------------------------------------------

h697 = disenio_filtro(f1-50, f1-1, f1+1, f1+(f2-f1)/2-5); 
%{
h770 = disenio_filtro(f2-(f2-f1)/2+5, f2-1, f2+1, f2+(f3-f2)/2-5);
h852 = disenio_filtro(f3-(f3-f2)/2+5, f3-1, f3+1, f3+(f4-f3)/2-5);
h941 = disenio_filtro(f4-(f4-f3)/2+5, f4-1, f4+1, f4+(f5-f4)/2-5);
h1209 = disenio_filtro(f5-(f5-f4)/2+5, f5-1, f5+1, f5+(f6-f5)/2-5);
h1336 = disenio_filtro(f6-(f6-f5)/2+5, f6-1, f6+1, f6+(f7-f6)/2-5);
h1477 = disenio_filtro(f7-(f7-f6)/2+5, f7-1, f7+1, f7+(f8-f7)/2-5);
h1633 = disenio_filtro(f8-(f8-f7)/2+5, f8-1, f8+1, f8+(1750-f8)/2-5);

hfvt = fvtool(h697,h770,h852,h941,h1209,h1336,h1477,h1633)
%}

%--------------------------------------------------------------------------
%Obtencion de las señales filtradas.
% Acá directamente con filter filtras x con cada uno de los filtros (señal
% en el tiempo)

y697 = filter(h697.Numerator,1,x);
%{
y770 = filter(h770.Numerator,1,x);
y852 = filter(h852.Numerator,1,x);
y941 = filter(h941.Numerator,1,x);

y1209 = filter(h1209.Numerator,1,x);
y1336 = filter(h1336.Numerator,1,x);
y1477 = filter(h1477.Numerator,1,x);
y1633 = filter(h1633.Numerator,1,x);
%}

%Respuesta al impulso
imp = zeros(1,length(h697.Numerator));
imp(1) = 1;
h = filter(h697.Numerator,1,imp);

%verifico que la respuesta al impulso es simétrica.
%Para confirmar que es de fase lineal.
plot(h)









%Transformada del discado filtrado
%==========================================================================
% N6 = length(y)
% A_sl6 = 60;
% [beta6, D_ml6] = param_kaiser2(A_sl6 , 0 ,N6, fs)
% Delta_ml6 = D_ml6*fs/(2*pi);
% Delta_ml6 = 4;
% [beta6, A_sl6] = param_kaiser2(0 , Delta_ml6 ,N6, fs)
% wvtool(kaiser(N6,beta6),rectwin(N6))
% [frecs, pot] = buscar_armonicos(y,kaiser(N6,beta6),fs,[0.015 10],[1 0],'espectro_discadokai');
% [frecs, pot] = buscar_armonicos(y,rectwin(N6),fs,[0.015 10],[1 0],'espectro_discado');

%Espectrograma de la señal filtrada..
%==========================================================================
% N = 512;
% D_ml = 40; 
% [beta D_ml] = param_kaiser2( 60 , 0, N, fs);
% Delta_ml = D_ml*fs/(2*pi)
% spectrogram(x1,kaiser(N,beta),480,N,fs,'yaxis')

%hfvt = fvtool(filtro_pb,1);
%legend(hfvt,'Hamming','Hann')
