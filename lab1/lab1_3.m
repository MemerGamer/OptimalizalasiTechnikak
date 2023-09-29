clear all
close all
clc

% f(x,y) = x^2 + y^2
x = -10:0.1:10;
y = -15:0.1:16;
[xr, yr] = meshgrid(x,y);
fe = xr.^2 + yr.^2;
mesh(xr,yr,fe)
hold on
plot3(1,1,2,'*r')

figure
contour(xr,yr,fe)
