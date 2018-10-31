% Ejercicio 4.a

a=1;
m=4; % valor arbitrario
n=-2*m:2*m;

x=zeros(size(n));
x(n>=0 && n<m)=a;

stem(n,x);