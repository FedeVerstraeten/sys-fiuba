% Example reconstruction signal

a=[1 0 1]; % a_k
T=2; % Period
Ts=0.01; % Samples
t=0:Ts:T;
x=ones(1,length(t))*a(1);

for k=1:(length(a)-1)
    x = x + a(k+1)*exp((j*2*pi*k*t)/T) + conj(a(k+1))*exp((-j*2*pi*k*t)/T);
end

% Output: x = 1+2cos(2*(2*pi/T)*t)

plot(t,x)

