function [t,Y] = Calkuj(tK, q)
    t0 = 0;
    q0 = q;
    dq0 = zeros(30,1);
    Y0 = [q0;dq0];
    [t,Y] = RK(@H, [t0, tK], Y0);
end