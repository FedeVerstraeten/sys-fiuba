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
-> e_th := energy threshold [0;1]
-> time_div := time division
-> min_peak := min peak frequency

output:
<- dig_out := digits vector
----------------------------------------------------------- 
%}

function [dig_out] = dtmf_decoder(x_in,fs,e_th,time_div,min_peak)

  dig_out = [];
  dig_dec = [];
  
  % Signal window: #samples/time_division
  win = floor(length(x_in)/time_div);

  % Signal limits initialization
  sig_init=1;
  sig_fin=0;
  
  % Max energy power of the signal
  max_pow = sum(x_in.^2);
  
  for i = 1:length(x_in)-win
    
    % Silence detect
    if silence_detector(x_in(i:i+(win-1)),e_th,max_pow)

      % i-index is ahead of sig_init+1
      % by a previous signal detection
      % Refresh final singal time
      if i > sig_init +1
          sig_fin = i;
      end          

      if sig_init < sig_fin

        % transform DFT signal
        ventana = kaiser(length(x_in(sig_init : sig_fin)),5.4)';
        %ventana = ones(1,length(x_in(sig_init : sig_fin)));
        ventana = length(ventana)*ventana/sum(ventana);
        x_dig=x_in(sig_init : sig_fin).*ventana;
        N = length(x_dig); 
        NFFT = max(2^nextpow2(N), 1024);
        T_x = fft(x_dig,NFFT)/N;
 
        % find peaks freq
         k = fs/2*linspace(0,1,NFFT/2+1);
        [pks,locs] = findpeaks(2*abs(T_x(1:NFFT/2+1)),k','MinPeakHeight',min_peak);
        
        figure;
        plot(linspace(0,fs,NFFT),abs(T_x));
        
        
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
-> max_pow : = maximum power of the input signal
----------------------------------------------------------- 
%}

function [sil_detect] = silence_detector(x_sig,e_th,max_pow)

  % Energy signal
  res = sum(x_sig.^2);

  if (res/max_pow < e_th)
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
  
  row=1;
  col=1;
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
  disp('find digit in');
  % Return digit
  digit_dec=dig_matrix(row,col);
end

