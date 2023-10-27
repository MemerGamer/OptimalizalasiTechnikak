% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<CLALL>
close all
clc

% 1. feladat egyszerű Monte Carlo módszerrel

f = @(x, y) 15*x.^2 + 20*y.^2 - 2*x.*y - 6*x + 8;

x_bound = [-6, 8];
y_bound = [-3, 7];

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

max_iteration = 1000000;
maximum_unsuccesful_attempts = 100;

% minimum keresése

% kezdeti pont megadása
min_x = rand(1)*(x_bound(2) - x_bound(1)) + x_bound(1);
min_y = rand(1)*(y_bound(2) - y_bound(1)) + y_bound(1);

minimum_iterations = [min_x, min_y, f(min_x, min_y)];

unsuccesful_attempts = 0;

iteration = 0;
while true
    % új pont generálása
    new_x = rand(1)*(x_bound(2) - x_bound(1)) + x_bound(1);
    new_y = rand(1)*(y_bound(2) - y_bound(1)) + y_bound(1);
    
    % ha a függvény értéke kisebb, mint a jelenlegi minimum, akkor az új
    % pontot vesszük fel minimumként
    if f(new_x, new_y) < f(min_x, min_y)
        min_x = new_x;
        min_y = new_y;
        minimum_iterations = [minimum_iterations; min_x, min_y, f(min_x, min_y)];
        unsuccesful_attempts = 0;
    else
        unsuccesful_attempts = unsuccesful_attempts + 1;
        
        % sikertelen probálkozások kirajzolása
        figure(2)
        hold on
        plot(new_x, new_y, 'o', 'MarkerSize', 2, 'MarkerFaceColor', [0.5, 0.5, 0.5], 'MarkerEdgeColor', [0.5, 0.5, 0.5])
        hold off
        
    end
    
    % ha 1000 sikertelen próbálkozás volt, akkor kilépünk
    if unsuccesful_attempts == maximum_unsuccesful_attempts
        break
    end
    
    iteration = iteration + 1;
    
    % ha elérjük a maximum iterációt, akkor kilépünk
    if iteration == max_iteration
        break
    end
end

% minimum keresésének eredménye
display(minimum_iterations(end, :))

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


