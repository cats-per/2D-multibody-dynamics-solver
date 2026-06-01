Dane_PD2;

n_u = length(c.x);

M = Masy();
Q = Grawitacja();

q = zeros(n_u, 1); dq = zeros(n_u, 1); d2q = zeros(n_u, 1);
for i = 1:n_u
    q(3*i-2) = c.x(i);
    q(3*i-1) = c.y(i);
end

while t < t_k
    t = t + dt;
end