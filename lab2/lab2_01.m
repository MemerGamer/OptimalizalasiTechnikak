clear all %#ok<CLALL>
close all
clc

% for minimum search
o = optimset();
o = optimset(o, 'MaxIter', 1e3);
o = optimset(o, 'Tolx', 1e-5, 'TolFun', 1e-7);
o = optimset(o, 'Display', 'iter');

% function
x = -20:0.3:20;
fg = @(x) 3*x.^2 + 5*x - 7;
x0 = 9;

% plot
plot(x, fg(x));
hold on;
grid on;

% a.)
% minimum search
xmin = fminsearch(fg, x0, o);
display("Minimum point: (" + xmin + ", " + fg(xmin) + ")");
% plot
plot(xmin, fg(xmin), 'ro');

% b.)
% minimum search between -7 and -2
x01 = [-7, -2];
xmin = fminbnd(fg, x01(1), x01(2), o);
display("Minimum point: (" + xmin + ", " + fg(xmin) + ")");

% plot
plot(xmin, fg(xmin), 'g*');

% c.)
% maximum search between -7 and -2
x01 = [-7, -2];
fgMax = @(x) -fg(x);
xmin = fminbnd(fgMax, x01(1), x01(2), o);
display("Maximum point: (" + xmin + ", " + fg(xmin) + ")");

% plot
plot(xmin, fg(xmin), 'g*');