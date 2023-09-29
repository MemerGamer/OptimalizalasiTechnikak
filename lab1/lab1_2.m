clear all
close all
clc

% kor ha x es y =  a * sin(2*pi*f*t);
t = 0:0.1:20;
a = 1;
f = 0.3;

% spiral, terben no
x = a * t .* sin(2*pi*f*t);
y =  a * t .* cos(2*pi*f*t);
u = 3 * ones(size(t));

plot3(x,y,u)
hold on;

plot3(x,y,u+5)
grid on;

xlabel("x")
ylabel("y")
zlabel("z")

% spiral az ido folyaman
figure
plot3(x,y,t)
