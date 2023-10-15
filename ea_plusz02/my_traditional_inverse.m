function A_inv = my_traditional_inverse(A)
[n, ~] = size(A);
A_inv = eye(n);

for k = 1:n
    % Megkeressük a pivot elemet
    pivot = A(k, k);
    if abs(pivot) < 1e-10
        error('Matrix is singular.');
    end
    
    % Skálázzuk a sorokat, hogy a pivot elem 1 legyen
    A(k, :) = A(k, :) / pivot;
    A_inv(k, :) = A_inv(k, :) / pivot;
    
    % Nullázzuk a többi elemet a k. oszlopban
    for i = 1:n
        if i ~= k
            factor = A(i, k);
            A(i, :) = A(i, :) - factor * A(k, :);
            A_inv(i, :) = A_inv(i, :) - factor * A_inv(k, :);
        end
    end
end
end
