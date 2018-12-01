%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: dtmf_decoder.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------
%}

%{ 
-------------------------------------------------------------- 
Decodificador DTMF a díditos (DTMF decoder)
--------------------------------------------------------------
PARAMETERS:

input:
-> x_in := input signal
-> fs := sampling frequency 
-> e_th := energy threshold 
-> time_div: time division

output:
<- dig_out := digits vector
----------------------------------------------------------- 
%}

function [dig_out] = dtmf_decoder(x_in,fs,e_th,time_div)

  dig_out = [];
  dig_dec = [];
  
  % Signal window: #samples/time_division
  win = floor(length(x_in)/time_div);

  % Signal limits initialization
  sig_init=1;
  sig_fin=0;

  % Min peak FFT
  min_peak = 0.1;
  
  for i = 1:length(x_in)-win
    
    % Silence detect
    if silence_detector(x_in(i:i+(win-1)),e_th)

      % i-index is ahead of sig_init+1
      % by a previous signal detection
      % Refresh final singal time
      if i > sig_init +1
          sig_fin = i;
      end          

      if sig_init < sig_fin

        % transform DFT signal
        x_dig=x_in(sig_init : sig_fin);
        N = length(x_dig); 
        NFFT = 2^nextpow2(N);
        T_x = fft(x_dig,NFFT)/N;
 
        % find peaks freq
         k = fs/2*linspace(0,1,NFFT/2+1);
        [pks,locs] = findpeaks(2*abs(T_x(1:NFFT/2+1)),k','MinPeakHeight',min_peak);
        figure;
        plot(k ,2*abs(T_x(1:NFFT/2+1)),locs,pks,'ro','Markersize',3)
        text(locs,pks, num2str(locs,'%.0f'));
        axis ([0 1700 0 max(pks)*1.1]);
      
        
        % find indexes in freq vectors
        dig_dec=find_digit(locs(1),locs(2));
        
        % Concat decoded digit
        dig_out = [dig_out dig_dec];
      end

      % Refresh init singal time
      sig_init= i; 
    end

    % Signal detect
    % Only increment cursor i  
  
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

%{
--------------------------------------------------------------
 Decodificador DTMF a díditos (DTMF decoder)
-------------------------------------------------------------- 

PARAMETERS:

input:
-> dig_x := row frequency position
-> dig_y := column frequency position

output:
<- digit_dec := digit decoded from digits matrix
----------------------------------------------------------- 
%}

function [digit_dec] = find_digit(dig_x,dig_y)
  
  % Digits matrix
  dig_matrix=['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];

  % Rows matrix DTMF
  fx = [697, 770, 852, 941];

  % Columns matrix DTMF
  fy = [1209, 1336, 1477, 1633];
  
  % 95 percent coincidence in "Table value vs. FFT"
  for idx=1:length(fx)
    if abs(dig_x-fx(idx))/fx(idx) < 0.05
      row=idx;
    end
  end
  
   % 95 percent coincidence in "Table value vs. FFT"
  for idx=1:length(fy)
    if abs(dig_y-fy(idx))/fy(idx) < 0.05
      col=idx;
    end
  end
 
  % Return digit
  digit_dec=dig_matrix(row,col);
end

