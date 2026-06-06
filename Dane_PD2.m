% plik z danymi 

% parametry symulacji
eps = 1e-10;    % wymagana dokładność
t_k = 5;      % czas zakończenia symulacji [s]
dt = 0.0125;      % długość kroku czasowego [s]

g = [0 -9.81]';

% środki mas członów (posłużą za lokalne układy współrzędnych)
c.x = [-0.95 0.4 0.6 -0.15 -0.35 -0.05 0.25 0.35 0.4 0.6];
c.y = [0.55 0.75 0.5 0.35 0.85 0.65 0.4 0 0.35 -0.15];
c.m = [120 120 120 220 9 5 5 5 7 7];
c.I = [4 6 4 40 0.5 0.5 0.5 0.5 0.5 0.5];

% pary przegubowe
przeguby = true;

% A
przegub(1).ciala = [1 4];
przegub(1).r0 = [-1 0.2]';

% B
przegub(2).ciala = [1 5];
przegub(2).r0 = [-0.7 0.8]';

% D
przegub(3).ciala = [4 6];
przegub(3).r0 = [-0.2 0.5]';

% E
przegub(4).ciala = [2 6];
przegub(4).r0 = [0.1 0.8]';

% F
przegub(5).ciala = [2 3];
przegub(5).r0 = [0.9 0.7]';

% G
przegub(6).ciala = [3 9];
przegub(6).r0 = [0.3 0.6]';

% H
przegub(7).ciala = [0 10];
przegub(7).r0 = [0.7 -0.4]';

% I
przegub(8).ciala = [3 4];
przegub(8).r0 = [0.7 0.3]';

% J
przegub(9).ciala = [2 5];
przegub(9).r0 = [0.0 0.9]';

% L
przegub(10).ciala = [0 3];
przegub(10).r0 = [0.6 0.3]';

% M
przegub(11).ciala = [2 7];
przegub(11).r0 = [0.2 0.6]';

% N
przegub(12).ciala = [0 8];
przegub(12).r0 = [0.4 -0.2]';

przegub = wsp_lokalne(przegub, c);

% pary przegubowe kierujące
przeguby_kierujace = false;

% pary postępowe
postepowe = true;

postep(1).ciala = [7 8];
postep(1).pkt_pocz = [0.2 0.6]';
postep(1).pkt_kon = [0.4 -0.2]';

postep(2).ciala = [9 10];
postep(2).pkt_pocz = [0.3 0.6]';
postep(2).pkt_kon = [0.7 -0.4]';

postep = policzoffset(postep, c);

% pary postępowe kierujące
postepowe_kierujace = false;

% siły
sily = true;

sila(1).cialo = 1;
sila(1).punkt = [-1.2 0.6]';
sila(1).wartosc = 1000;
sila(1).kat = 225;
sila(1).wekt = 1000 * Rot(deg2rad(225)) * [1 0]';

sila(1).s = [-0.25 0.05]';

% tłumiki
tlumiki = true;

tlumik(1).para = 1;
tlumik(1).b = 5e3;

tlumik(2).para = 2;
tlumik(2).b = 3e3;

% sprężyny
sprezyny = true;

sprezyna(1).para = 1;
sprezyna(1).k = 2e5;
sprezyna(1).d0 = sqrt(0.68);

sprezyna(2).para = 2;
sprezyna(2).k = 2e5;
sprezyna(2).d0 = sqrt(1.16);

% czujniki
czujniki = true;

czujnik(1).czlon = 1;
czujnik(1).r0 = [-1.2 0.6]';
