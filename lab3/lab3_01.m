% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<*CLALL>
close all
clc

% options
o = optimset();
o = optimset(o, 'MaxIter', 10);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

f = @(x) 3*x(1)^2 + 6*x(2)^2 - 2*x(1)*x(2) - 3*x(1) + 6;

x0 = [2, -5];

% a.)
% minimum search with fminsearch
xmin = fminsearch(f, x0, o);

% display results in command window and plot
fprintf('Minimum of f(x) = %f at x = (%f, %f)\n', f(xmin), xmin(1), xmin(2));

% plot with meshgrid in one windows and contour in another window
allocation = -10:0.1:10;
[X, Y] = meshgrid(allocation, allocation);
Z = 3*X.^2 + 6*Y.^2 - 2*X.*Y - 3*X + 6;

figure(1);
hold on;
grid on;

mesh(X, Y, Z);
plot3(xmin(1), xmin(2), f(xmin), 'r*', 'MarkerSize', 10);

xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('f(x, y) = 3x^2 + 6y^2 - 2xy - 3x + 6');
legend('f(x, y)', 'minimum');
hold off;
view(-45, 30);

figure(2);
hold on;
grid on;

contour(X, Y, Z, 20);
plot(xmin(1), xmin(2), 'r*', 'MarkerSize', 10);

legend('f(x, y)', 'minimum');
xlabel('x');
ylabel('y');
title('f(x, y) = 3x^2 + 6y^2 - 2xy - 3x + 6');
hold off;

% b.)
% minimum search with fmincon
A = [-1, 0; 0, 1];
B = [0; 0];
Aeq = [];
Beq = [];
LB = [];
UB = [];
nonlcon = @(x) NonLcon_01(x);

xmin2 = fmincon(f, x0, A, B, Aeq, Beq, LB, UB, nonlcon, o);

% display results in command window and plot
fprintf('Minimum of f(x) = %f at x = (%f, %f)\n', f(xmin2), xmin2(1), xmin2(2));

% plot with meshgrid in one windows and contour in another window
allocation = -10:0.1:10;
[X, Y] = meshgrid(allocation, allocation);
Z = 3*X.^2 + 6*Y.^2 - 2*X.*Y - 3*X + 6;

figure(3);
hold on;
grid on;

mesh(X, Y, Z);
plot3(xmin2(1), xmin2(2), f(xmin2), 'r*', 'MarkerSize', 10);

xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('f(x, y) = 3x^2 + 6y^2 - 2xy - 3x + 6');
legend('f(x, y)', 'minimum');
hold off;
view(-45, 30);

figure(4);
hold on;
grid on;

contour(X, Y, Z, 20);
plot(xmin2(1), xmin2(2), 'r*', 'MarkerSize', 10);

legend('f(x, y)', 'minimum');
xlabel('x');
ylabel('y');
title('f(x, y) = 3x^2 + 6y^2 - 2xy - 3x + 6');
hold off;
