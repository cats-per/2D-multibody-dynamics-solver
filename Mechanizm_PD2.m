%% Program rozwiązujący zadanie dynamiki mechanizmu płaskiego

% wczytanie danych
clear all;
Dane_PD2;

n_u = length(c.x);

% macierz mas i składowa grawitacji wektora sił
M = Masy();
Q = Grawitacja();

q = zeros(n_u, 1); dq = zeros(n_u, 1); d2q = zeros(n_u, 1);

% przypisanie wartości dla chwili t0
for i = 1:n_u
    q(3*i-2:3*i-1) = [c.x(i) c.y(i)]';
    q(3*i) = 0;
end

%% pętla całkująca do zadanego czasu końcowego
while t < t_k
    Fq = Jakobian(q);
    S = Sily(q, dq, d2q) + Q;
    Gamma = Przyspieszenie(q, dq, t);
    Lewa = [M Fq';
            Fq zeros(length(Gamma))];
    Prawa = [S; 
             Gamma];
    t = t + dt;
end