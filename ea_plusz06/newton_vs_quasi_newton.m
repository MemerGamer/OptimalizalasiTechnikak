% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<CLALL>
close all
clc


% The given function
J = @(x) x(1)^2 + 2*x(2)^2 + 3*x(3)^3 + 4*x(4)^4 + 5*x(5)^5 + 6*x(6)^6 + 7*x(7)^7 + 8*x(8)^8 + 9*x(9)^9 + 10*x(10)^10;

% Starting points
x0 = zeros(10, 1);

% Number of iterations
N = 100;

% Tolerance
tolerance = 1e-7;

% Hessian matrix
H = eye(10);

% Time
timeNewton = 0;
timeQuasiNewton = 0;

for iteration = 1:N
    % Newton's method
    tic;
    x0_newton = x0;
    gradient = zeros(10, 1);
    hessian = zeros(10, 10);
    for i = 1:10
        gradient(i) = 2* i * x0_newton(i);
        Hessian(i, i) = 2*i;
    end
    delta_x = -Hessian \ gradient;
    x1_newton = x0_newton + delta_x;
    timeNewton = timeNewton + toc;
    
    % Quasi-Newton's method
    tic;
    x0_quasiNewton = x0;
    gradient = zeros(10, 1);
    for i = 1:10
        gradient(i) = 2* i * x0_quasiNewton(i);
    end
    delta_x = -H * gradient;
    x1_quasiNewton = x0_quasiNewton + delta_x;
    delta_gradient = gradient - (2 * (1:10))';
    H = H + (delta_x * delta_x') / (delta_x' * delta_gradient) - (H * delta_gradient * delta_gradient' * H) / (delta_gradient' * H * delta_gradient);
    timeQuasiNewton = timeQuasiNewton + toc;
    x0 = x1_quasiNewton;
end

% Displaying the results
fprintf('Newton''s method: %f seconds\n', timeNewton);
fprintf('Quasi-Newton''s method: %f seconds\n', timeQuasiNewton);
fprintf('The difference is %f seconds\n', timeNewton - timeQuasiNewton);
