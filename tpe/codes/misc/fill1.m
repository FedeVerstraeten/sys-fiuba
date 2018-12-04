function Hd = fill1(order, fs, f1, f2)
%FILTRODEPRUEBA Returns a discrete-time filter object.
% MATLAB Code
% Generated by MATLAB(R) 9.2 and the Signal Processing Toolbox 7.4.

% FIR Window Bandpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = fs;  % Sampling Frequency

N    = order;     % Order
Fc1  = f1;      	% First Cutoff Frequency
Fc2  = f2;      	% Second Cutoff Frequency
flag = 'scale';  	% Sampling Flag
% Create the window vector for the design algorithm.
win = rectwin(N+1);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag);
Hd = dfilt.dffir(b);

end
