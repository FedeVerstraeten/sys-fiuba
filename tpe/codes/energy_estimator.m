%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: energy_estimator.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

--------------------------------------------------------------
PARAMETERS:

input:
-> x_in := input signal
-> e_th := energy threshold
-> time_div := time division

output:
<- e_out := energy estimator array
----------------------------------------------------------- 
%}

function [e_out] = energy_estimator(x_in,e_th,time_div)

  e_out = zeros(1,length(x_in));
  
  % Signal window: #samples/time_division
  win = floor(length(x_in)/time_div);

  % Signal limits initialization
  sig_init=1;
  sig_fin=0;
  
  % Max energy power of the signal
  max_pow = sum(x_in.^2);
  
  for i = 1:length(x_in)-win
    
    % Silence detect
    if silence_detector(x_in(i:i+(win-1)),e_th)

      % i-index is ahead of sig_init+1
      % by a previous signal detection
      % Refresh final singal time
      if i > sig_init +1
          sig_fin = i;
      end          

      % Save previous detection
      % Set ones in [sig_in:sig_fin] period
      if sig_init < sig_fin     
        e_out(sig_init:sig_fin)=1;
      end

      % Refresh init signal time
      sig_init= i; 
    end

    % Signal detect
    % Only increment cursor i  
  
  end
  
  % Last pending window
  if i > sig_init +1
      sig_fin = i;
  end          
  if sig_init < sig_fin     
    e_out(sig_init:sig_fin)=1;
  end
end

%{
--------------------------------------------------------------
 Detector de silencios
-------------------------------------------------------------- 

PARAMETERS:

input:
-> x_sig := input signal
-> e_th := energy threshold
-> max_pow : = maximum power of the input signal
----------------------------------------------------------- 
%}

function [sil_detect] = silence_detector(x_sig,e_th)

  % Energy signal
  res = sum(x_sig.^2);

  if (res < e_th)
    % Silence detection
    sil_detect = true;
  else
    % Signal detection
    sil_detect= false;
  end
end