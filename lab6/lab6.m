% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<CLALL>
close all
clc

% Boltzmann algortimus

f = @(x, y) 15*x.^2 + 20*y.^2 - 2*x.*y - 6*x + 8;

% plot mesh es contour
[X, Y] = meshgrid(linspace(-10, 10, 100), linspace(-10, 10, 100));
Z = f(X, Y);

figure(1)
mesh(X, Y, Z)
xlabel('x')
ylabel('y')
zlabel('f(x, y)')
title('f(x, y) függvény')

figure(2)
contour(X, Y, Z, 50)
xlabel('x')
ylabel('y')
title('f(x, y) függvény')

max_iteration = 100000;
maximum_unsuccesful_attempts = 100;

% kezdeti pont ginputtal contourről
figure(2)
[xmin, ymin] = ginput(1);
hold on
plot(xmin, ymin, 'r*');
k = 0.2;
R = rand(1)*3;

minimum_iterations = [xmin, ymin, f(xmin, ymin)];
unsuccessful_attempts = 0;
iteration = 0;
i = 1;
T0 = 1000;
T = T0 / i;

% minimum keresés
while true
    alpha = 2*pi*rand(1);
    R = rand(1)*3;
    xt = xmin + R*cos(alpha);
    yt = ymin + R*sin(alpha);
    deltaF = f(xt, yt) - f(xmin, ymin);
    if deltaF < 0
        xmin = xt;
        ymin = yt;
        unsuccessful_attempts = 0;
        minimum_iterations = [minimum_iterations; xmin, ymin, f(xmin, ymin)];
        i = i + 1;
        T = T0 / i;
    else
        p = exp((-deltaF) / (k*T));
        
        if p > rand(1)
            xmin = xt;
            ymin = yt;
            unsuccessful_attempts = 0;
            minimum_iterations = [minimum_iterations; xmin, ymin, f(xmin, ymin)];
            i = i + 1;
            T = T0 / i;
        else
            unsuccessful_attempts = unsuccessful_attempts + 1;
        end
        % sikertelen probálkozások kirajzolása
        % figure(2)
        % hold on
        % plot(xt, yt, 'o', 'MarkerSize', 2, 'MarkerFaceColor', [0.5, 0.5, 0.5], 'MarkerEdgeColor', [0.5, 0.5, 0.5])
        % hold off
    end
    
    if unsuccessful_attempts >= maximum_unsuccesful_attempts
        unsuccessful_attempts = 0;
    end
    
    iteration = iteration + 1;
    
    if iteration >= max_iteration
        break
    end
    
end

% utolsó minimum kiírása
display(minimum_iterations(end, :));


% minimum keresésének eredményének kirajzolása pontokkal
figure(2)
hold on
plot(minimum_iterations(:, 1), minimum_iterations(:, 2), 'r*', 'MarkerSize', 2, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r')
hold off

% minimum keresésének eredményének kirajzolása vonalal összekötve
figure(2)
hold on
plot(minimum_iterations(:, 1), minimum_iterations(:, 2), 'r-')
hold off

% kirajzoljuk a minimum pontokat és az összekötő vonalat is a meshre
figure(1)
hold on
plot3(minimum_iterations(:, 1), minimum_iterations(:, 2), minimum_iterations(:, 3), 'r*', 'MarkerSize', 2, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r')
plot3(minimum_iterations(:, 1), minimum_iterations(:, 2), minimum_iterations(:, 3), 'r-')
hold off


% kirajzoljuk a minimum pontokat egy külön grafikonra is függvényérték szerint rendezve
figure(3)
plot(minimum_iterations(:, 3), 'r*')
xlabel('iteráció')
ylabel('f(x, y)')
title('f(x, y) függvény minimumának keresése')
grid on



