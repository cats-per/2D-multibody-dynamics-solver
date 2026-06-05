%% Funkcja wyznaczająca siły uogólnione dla każdego z członów
function F = Sily(q, dq, d2q)
Dane_PD2;

Om = [0 -1;
      1  0];

F = zeros(length(q), 1);
% siły przyłożone w punkcie
if sily
    for i = numel(sila)
        id = sila(i).cialo;
        F(3*id-2:3*id-1) = [eye(2); Om * Rot(q(3*id)) * sila(i).s] * sila(i).wekt;
    end
end

% siły wyierane przez tłumiki
if tlumiki
    for i = 1:numel(tlumik)
        idi = postep(tlumik(i).para).ciala(1);
        idj = postep(tlumik(i).para).ciala(2);
        ri = dq(3*idi-2:3*idi-2);
        rj = dq(3*idj-2:3*idj-2);
        fii = q(3*idi);
        fij = q(3*idj);
        dfii = dq(3*idi);
        dfij = dq(3*idj);

        sa = postep(tlumik(i).para).sa;
        sb = postep(tlumik(i).para).sb;

        va = ri + Om * Rot(fii) * sa * dfii;
        vb = rj + Om * Rot(fij) * sb * dfij;

        dd = (Rot(fi) * postep(tlumik(i).para).u)' * (vb - va);

        F(3*idi-2:3*idi-1) = F(3*idi-2:3*idi-1) + dd * tlumik(i).b * Rot(fii) * postep(tlumik(i).para).u;
        F(3*idj-2:3*idj-1) = F(3*idj-2:3*idj-1) - dd * tlumik(i).b * Rot(fij) * postep(tlumik(i).para).u;
    end
end

% siły wywierane przez sprężyny
if sprezyny
    for i = 1:numel(sprezyna)
        idi = postep(sprezyna(i).para).ciala(1);
        idj = postep(sprezyna(i).para).ciala(2);
        ri = q(3*idi-2:3*idi-2);
        rj = q(3*idj-2:3*idj-2);
        fii = q(3*idi);
        fij = q(3*idj);

        sa = postep(sprezyna(i).para).sa;
        sb = postep(sprezyna(i).para).sb;

        sab = (ri + Rot(fii) * sa) - (rj + Rot(fij) * sb);

        d = norm(sab);
        F(3*idi-2:3*idi-1) = F(3*idi-2:3*idi-1) + Rot(idi) * postep(sprezyna(i).para).u * (d - d0) * sprezyna(i).k;
        F(3*idj-2:3*idj-1) = F(3*idj-2:3*idj-1) - Rot(idi) * postep(sprezyna(i).para).u * (d - d0) * sprezyna(i).k;
    end
end

% moment i siła wywołane ruchem i obrotem członu
for i = 1:numel(c.x)
    F(3*i-2:3*i-1) = F(3*i-2:3*i-1) + c.m(i) * d2q(3*i-2:3*i-1);
    F(3*i) = F(3*i) + d2q(3*i) * c.I(i);
end
end