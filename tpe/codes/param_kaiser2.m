%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Se�ales y sistemas
 @Project: TPE - Demodulaci�n de tonos de discado de tel�fono
--------------------------------------------------------------
 @Filename: buscar_armonicos.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

param_kaiser2
--------------------------------------------------------------
 Funci�n que calcula los par�metros de la ventana de kaiser en funci�n de:
 A_sl : Relaci�n en dB entre las amplitudes m�ximas del l�bulo ppal
           y el lobulo secundario.
 Delta_ml : Anchura del l�bulo ppal. Distancia sim�trica entre los cruces
            centrales por cero.
N : Longitud de la ventana.
--------------------------------------------------------------
%}
function [beta, param2] = param_kaiser2(A_sl, Delta_ml,N, fs)
  Dml_norm = 2*pi*Delta_ml/fs;

  if(N == 0)
      n = 24*pi*(A_sl + 12)/(155*Dml_norm)+1;
      N = floor(n) + 1;
      param2 = N;
  elseif(Delta_ml == 0)
      Dml_norm = (24*pi*(A_sl+12))/((N-1)*155);
      param2 = Dml_norm;
  else
      A_sl = ((N-1)*155*Dml_norm)/(24*pi) - 12; 
      param2 = A_sl;
  end

  if (A_sl <= 13.26)
      beta = 0;
  elseif (A_sl <= 60)
      beta = 0.76609*((A_sl-13.26)^0.4) + 0.09834*(A_sl-13.26);
  else
      beta = 0.12438*(A_sl+6.3);
  end
end

    
    