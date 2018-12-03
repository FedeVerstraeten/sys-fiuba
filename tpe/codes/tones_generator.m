%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: tones_generator.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

 Generador de tonos (Tones generator)
-------------------------------------------------------------- 

PARAMETERS:

input:
-> fs := sampling frequency 
-> dig_vec  := (char) vector of digits
-> dur_vec  := (int) vector of [seconds] duration of the digit
-> sil_vec  := (int) vector of [seconds] duration of silences

output:
<- t  := time vector
<- x_out  := tone signal + silence
----------------------------------------------------------- 
%}

function [t, x_out] = tones_generator(fs, dig_vec, dur_vec, sil_vec)

x_out = [];
tsec = 0;

% Digits matrix
digits=['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];

% Rows matrix DTMF
fx = [697, 770, 852, 941];

% Columns matrix DTMF
fy = [1209, 1336, 1477, 1633];

for i = 1:length(dig_vec)
    
    t = 0:1/fs:dur_vec(i);
    S2 = floor(sil_vec(i)*fs);
    silence = zeros(1,S2);

    % Find in digits matrix
    dig=num2str(dig_vec(i),'%d');
    
    try find(digits==dig);
      [row,col]=find(digits==dig);
      x = [cos(2*pi*fx(row).*t) + cos(2*pi*fy(col).*t) silence];
    catch
      D2 = floor(dur_vec(i)*fs);
      digit_err = zeros(1,D2);
      x = [digit_err silence];
    end

    % Concat each signal digit
    x_out = [x_out x];
    tsec = tsec + dur_vec(i) + sil_vec(i);    
end

t = linspace(0,tsec,length(x_out));           

end
