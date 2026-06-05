function G = Grawitacja()
Dane_PD2;

G = zeros(length(c.x), 1);

for i =1:length(c.x)
    G(3*i-2:3*i-1) = c.m(i) * g;
end
end