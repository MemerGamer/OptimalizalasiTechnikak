% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<CLALL>
close all
clc

f = @(x, y) 10 * x.^2 + 30 * y.^2 - 3 * x .* y + 2 * x - 8;

% Define the search space
x = linspace(-10, 10, 100);
y = linspace(-10, 10, 100);

[X, Y] = meshgrid(x, y);
Z = f(X, Y);

figure(1)
mesh(X, Y, Z)
xlabel('x')
ylabel('y')
zlabel('f(x,y)')
title('f(x,y) = 10x^2 + 30y^2 - 3xy + 2x - 8')

% Contour with ginput to get the starting point
figure(2)
f_contour = contour(X, Y, Z, 50);
xlabel('x')
ylabel('y')
title('f(x,y) = 10x^2 + 30y^2 - 3xy + 2x - 8')
hold on
[x0, y0] = ginput(1);
plot(x0, y0, 'r*')
fprintf("Starting point: (%f,%f)\n", x0, y0)
hold off

% Spiral search parameters
L = 5; % Initial step size
max_iter = 200; % Maximum iterations
number_of_retries = 15;

% Initialize minimum_iterations matrix
minimum_iterations = [x0; y0; f(x0, y0)];

% Initialize retry counter
retry_count = 0;

% Spiral search
for iter = 1:max_iter
    min_val = f(x0, y0);
    best_x = x0;
    best_y = y0;
    
    % Append the current minimum value to the list
    minimum_iterations = [minimum_iterations, [x0; y0; min_val]];
    
    % Initialize variables for plotting lines
    line_x = x0;
    line_y = y0;
    
    % Iterate between x and y axes
    for axis_iter = 1:2
        if axis_iter == 1
            directions = [1, 0; -1, 0];
        else
            directions = [0, 1; 0, -1];
        end
        
        for i = 1:size(directions, 1)
            dir_x = directions(i, 1);
            dir_y = directions(i, 2);
            
            Temp = [x0; y0] + L * [dir_x; dir_y];
            temp_val = f(Temp(1), Temp(2));
            
            % If the new point is better, update the best values
            if temp_val < min_val
                min_val = temp_val;
                best_x = Temp(1);
                best_y = Temp(2);
            else
                % Plot gray points for steps in the wrong direction
                figure(2)
                hold on
                plot(Temp(1), Temp(2), 'Color', [0.7, 0.7, 0.7], 'Marker', '*')
                hold off
            end
            
            % Update variables for plotting lines
            line_x = [line_x, best_x];
            line_y = [line_y, best_y];
            
            x0 = best_x;
            y0 = best_y;
        end
    end
    
    % Plot a line connecting the wrong steps
    figure(2)
    hold on
    plot(line_x, line_y, 'b-')
    hold off
    
    % Check for convergence (if the function value doesn't change significantly)
    if iter > 1 && abs(minimum_iterations(3, iter) - minimum_iterations(3, iter - 1)) < 1e-6
        if retry_count >= number_of_retries
            break;
        else
            retry_count = retry_count + 1;
            L = L / 2;
        end
    else
        % Reset the retry counter if there's improvement
        retry_count = 0;
    end
end

% Plot the red dots after the loop
for iter = 1:size(minimum_iterations, 2)
    best_x = minimum_iterations(1, iter);
    best_y = minimum_iterations(2, iter);
    figure(2)
    hold on
    plot(best_x, best_y, 'r*')
end

% Print the minimum iterations
fprintf("Minimum iterations:\n")
disp(minimum_iterations)

% Print the minimum point
fprintf("Minimum point: (%f,%f)\n", x0, y0)
