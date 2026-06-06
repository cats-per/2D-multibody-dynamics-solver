%% rzeczywista funkcja całkująca, nie tamten pozer Calkuj()
function [t,Y] = RK(H, t0, tK, Y0, h, d2q)
    N = floor((tK - t0) / h);       % liczba kroków czasowych
    t = zeros(N + 1, 1);            % czas - wektor chwil
    t(1) = t0;
    nY = length(Y0);
    Y = zeros(N+1, nY);             % kolumnowa macierz wyników całkowania Y(q(ti), dq(ti)) - wyjdzie 251x60 dla tego mechanizmu
    Y(1,:) = Y0';
    for i = 1:N                     % pętla z implementacją metody RK4
        ti = t(i);
        Yi = Y(i,:)';

        k1 = H(ti, Yi, d2q, h);
        k2 = H(ti + h/2, Yi + h/2*k1, d2q, h);
        k3 = H(ti + h/2, Yi + h/2*k2, d2q, h);
        k4 = H(ti + h,   Yi + h*k3, d2q, h);

        Y(i+1,:) = (Yi + h/6*(k1 + 2*k2 + 2*k3 + k4))';
        t(i+1) = ti + h;
    end
end