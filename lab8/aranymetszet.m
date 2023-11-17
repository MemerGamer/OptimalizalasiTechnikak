function s_opt = aranymetszet(f, x, gr, S)
a = 0;
b = 0;

iterator = 1;

while true
    if f(x-(iterator-1)*S*gr) < f(x-iterator*S*gr)
        break;
    end
    iterator = iterator + 1;
end

if iterator > 3
    a = (iterator - 2 )*S;
end

if iterator < 3
    a = (iterator -1)*S;
end

b = iterator*S;

w = (3-sqrt(5))/2;
c = a + w*(b-a);
d = a + (1-w)*(b-a);
epsilon = 1e-4;

while true
    fc = f(x-c*gr);
    fd = f(x-d*gr);
    
    if fc >= fd
        z = a + (1-w)*(b-c);
        a = c;
        c = d;
        d = z;
    end
    
    if fc < fd
        z = a + w*(b-c);
        b = d;
        d = c;
        c = z;
    end
    
    if abs(b - a) <= epsilon
        break;
    end
end

s_opt = (a+b)/2;

end