%% Program rozwiązujący zadanie dynamiki mechanizmu płaskiego

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

%% pętla całkująca do zadanego czasu końcowego
while t < t_k
    Fq = Jakobian(q);
    S = Sily(q, dq, d2q) + Q;
    Gamma = Przyspieszenie(q, dq, t);
    Lewa = [M Fq';
            Fq zeros(length(Gamma))];
    Prawa = [S; 
             Gamma];
    dY=H(t,M, q, dq, Fq, S, Gamma);
    [tc,Y]=Calkuj(t_k, q);
    q=q+dq*dt+0.5*d2q*dt^2;
    dq=dq+d2q*dt;
    t=t+dt;
end

% postprocessing
%postproc()