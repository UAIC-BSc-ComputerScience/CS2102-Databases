-- 1: Afișați numărul de studenți din fiecare an.
SELECT an, COUNT(*) "NR STUDENTI" FROM studenti GROUP BY an;

-- 2: Afișați numărul de studenți din fiecare grupă a fiecărui an de studiu. Ordonați crescător după anul de studiu și după grupă.
SELECT an, grupa, COUNT(grupa) FROM studenti GROUP BY an, grupa ORDER BY an, grupa;

-- 3: Afișați numărul de studenți din fiecare grupă a fiecărui an de studiu și specificați câți dintre aceștia sunt bursieri.
SELECT an, grupa, COUNT(grupa) FROM studenti WHERE bursa IS NOT NULL GROUP BY an, grupa;

-- 4: Afișați suma totală cheltuită de facultate pentru acordarea burselor.
SELECT SUM(NVL(bursa, 0)) SUMA FROM studenti;

-- 5: Afișați valoarea bursei/cap de student (se consideră că studentii care nu sunt bursieri primesc 0 RON); altfel spus: cât se cheltuiește în medie pentru un student?
SELECT AVG(NVL(bursa, 0)) SUMA FROM studenti;

-- 6: Afișați numărul de note de fiecare fel (câte note de 10, câte de 9,etc.). Ordonați descrescător după valoarea notei.
SELECT valoare, COUNT(valoare) NR_NOTE FROM note GROUP BY valoare ORDER BY valoare desc;

-- 7: Afișați numărul de note pus în fiecare zi a săptămânii. Ordonați descrescător după numărul de note.
SELECT TO_CHAR(data_notare, 'day'), COUNT(valoare) FROM note GROUP BY TO_CHAR(data_notare, 'day') ORDER BY COUNT(valoare) DESC

-- 8: Afișați numărul de note pus în fiecare zi a săptămânii. Ordonați crescător după ziua saptamanii: Sunday, Monday, etc.
SELECT TO_CHAR(data_notare, 'day'), COUNT(valoare) FROM note GROUP BY TO_CHAR(data_notare, 'd'), TO_CHAR(data_notare, 'day') ORDER BY TO_CHAR(data_notare, 'D')


-- 9: Afișați pentru fiecare elev care are măcar o notă, numele și media notelor sale. Ordonați descrescător după valoarea mediei.
select s.nume, s.prenume, avg(n.valoare) from note n join studenti s on n.nr_matricol = s.nr_matricol group by s.nume, s.prenume;

-- 10: Modificați interogarea anterioară pentru a afișa și elevii fără nici o notă. Media acestora va fi null.
select s.nume, s.prenume, avg(n.valoare) from note n right outer join studenti s on n.nr_matricol = s.nr_matricol group by n.nr_matricol, s.nume, s.prenume;

-- 11: Modificați interogarea anterioară pentru a afișa pentru elevii fără nici o notă media 0.
select s.nume, s.prenume, avg(nvl(n.valoare, 0)) from note n right outer join studenti s on n.nr_matricol = s.nr_matricol group by n.nr_matricol, s.nume, s.prenume;

-- 12: Modificati interogarea de mai sus pentru a afisa doar studentii cu media mai mare ca 8.
select s.nume, s.prenume, avg(nvl(n.valoare, 0)) from note n right outer join studenti s on n.nr_matricol = s.nr_matricol group by n.nr_matricol, s.nume, s.prenume having avg(nvl(n.valoare, 0)) > 8;

-- 13: Afișați numele, cea mai mare notă, cea mai mică notă și media doar pentru acei studenti care au primit doar note mai mari sau egale cu 7 (au cea mai mică notă mai mare sau egală cu 7).
select s.nume, s.prenume, min(n.valoare), max(n.valoare), avg(n.valoare) from studenti s join note n on s.nr_matricol = n.nr_matricol group by s.nume, s.prenume having min(n.valoare) >= 7;

-- 14: Afișați numele și mediile studenților care au cel puțin un număr de 4 note puse în catalog.
select s.nume, s.prenume, avg(n.valoare) from studenti s join note n on s.nr_matricol = n.nr_matricol group by s.nr_matricol, s.nume, s.prenume having count(*) >= 4;

-- 15: Afișați numele și mediile studenților din grupa A2 anul 3.
select s.nume, s.prenume, avg(n.valoare) from studenti s join note n on s.nr_matricol = n.nr_matricol where s.an = 3 and lower(trim(s.grupa)) = 'a2' group by s.nume, s.prenume;

-- 16: Afișați cea mai mare medie obținută de vreun student. Puteți să afișați și numărul matricol al studentului care are acea medie maximală ? Argumentați.
select max(avg(n.valoare)) from studenti s join note n on s.nr_matricol = n.nr_matricol group by s.nr_matricol, s.nume, s.prenume;
-- ??

-- 17: Pentru fiecare disciplină de studiu afișati titlul acesteia, cea mai mică și cea mai mare notă pusă.
select c.titlu_curs, max(n.valoare), min(n.valoare) from cursuri c join note n on c.id_curs = n.id_curs group by c.titlu_curs;