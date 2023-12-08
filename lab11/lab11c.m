% Author: Kovács Bálint-Hunor (Informatika III.) 2023
clear all %#ok<CLALL>
close all
clc

% Lagrange relaxation method
f = @(x) x(1).^2 + x(2).^2 - 50*x(1) - 64*x(2);
F = @(x1, x2) x1.^2 + x2.^2 - 50*x1 - 64*x2;

% constraints
g1 = @(x) x(1) + (3/2)*x(2).^2 - 60;
G1 = @(x1, x2) x1 + (3/2)*x2.^2 - 60;


L = @(z) f(z) + z(3)*g1(z);

% plot mesh and contour
x1 = -200:1:200;
x2 = -200:1:200;
[X1,X2] = meshgrid(x1,x2);
Z = F(X1,X2);

figure(1)
mesh(X1,X2,Z)
xlabel('x1')
ylabel('x2')
zlabel('f(x1,x2)')
title('f(x1,x2) = x1^2 + x2^2 - 50*x1 - 64*x2')

figure(2)
contour(X1,X2,Z,100)
xlabel('x1')
ylabel('x2')
title('f(x1,x2) = x1^2 + x2^2 - 50*x1 - 64*x2')

% plot constraints
figure(2)
hold on
x1 = -100:1:100;
x2 = -100:1:100;
[X1,X2] = meshgrid(x1,x2);
Z = G1(X1,X2);
contour(X1,X2,Z,[0 0],'r')
hold off

figure(2)
x = ginput(1);
x = x';
hold on
plot(x(1), x(2), 'r*')
disp('Start point: ')
disp(x)

% variables and parameters
max_iteration = 1000;
Sx = 0.001;
Sp = 0.01;
P = 35;

h = 1e-3;
e1 = 1e-4;


iteration_counter = 0;
minimum_iterations = [x];
varriance_of_p = [P];

% Lagrange relaxation method
% One larger cycle where we have 2 inner cycles
% The first inner cycle calculates the minimum of the f function
% The second inner cycle calculates the maximum of the g function


while iteration_counter < max_iteration
    iteration_counter = iteration_counter + 1;
    for i = 1:10
        Z = [x ; P];
        G = gr(L,h,Z);
        
        uj_x = x - Sx*G(1:2);
        x = uj_x;
        minimum_iterations = [minimum_iterations x];
        
        % plot the minimum iterations
        figure(2)
        hold on
        plot(x(1), x(2), 'r.')
        hold off
        
        if norm(G(1:2)) < e1
            break
        end
        
    end
    for i = 1:10
        Z = [x; P];
        G = gr(L, h, Z);
        
        uj_p = P + Sp * G(3);
        P = uj_p;
        varriance_of_p = [varriance_of_p P];
        
        if norm(G(3)) < e1
            break
        end
    end
    
    % if the difference between the last two P values is less than e1 or the difference between the last two x values is less than e1 then we stop
    if abs(minimum_iterations(:,end) - minimum_iterations(:,end-1)) < e1
        break
    end
    if abs(varriance_of_p(:,end) - varriance_of_p(:,end-1)) < e1
        break
    end
end

disp('Minimum point: ')
disp(x)
disp('P: ')
disp(P)

% plot the minimum iterations on the mesh and contour
figure(1)
hold on
plot3(minimum_iterations(1,:), minimum_iterations(2,:), F(minimum_iterations(1,:), minimum_iterations(2,:)), 'r')
hold off

figure(2)
hold on
plot(minimum_iterations(1,:), minimum_iterations(2,:), 'r')
hold off

% plot the variance of P on a graph
figure(3)
plot(varriance_of_p, 'r')
xlabel('Iteration')
ylabel('P')
title('Variance of P')

% plot the values of x1 and x2 on a graph as the iterations go on
figure(4)
plot(minimum_iterations(1,:), 'r')
hold on
plot(minimum_iterations(2,:), 'b')
hold off
xlabel('Iteration')
ylabel('x1, x2')
title('Values of x1 and x2 as the iterations go on')
legend('x1', 'x2')
