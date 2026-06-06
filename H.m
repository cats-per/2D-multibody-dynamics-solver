%% Funkcja podcałkowa
function dY = H(t, Y, d2q, dt)
    alf = 5; bet = 5;       % Współczyniki odpowiadające za stabilizację met. Baumgarte'a
    q=Y(1:30,1);
    dq=Y(31:60,1);

    % dla wyjaśnienia - Y wejściowa kolumna z niewiadomymi q i dq - > dY -
    % kolumnowe wyjście z dq i ddq gotowe do calkowania w ode45 (nasze RK)
    M = Masy();
    Q = Grawitacja();
    Fq = Jakobian(q);
    S = Sily(q, dq, d2q) + Q;
    Gamma = Przyspieszenie(q, dq, t);

    % Obliczenia dla aktualnych położeń i prędkości
    F = rWiez(q, t);
    A = [M, Fq'; Fq, zeros(length(Gamma))];             % Macierz układu równań
    b = [S; Gamma - 2 * alf * Fq * dq - bet ^ 2 * F];   % Prawa strona układu równań (z uwzględnieniem stabilizacji więzów)
    x = A \ b;                                          % Obliczenie przyspieszeń i mnożników Lagrange'a
    dY(1:30,1) = dq;                                    % Obliczenie wektora prawych stron równania różniczkowego
    dY(31:60,1) = x(1:30,1);
end