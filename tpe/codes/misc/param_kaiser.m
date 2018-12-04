function [beta, M] = param_kaiser(delta, Delta_w, fs)

Dw_norm = 2*pi*Delta_w/fs;
A = -20*log10(delta);
M = (A - 8)/(2.285*Dw_norm);

if (A < 21)
    beta = 0;
elseif (A <= 50)
    beta = 0.5842*((A-21)^0.4) + 0.07886*(A-21);
else
    beta = 0.1102*(A-8.7);
end

end

    
    