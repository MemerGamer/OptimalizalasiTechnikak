function H = hess_f(f, h, x)
% x's size is the number of partial derivatives
n = length(x);
H = zeros(n, n);

v = zeros(n, 1);

for i = 1:n
    v(i) = 1;
    H(:,i) = (gr(f, h, x+h*v) - gr(f, h, x)) / h;
    v(i) = 0;
end
end