clear all %#ok<CLALL>
close all
clc

% options
o = optimset();
o = optimset(o, 'MaxIter', 1e3);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

% function
z0 = [-3, 9];
f = @(z) 3*z(1)^2 + 2*z(2)^2 - 2*z(1)*z(2) - 3*z(1) +8;

% minimum search
zmin = fminsearch(f, z0, o);

% plot
[X, Y] = meshgrid(-5:0.1:5, -5:0.1:5);
Z = 3*X.^2 + 2*Y.^2 - 2*X.*Y - 3*X + 8;

figure(1)
mesh(X, Y, Z)
hold on
plot3(zmin(1), zmin(2), f(zmin), 'r.', 'MarkerSize', 30)
xlabel('x')
ylabel('y')
zlabel('z')
title('f(x, y) = 3x^2 + 2y^2 - 2xy - 3x + 8')


