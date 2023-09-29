clear all
close all 
clc 

t = 0: 0.1: 20;
f = 0.3;
a = 1;

x = a * sin (2*pi*f*t);

z = randn(size(t)) * 0.5;

xz = x +z;

subplot(1,2,1)
plot(t, x, 'r')
legend('sinus')

subplot(2,2,2)
plot(t, xz, 'b')
legend('zaj')

subplot(2,2,4)
plot(t,x,'r', t, xz, '.');
legend('zajos sinus')

