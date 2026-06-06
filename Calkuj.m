%% funkcja cąłkująca układ równań różniczkowo-algebraicznych
function [t,Y] = Calkuj(tK, Yc, dt, d2q)
    t0 = 0;
    q0 = Yc(1:30, 1);
    dq0 = Yc(31:60, 1);
    Y0 = [q0; dq0];
    [t,Y] = RK(@H, t0, tK, Y0, dt, d2q);
    n = size(Y, 1);
    qK = Y(n, 1:30)'; dqK=Y(n,31:60)';      % Położenie i prędkość w chwili tK
    F = rWiez(qK, tK);                      % Obliczenie lewej strony równań więzów
    norm_F=norm(F)                          %sprawdzenie pod kątem osobliwości macierzy F dla ostatniej chwili
end