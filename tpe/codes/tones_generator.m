%{
--------------------------------------------------------------
 @Title:   FIUBA - 66.74 Señales y sistemas
 @Project: TPE - Demodulación de tonos de discado de teléfono
--------------------------------------------------------------
 @Filename: ej2_2.m
--------------------------------------------------------------
 @Authors:
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
--------------------------------------------------------------

Ejercicio N°2.2
----------------------------------------------------------- 
PARAMETERS:

input:
-> fs := Sampling frequency 
-> N  := (char) vector of digits
-> D  := (int) vector of temporary duration of the digit
-> S  := (int) vector of temporary duration of silences

output:
<- t  := Time vector
<- x_out  := Tone signal + silence
----------------------------------------------------------- 
%}

function [t, x_out] = tones_generator(fs, N, D, S)

x_out = 0;
tsec = 0;

% Digits matrix
dig=['1' '2' '3' 'A';'4' '5' '6' 'B';'7' '8' '9' 'C';'*' '0' '#' 'D'];

% Rows matrix DTMF
fx = [697, 770, 852, 941];

% Columns matrix DTMF
fy = [1209, 1336, 1477, 1633];

for i = 1:length(N)
    
    t = 0:1/fs:D(i);
    S2 = floor(S(i)*fs);
    silence = zeros(1,S2);

    % Find in digits matrix
    try find(dig==N(i));
      [row,col]=find(dig==N(i));
      x = [cos(2*pi*fx(row).*t) + cos(2*pi*fy(col).*t) silence];
    catch
      D2 = floor(D(i)*fs);
      digit_err = zeros(1,D2);
      x = [digit_err silence];
    end

    x_out = [x_out x];
    tsec = tsec + D(i) + S(i);    
end

t = linspace(0,tsec,length(x_out));           

end