function M = Masy()
Dane_PD2;

M = zeros(length(c.x));

for i = 1:length(c.x)
    M(3*i-2, 3*i-2) = c.m(i);
    M(3*i-1, 3*i-1) = c.m(i);
    M(3*i, 3*i) = c.I(i);
end
end