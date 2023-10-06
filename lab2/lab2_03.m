clear all %#ok<CLALL>
close all
clc

% options
o = optimset();
o = optimset(o, 'MaxIter', 1e3);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

% function
z0 = [0, 0];
f = @(z) -z(1) * exp(-z(1)^2 - z(2)^2);

% minimum search
zmin = fminsearch(f, z0, o);

% maximum search
fMax = @(z) -f(z);
zmax = fminsearch(fMax, z0, o);

% plot
allocation = -3:0.1:3;
[X, Y] = meshgrid(allocation, allocation);
Z = -X .* exp(-X.^2 - Y.^2);

figure(1)
mesh(X, Y, Z)
hold on
plot3(zmin(1), zmin(2), f(zmin), 'g.', 'MarkerSize', 30)
plot3(zmax(1), zmax(2), f(zmax), 'r.', 'MarkerSize', 30)
xlabel('x')
ylabel('y')
zlabel('z')
title('f(x, y) = -x * exp(-x^2 - y^2)')
legend('f(x, y)', 'minimum', 'maximum')


