clear all %#ok<CLALL>
close all
clc

f = @(x,y) 10*x.^2 + 30*y.^2 - 3*x.*y + 2*x -8;
% plot on
% mesh
x = linspace(-10,10,100);
y = linspace(-10,10,100);

[X,Y] = meshgrid(x,y);
Z = f(X,Y);

figure(1)
mesh(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('f(x,y)')
title('f(x,y) = 10x^2 + 30y^2 - 3xy + 2x - 8')

% contour with ginput to get starting point
figure(2)
f_countour = contour(X,Y,Z,50);
xlabel('x')
ylabel('y')
title('f(x,y) = 10x^2 + 30y^2 - 3xy + 2x - 8')
hold on
[x0,y0] = ginput(1);
plot(x0,y0,'r*')
fprintf("Starting point: (%f,%f)\n",x0,y0)
hold off


% minimum search around the point
max_iter = 100;
step_size = 0.3;


% 2x8 direction matrix
I = [
    0 1 1 1 0 -1 -1 -1;
    1 1 0 -1 -1 -1 0 1
    ];

% Minimum search
xmin = x0;
ymin = y0;

minimum_iterations = [];

for iter = 1:max_iter
    min_val = f(xmin, ymin);
    best_x = xmin;
    best_y = ymin;
    
    % Append the current minimum value to the list
    minimum_iterations = [minimum_iterations, [xmin; ymin; min_val]];
    
    % Variable to check if direction improvement was made
    direction_improvement = false;
    
    % Evaluate the function in 9 directions
    for i = 1:8
        Temp = [xmin; ymin] + step_size * I(:,i);
        temp_val = f(Temp(1), Temp(2));
        
        % If the new point is better, update the best values
        if temp_val < min_val
            min_val = temp_val;
            best_x = Temp(1);
            best_y = Temp(2);
            direction_improved = true;
        end
        
        
        % Plot current direction point with gray color
        figure(2)
        hold on
        plot(Temp(1), Temp(2), 'Color', [0.5, 0.5, 0.5], 'Marker', '*')
    end
    
    
    if ~direction_improved
        printf("No direction improvement\n")
        step_size = step_size / 10;
    end
    
    % Plot the line from the previous point to the current best point
    figure(2)
    hold on
    plot([xmin, best_x], [ymin, best_y], 'b-')
    hold off
    
    xmin = best_x;
    ymin = best_y;
    
    % Check for convergence (if the function value doesn't change significantly)
    if iter > 1 && abs(minimum_iterations(3,iter) - minimum_iterations(3,iter-1)) < 1e-6
        break
    end
end

% Plot the red dots after the loop
for iter = 1:size(minimum_iterations, 2)
    best_x = minimum_iterations(1, iter);
    best_y = minimum_iterations(2, iter);
    figure(2)
    hold on
    plot(best_x, best_y, 'r*')
    hold off
end

% Print the minimum iterations
fprintf("Minimum iterations:\n")
disp(minimum_iterations)

% Plot the minimum iterations on the mesh
figure(1)
hold on
plot3(minimum_iterations(1,:), minimum_iterations(2,:), minimum_iterations(3,:), 'r*-')
hold off

