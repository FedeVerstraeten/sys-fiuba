% Example reconstruction signal

R=20;
r=(0:1:(R-1))+eps; % eps: epsilon value for deafult

a=sin(r*pi/2)./(r*pi);

T=2; % Period
Ts=0.01; % Samples
t=0:Ts:T;
x=ones(1,length(t))*a(1);

for k=1:(length(a)-1)
    x = x + a(k+1)*exp((j*2*pi*k*t)/T) + conj(a(k+1))*exp((-j*2*pi*k*t)/T);
end

% Output: x = 1+2cos(2*(2*pi/T)*t)
figure
plot(t,x) % graphic signal
figure
stem(r,a) % fourier series

