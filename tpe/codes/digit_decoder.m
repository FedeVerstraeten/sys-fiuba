%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: digit_decoder.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

--------------------------------------------------------------
PARAMETERS:

input:
-> mat_dec := 

output:
<- dig_out := energy estimator array
----------------------------------------------------------- 
%}
function [dig_out] = digit_decoder(e697,e770,e852,e941,e1209,e1336,e1477,e1633)

  % Digits matrix
  dig_out=[];
  
  % Inicio en silencio
  prev_det='S';
  dig_det='S';
  
  N=length(e697);
  
  for i=1:N
    % Digit 1
    if e697(i) && e1209(i)
      dig_det='1';
    % Digit 2
    elseif e697(i) && e1336(i)
      dig_det='2';
    % Digit 3
    elseif e697(i) && e1477(i)
      dig_det='3';
    % Digit A
    elseif e697(i) && e1633(i)
      dig_det='A';
    % Digit 4
    elseif e770(i) && e1209(i)
      dig_det='4';
    % Digit 5
    elseif e770(i) && e1336(i)
      dig_det='5';
    % Digit 6  
    elseif e770(i) && e1477(i)
      dig_det='6';
    % Digit B  
    elseif e770(i) && e1633(i)
      dig_det='B';
    % Digit 7
    elseif e852(i) && e1209(i)
      dig_det='7';
    % Digit 8
    elseif e852(i) && e1336(i)
      dig_det='8';
    % Digit 9  
    elseif e852(i) && e1477(i)
      dig_det='9';
    % Digit C
    elseif e852(i) && e1633(i)
      dig_det='C';
    % Digit *
    elseif e941(i) && e1209(i)
      dig_det='*';
    % Digit 0
    elseif e941(i) && e1336(i)
      dig_det='0';
    % Digit #  
    elseif e941(i) && e1477(i)
      dig_det='#';
    % Digit D
    elseif e941(i) && e1633(i)
      dig_det='D';
      
    % Silence
    else 
      dig_det='S';
    end
    
    % Validacion repeticions por iteracion
    if dig_det ~= prev_det
      
      % Guardo deteccion
      prev_det = dig_det;
      
      % si no es silencion
      if dig_det ~= 'S'
        dig_out = [dig_out dig_det];
      end
   end
end
