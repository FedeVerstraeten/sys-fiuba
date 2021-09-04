%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: buscar_armonicos.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------
Funcion que devuelve los picos de la fft y la grafica y la 
guarda si se requiere.
Si plotear = 1 plotea y guarda el espectro en graficos.

--------------------------------------------------------------

buscar_armonicos

--------------------------------------------------------------
%}

function [frecs, pot] = buscar_armonicos(senial,ventana, fs, nivel, opciones, nombre)

  home_path='/home/fverstra/Repository/sys-fiuba/tpe/';
  img_path=[home_path 'graph/ej3/'];
  
  L = length(ventana);
  x = senial(1:L).*ventana;
  
  %Análisis en frecuencia
  NFFT = 2^((nextpow2(L+1))+2);           %Siguiente potencia de 2 de la long de x2
  T_x = fft(x,NFFT)/L;          %Transformada de la señal.
  k = fs/2*linspace(0,1,NFFT/2+1);                            %creo un eje de frecuencias en Hz
  [pks,locs] = findpeaks(2*abs(T_x(1:NFFT/2+1)),k','MinPeakHeight',nivel(1),'MinPeakDistance',nivel(2));   %busco los máximos

  if (opciones(1))
      figure('Name',nombre)%,'visible','off')          
      plot(k ,2*abs(T_x(1:NFFT/2+1)),locs,pks,'ro','Markersize',3)
      text(locs,pks, num2str(locs,'%.0f'));
      if(locs(length(locs)) < (fs/4))
          limitex = fs/4;
      else
          limitex = fs/2;
      end
      axis ([0 limitex 0 max(pks)*1.1]);
      xlabel ('Frecuencia [Hz]');
      ylabel ('Amplitud');
      grid minor;
      if(opciones(2)) 
          print([img_path nombre '.png'],'-dpng'); 
      end
  end

  frecs = locs;
  pot = pks;

end