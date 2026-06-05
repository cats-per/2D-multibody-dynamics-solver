function dY = H(t,M, q, dq, Fq, S, Gamma)
%Funkcja podcałkowa
    alf = 5; bet = 5; % Współczyniki odpowiadające za stabilizację met. Baumgarte'a
    Y = [q; dq]; %dla wyjaśnienia - Y wejściowa kolumna z niewiadomymi q i dq - > dY - kolumnowe wyjście z dq i ddq gotowe do calkowania w ode45 (nasze RK)
%q=Y(1:6,:); % Czytelne nazwy położeń i prędkości
%dq=Y(7:12,:);
%[F,Fq,G,M,Q]=Macierze(q,dq); % Obliczenia dla aktualnych położeń i prędkości
    F = rWiez(q, t);
    A = [M, Fq'; Fq, zeros(length(Gamma))]; % Macierz układu równań
    b = [S; Gamma - 2 * alf * Fq * dq - bet ^ 2 * F]; % Prawa strona układu równań (z uwzględnieniem stabilizacji więzów)
    x = A \ b; % Obliczenie przyspieszeń i mnożników Lagrange'a
    dY(1:30,1) = dq; % Obliczenie wektora prawych stron równania różniczkowego
    dY(31:60,1) = x(1:30,1);
end