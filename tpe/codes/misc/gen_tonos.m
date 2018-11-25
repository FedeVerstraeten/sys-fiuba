function [t, x_out] = gen_tonos(fs, N, D, S)%N = vector de números a discar
                           %D = Vector de duración del número
                           %S = Vector de duración de los silencios

fxa = 1209; fxb = 1336; fxc = 1477; fxd = 1633;
fya = 697; fyb = 770; fyc = 852; fyd = 941;
x_out = 0;
tsec = 0;

for i = 1:length(N)
    t = 0:1/fs:D(i);
    S2 = floor(S(i)*fs);
    ceros = zeros(1,S2);
    switch N(i)
        case 1 
            x = [ceros cos(2*pi*fxa.*t) + cos(2*pi*fya.*t)];
        case 2
            x = [ceros cos(2*pi*fxb.*t) + cos(2*pi*fya.*t)];
        case 3
            x = [ceros cos(2*pi*fxc.*t) + cos(2*pi*fya.*t)];
        case 'A'
            x = [ceros cos(2*pi*fxd.*t) + cos(2*pi*fya.*t)];
        case 4
            x = [ceros cos(2*pi*fxa.*t) + cos(2*pi*fyb.*t)];
        case 5
            x = [ceros cos(2*pi*fxb.*t) + cos(2*pi*fyb.*t)];
        case 6
            x = [ceros cos(2*pi*fxc.*t) + cos(2*pi*fyb.*t)];
        case 'B'
            x = [ceros cos(2*pi*fxd.*t) + cos(2*pi*fyb.*t)];
        case 7
            x = [ceros cos(2*pi*fxa.*t) + cos(2*pi*fyc.*t)];
        case 8
            x = [ceros cos(2*pi*fxb.*t) + cos(2*pi*fyc.*t)];
        case 9
            x = [ceros cos(2*pi*fxc.*t) + cos(2*pi*fyc.*t)];
        case 'C'
            x = [ceros cos(2*pi*fxd.*t) + cos(2*pi*fyc.*t)];
        case '*'
            x = [ceros cos(2*pi*fxa.*t) + cos(2*pi*fyd.*t)];
        case 0
            x = [ceros cos(2*pi*fxb.*t) + cos(2*pi*fyd.*t)];
        case '#'
            x = [ceros cos(2*pi*fxc.*t) + cos(2*pi*fyd.*t)];
        case 'D'
            x = [ceros cos(2*pi*fxd.*t) + cos(2*pi*fyd.*t)];
        otherwise
            D2 = floor(D(i)*fs);
            ceros_err = zeros(1,D2);
            x = [ceros ceros_err];
    end
    x_out = [x_out x];
    tsec = tsec + D(i) + S(i);    
end

N = length(x_out);
t = linspace(0,tsec,N);            

end