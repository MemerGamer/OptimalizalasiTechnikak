clear all
close all
clc

x = -3:0.1:3;
y = -3:0.1:3;

[xr, yr] = meshgrid(x,y);

fe = x.*exp(-xr.^2-yr.^2);
mesh(xr,yr,fe)
figure
contour(xr, yr, fe)
