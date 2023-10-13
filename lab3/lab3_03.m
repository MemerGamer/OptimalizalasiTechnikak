% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<*CLALL>
close all
clc

% options
o = optimset();
o = optimset(o, 'MaxIter', 10);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

f = @(x) 10*((x(1) - 3.5)^2) + 20*((x(2) - 4)^2);
x0 = [1, 2];

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
Z = 10*((X - 3.5).^2) + 20*((Y - 4).^2);

mesh(X, Y, Z);
plot3(xmin(1), xmin(2), f(xmin), 'r*');

xlabel('x');
ylabel('y');
zlabel('z');
title('f(x, y)=10*(x-3.5)^2+20*(y-4)^2 (meshgrid)');
view(160, 50);
legend('f(x, y)=10*(x-3.5)^2+20*(y-4)^2', 'minimum');

figure(2);
hold on;
grid on

contour(X, Y, Z);
plot3(xmin(1), xmin(2), f(xmin), 'r*');

xlabel('x');
ylabel('y');
title('f(x, y)=10*(x-3.5)^2+20*(y-4)^2 (contour)');
legend('f(x, y)=10*(x-3.5)^2+20*(y-4)^2', 'minimum');
% b.)
% minimum search with fmincon

% constraints
A = [
    1, 1;
    1, -1;
    -2, -1;
    -1/2, 1;
    -1, 0;
    ];

B = [
    6;
    1;
    -6;
    4;
    -1;
    ];
Aeq = [];
Beq = [];
LB = [];
UB = [];
nonlcon = [];

xmin2 = fmincon(f, x0, A, B, Aeq, Beq, LB, UB, nonlcon, o);
fprintf('B minimum: (%f, %f)\n', xmin2(1), xmin2(2));

% plot with meshgrid in one windows and contour in another window
figure(3);
hold on;
grid on;

allocation = -5:0.1:5;
[X, Y] = meshgrid(allocation, allocation);
Z = 10*((X - 3.5).^2) + 20*((Y - 4).^2);

mesh(X, Y, Z);
plot3(xmin2(1), xmin2(2), f(xmin2), 'r*');

xlabel('x');
ylabel('y');
zlabel('z');
title('f(x, y)=10*(x-3.5)^2+20*(y-4)^2 (meshgrid))');
view(160, 50);
legend('f(x, y)=10*(x-3.5)^2+20*(y-4)^2', 'minimum');

figure(4);
hold on;
grid on

contour(X, Y, Z);
plot3(xmin2(1), xmin2(2), f(xmin2), 'r*');

xlabel('x');
ylabel('y');
title('f(x, y)=10*(x-3.5)^2+20*(y-4)^2 (contour)');
legend('f(x, y)=10*(x-3.5)^2+20*(y-4)^2', 'minimum');
