function s_opt = interpolacio(f, x, gr , S, h)

sL = 0;
sH = 0;

iterator = 1;

while true
    if f(x-(iterator-1)*S*gr) < f(x-iterator*S*gr)
        break;
    end
    iterator = iterator + 1;
end

if iterator > 3
    sL = (iterator - 2 )*S;
end

if iterator < 3
    sL = (iterator -1)*S;
end

sH = iterator*S;

e1 = f(x - sL * gr);
e2 = f(x - sH * gr);
e3 = (f(x - (sL + h) * gr) - f(x - sL * gr)) / h;
e4 = (f(x - (sH + h) * gr) - f(x - sH * gr)) / h;

E = [e1; e2; e3; e4];
M = [sL^3 sL^2 sL 1;
    sH^3 sH^2 sH 1;
    3*sL^2 2*sL 1 0;
    3*sH^2 2*sH 1 0];

M_inverse = inv(M);
A = M_inverse*E;


s = real(roots([3*A(1) 2*A(2) A(3)]));

if f(x - s(1) * gr) < f(x - s(2) * gr)
    s_opt = s(1);
else
    s_opt = s(2);
end


end