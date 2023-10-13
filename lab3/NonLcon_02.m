function [ce, ceq] = NonLcon_02(x)
ce = [];
ceq = x(2) + x(1)*exp(x(1));
end
