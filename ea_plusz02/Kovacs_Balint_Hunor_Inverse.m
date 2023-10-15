% Author: Kovács Bálint-Hunor (Informatika III.)
clear all; %#ok<*CLALL>
close all;
clc;
N = 1000;
A = rand(N, N);
disp('Matrix:');
disp(A);

% Hagyományos inverz kiszámítása
tic;
A_inv_traditional = my_traditional_inverse(A);
time_traditional = toc;

% LU felbontás Crout módszerrel
tic;
A_inv_crout = my_lu_inverse(A);
time_crout = toc;

% Ellenőrzés
tolerance = 1e-6;
if norm(A_inv_traditional - A_inv_crout) < tolerance
    disp('Results match within tolerance.');
    disp('Inverse (custom - traditional):');
    disp(A_inv_traditional);
else
    disp('Results do not match.');
    disp('Traditional inverse:');
    disp(A_inv_traditional);
    disp('Inverse with LU decomposition and Crout''s method (custom):');
    disp(A_inv_crout);
end

% Idők kiírása
fprintf('Time taken for custom traditional matrix inversion: %.6f seconds\n', time_traditional);
fprintf('Time taken for custom LU decomposition with Crout''s method: %.6f seconds\n', time_crout);
