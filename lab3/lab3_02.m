% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<*CLALL>
close all
clc

% options
o = optimset();
o = optimset(o, 'MaxIter', 4);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

f = @(x) -x(1)*x(2);
x0 = [2, 3];

% a.)
% minimum search
xmin = fminsearch(f, x0, o);
fprintf('A minimum: (%f, %f)\n', xmin(1), xmin(2));

% plot with meshgrid in one windows and contour in another window
figure(1);
hold on;
grid on;

allocation = -5:0.1:5;
[X, Y] = meshgrid(allocation, allocation);
Z = -X.*Y;

mesh(X, Y, Z);
plot3(xmin(1), xmin(2), f(xmin), 'r*');

xlabel('x');
ylabel('y');
zlabel('z');
title('f(x) = -x(1)*x(2)');
legend('f(x) = -x(1)*x(2)', 'minimum');
view(55, 30);

figure(2);
hold on;
grid on

contour(X, Y, Z);
plot3(xmin(1), xmin(2), f(xmin), 'r*');

xlabel('x');
ylabel('y');
title('f(x) = -x(1)*x(2)');
legend('f(x) = -x(1)*x(2)', 'minimum');

% b.)
% minimum search with fmincon
% x(2) + x(1)*exp(x(1)) = 0

% constraints
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [];
UB = [];
nonlcon = @(x) NonLcon_02(x);

xmin2 = fmincon(f, x0, A, B, Aeq, Beq, LB, UB, nonlcon, o);
fprintf('B minimum: (%f, %f)\n', xmin2(1), xmin2(2));

% plot with meshgrid in one windows and contour in another window
figure(3);
hold on;
grid on;

allocation = -5:0.1:5;
[X, Y] = meshgrid(allocation, allocation);
Z = -X.*Y;

mesh(X, Y, Z);
plot3(xmin2(1), xmin2(2), f(xmin2), 'r*');

xlabel('x');
ylabel('y');
zlabel('z');
title('f(x) = -x(1)*x(2)');
legend('f(x) = -x(1)*x(2)', 'minimum');
view(-45, 30);

figure(4);
hold on;
grid on

contour(X, Y, Z);
plot3(xmin2(1), xmin2(2), f(xmin2), 'r*');

xlabel('x');
ylabel('y');
title('f(x) = -x(1)*x(2)');
legend('f(x) = -x(1)*x(2)', 'minimum');
