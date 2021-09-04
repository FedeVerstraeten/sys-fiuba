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

param_kaiser2
--------------------------------------------------------------
 Función que calcula los parámetros de la ventana de kaiser en función de:
 A_sl : Relación en dB entre las amplitudes máximas del lóbulo ppal
           y el lobulo secundario.
 Delta_ml : Anchura del lóbulo ppal. Distancia simétrica entre los cruces
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

    
    