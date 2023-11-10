% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<CLALL>
close all
clc

f = @(x) 10*x(1).^2 + 20*x(2).^2 - 2*x(1).*x(2) - 3*x(1) + 5;

% plot mesh es contour
F = @(x1, x2) 10*x1.^2 + 20*x2.^2 - 2*x1.*x2 - 3*x1 + 5;
x1 = linspace(-10, 10, 100);
x2 = linspace(-10, 10, 100);

[X, Y] = meshgrid(x1, x2);
Z = F(X, Y);

figure(1);
mesh(X, Y, Z);
xlabel('x_1');
ylabel('x_2');
zlabel('f(x_1, x_2)');
title('f(x_1, x_2) = 10*x_1^2 + 20*x_2 - 2*x_1*x_2 - 3*x_1 + 5');

figure(2);
contour(X, Y, Z, 100);
xlabel('x_1');
ylabel('x_2');


max_iteration = 1000;
figure(2);
x = ginput(1)';
hold on;
plot(x(1), x(2), 'r*');

% step size
S = 0.01;
h = 1e-3;

e1 = 1e-6;
e2 = 1e-6; % tolX
e3 = 1e-6; % tolFun

iteration_counter = 0;
minimum_iterations = [x];

while true
    current_gradient = gr(f, h, x(:,1));
    M = -current_gradient;
    x = x + S*M;
    
    % append the new point to minimum_iterations
    minimum_iterations = [minimum_iterations x];
    
    % plot the new point on the contour and on the mesh
    figure(1)
    hold on;
    plot3(x(1), x(2), f(x), 'r*');
    
    figure(2)
    hold on;
    plot(x(1), x(2), 'r*');
    
    if norm(current_gradient) < e1
        break;
    end
    if (norm(x(end, :) - x(end-1, :)) < e2 ) && abs(f(x(end, :)) - f(x(end-1, :))) < e3
        break;
    end
    
    if iteration_counter > max_iteration
        break;
    end
    
    iteration_counter = iteration_counter + 1;
end

% plot the minimum point
figure(1)
hold on;
plot3(x(1), x(2), f(x), 'g*');

figure(2)
hold on;
plot(x(1), x(2), 'g*');


% Plot the minimum iterations as a line
figure(2)
hold on;
plot(minimum_iterations(1, :), minimum_iterations(2, :), 'b-');

figure(1)
hold on;
% Evaluate the function for each point separately
f_values = arrayfun(@(i) f(minimum_iterations(:, i)), 1:size(minimum_iterations, 2));
plot3(minimum_iterations(1, :), minimum_iterations(2, :), f_values, 'b-');

% Print the minimum point
fprintf('Minimum point: x1 = %.4f, x2 = %.4f, f(x1, x2) = %.4f\n', x(1), x(2), f(x));


