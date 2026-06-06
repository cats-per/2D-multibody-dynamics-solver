%% Program rozwiązujący zadanie dynamiki mechanizmu płaskiego zdefiniowanego w pliku Dane_PD2.m

% wczytanie danych
clear all;
Dane_PD2;

n_u = length(c.x);
t = 0;

% macierz mas i składowa grawitacji wektora sił
M = Masy();
Q = Grawitacja();

q = zeros(n_u * 3, 1); dq = zeros(n_u * 3, 1); d2q = zeros(n_u * 3, 1);

% przypisanie wartości dla chwili t0
for i = 1:n_u
    q(3*i-2:3*i-1) = [c.x(i) c.y(i)]';
    q(3*i) = 0;
end

% przygotowanie do całkowania
Fq = Jakobian(q);
S = Sily(q, dq, d2q) + Q;
Gamma = Przyspieszenie(q, dq, t);
Yp=[q; dq];

% całkowanie
[tc,Y]=Calkuj(t_k, Yp, dt, d2q);

% przygotowanie wyników do zapisu
D2Y = zeros(size(Y,1),30);

for i = 1:size(Y,1)
    dYi = H(tc(i), Y(i,:)', d2q, dt);
    D2Y(i,:) = dYi(31:60)';
end
figure(1)

T = tc'; Q = Y(:, 1:n_u*3)'; DQ = Y(:, 3*n_u+1:end)'; D2Q = D2Y';
save("wynik_PD2", "T", "Q", "DQ", "D2Q");

% postprocessing
postproc()