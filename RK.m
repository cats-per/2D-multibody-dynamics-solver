function [t,Y] = RK(H, t0, tK, Y0, h)

    % Liczba kroków
    N = floor((tK - t0)/h);

    % Wektor czasu
    t = zeros(N+1,1);
    t(1) = t0;

    % Macierz wyników
    nY = length(Y0);
    Y = zeros(N+1,nY);
    Y(1,:) = Y0';

    % Całkowanie RK4
    for i = 1:N

        ti = t(i);
        Yi = Y(i,:)';

        k1 = H(ti, Yi);
        k2 = H(ti + h/2, Yi + h/2*k1);
        k3 = H(ti + h/2, Yi + h/2*k2);
        k4 = H(ti + h,   Yi + h*k3);

        Y(i+1,:) = (Yi + h/6*(k1 + 2*k2 + 2*k3 + k4))';

        t(i+1) = ti + h;
    end

end