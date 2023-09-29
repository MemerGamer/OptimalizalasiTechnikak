clear all
close all
clc

t = 0:0.1:20;
a = 1;
f = 0.3;
x = a * sin(2*pi*f*t);
y =  a * cos(2*pi*f*t);
u = 3 * ones(size(t));

plot3(x,y,u)
grid on;
xlabel("x")
ylabel("y")
zlabel("z")