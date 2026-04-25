-- 1
SELECT nume, prenume, data_nast FROM studenti;

-- 2
SELECT DISTINCT bursa FROM studenti WHERE bursa IS NOT NULL;

-- 3
;

-- 4
SELECT nume||''||prenume AS concat, an FROM studenti;

-- 5
SELECT nume, prenume, data_nast FROM studenti WHERE data_nast BETWEEN TO_DATE('01/01/1995', 'dd/mm/yyyy') AND TO_DATE('10/06/1997' ,'dd/mm/yyyy') ORDER BY an DESC;

-- 6
SELECT nume, prenume, an FROM studenti WHERE to_date(data_nastere, 'yyyy') = '1995';

-- 7
SELECT * FROM studenti WHERE bursa IS NULL;

-- 8
SELECT nume, prenume FROM studenti WHERE bursa IS NOT NULL AND (an='2' OR an='3') ORDER BY nume, prenume DESC;

-- 9
SELECT nume, prenume, an, bursa * 1.15 AS bursa_marita FROM studenti;

-- 10
SELECT * FROM studenti WHERE (nume LIKE 'P%') AND an='1';

-- 11
SELECT * FROM studenti WHERE (prenume LIKE '%a%a%') OR (prenume LIKE 'A%a%');

-- 12
SELECT * FROM studenti WHERE prenume='Alexandru' OR prenume='Ioana' OR prenume='Marius';

-- 13
SELECT * FROM studenti WHERE bur

-- 14
SELECT nume, prenume FROM profesori WHERE (prenume LIKE '%_n');




