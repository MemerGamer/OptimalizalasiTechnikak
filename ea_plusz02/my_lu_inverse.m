function A_inv = my_lu_inverse(A)
[n, ~] = size(A);
L = eye(n);
U = zeros(n);

for k = 1:n
    U(k, k:n) = A(k, k:n) - L(k, 1:k-1) * U(1:k-1, k:n);
    L(k+1:n, k) = (A(k+1:n, k) - L(k+1:n, 1:k-1) * U(1:k-1, k)) / U(k, k);
end

I = eye(n);
Y = L \ I;
A_inv = U \ Y;
end
