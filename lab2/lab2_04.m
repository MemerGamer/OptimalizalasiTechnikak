clear all %#ok<CLALL>
close all
clc

% options
o = optimset();
o = optimset(o, 'MaxIter', 1e3);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

f = @(x) x(1)^2 + x(2)^3 + x(1)*x(3) + x(2)*x(1) - 3*x(3)^2 + 5*x(2)*x(3) - 7*x(1) + 8;

% minimum search
x0 = [1, 2, 3];

xmin = fminsearch(f, x0, o);

disp('Minimum point: (' + string(xmin(1)) + ', ' + string(xmin(2)) + ', ' + string(xmin(3)) + ', ' + string(f(xmin)) + ')');

% maximum search
fMax = @(x) -f(x);

xmax = fminsearch(fMax, x0, o);

disp('Maximum point: (' + string(xmax(1)) + ', ' + string(xmax(2)) + ', ' + string(xmax(3)) + ', ' + string(f(xmax)) + ')');