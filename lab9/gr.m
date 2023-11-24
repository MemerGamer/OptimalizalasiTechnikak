function g = gr(f, h, x)
% x's size is the number of partial derivatives
n = length(x);
g = zeros(n, 1);

v = zeros(n, 1);

for i = 1:n
    v(i) = 1;
    g(i) = (f(x + h * v) - f(x)) / h;
    v(i) = 0;
end
end