-- 1: Scrieți o interogare pentru a afișa data de azi. Etichetați coloana "Astazi".
SELECT CURRENT_DATE AS "Astazi" FROM dual;

-- 2: Pentru fiecare student afișați numele, data de nastere si numărul de luni între data curentă și data nașterii.
SELECT nume, data_nastere, MONTHS_BETWEEN(CURRENT_DATE, data_nastere) AS "Numar_Luni" FROM studenti;

-- 3: Afișați ziua din săptămână în care s-a născut fiecare student.
SELECT TO_CHAR(TO_DATE(data_nastere), 'DAY') AS "Zi nastere" FROM studenti;

-- 4: Utilizând functia de concatenare, obțineți pentru fiecare student textul 'Elevul <prenume> este in grupa <grupa>'.
SELECT CONCAT(CONCAT(CONCAT('Elevul ', prenume), ' este in grupa '), grupa) AS "Informatii studenti" FROM studenti;

-- 5: Afisati valoarea bursei pe 10 caractere, completand valoarea numerica cu caracterul $.
SELECT CONCAT(LPAD(bursa, 9, '*'), '$') FROM studenti WHERE bursa IS NOT NULL;

-- 6: Pentru profesorii al căror nume începe cu B, afișați numele cu prima litera mică si restul mari, precum și lungimea (nr. de caractere a) numelui.
SELECT LOWER(SUBSTR(TRIM(nume), 0, 1))||''||UPPER(SUBSTR(TRIM(nume), 1)), LENGTH(TRIM(nume)) FROM profesori WHERE nume LIKE 'B%';

-- 7: Pentru fiecare student afișați numele, data de nastere, data la care studentul urmeaza sa isi sarbatoreasca ziua de nastere si prima zi de duminică de dupa.
SELECT nume, data_nastere, CONCAT(SUBSTR(TO_DATE(data_nastere, 'dd/mm/yyyy'), 0, 7), TO_CHAR(CURRENT_DATE, 'YYYY')), NEXT_DAY(CONCAT(SUBSTR(TO_DATE(data_nastere, 'dd/mm/yyyy'), 0, 7), TO_CHAR(CURRENT_DATE, 'YYYY')), 'Sunday') FROM studenti;

-- 8: Ordonați studenții care nu iau bursă în funcție de luna cand au fost născuți; se va afișa doar numele, prenumele și luna corespunzătoare datei de naștere.
SELECT nume, prenume, TO_CHAR(data_nastere, 'MONTH') FROM studenti WHERE bursa IS NULL ORDER BY TO_CHAR(data_nastere, 'mm');

-- 9: Pentru fiecare student afișati numele, valoarea bursei si textul: 'premiul 1' pentru valoarea 450, 'premiul 2' pentru valoarea 350, 'premiul 3' pentru valoarea 250 și 'mentiune' pentru cei care nu iau bursa. Pentru cea de a treia coloana dati aliasul "Premiu".
SELECT nume, bursa, ('Premiul 1') AS "PREMIU" FROM studenti WHERE bursa = 450 UNION SELECT nume, bursa, ('Premiul 2') AS "PREMIU" FROM studenti WHERE bursa = 350 UNION SELECT nume, bursa, ('Premiul 3') AS "PREMIU" FROM studenti WHERE bursa = 250 UNION SELECT nume, bursa, ('MENTIUNE') AS "PREMIU" FROM studenti WHERE bursa IS NULL;

-- 10: Afişaţi numele tuturor studenților înlocuind apariţia literei i cu a şi apariţia literei a cu i.
SELECT TRANSLATE(nume, 'ai', 'ia') FROM studenti;

-- 11: Afișați pentru fiecare student numele, vârsta acestuia la data curentă sub forma '<x> ani <y> luni și <z> zile' (de ex '19 ani 3 luni și 2 zile') și numărul de zile până își va sărbători (din nou) ziua de naștere.
SELECT FLOOR((SYSDATE - data_nastere)/365) AS "Ani" FROM studenti;
SELECT FLOOR((FLOOR(SYSDATE - data_nastere) - FLOOR(FLOOR(SYSDATE - data_nastere)/365) * 365)/30) AS "Luni" FROM studenti;
SELECT (FLOOR(SYSDATE - data_nastere) - (FLOOR((SYSDATE - data_nastere)/365) * 365 + FLOOR((FLOOR(SYSDATE - data_nastere) - FLOOR(FLOOR(SYSDATE - data_nastere)/365) * 365)/30) * 30)) AS "Zile" FROM studenti;

SELECT nume, FLOOR((SYSDATE - data_nastere)/365)||' ani '||FLOOR((FLOOR(SYSDATE - data_nastere) - FLOOR(FLOOR(SYSDATE - data_nastere)/365) * 365)/30)||' luni si '||(FLOOR(SYSDATE - data_nastere) - (FLOOR((SYSDATE - data_nastere)/365) * 365 + FLOOR((FLOOR(SYSDATE - data_nastere) - FLOOR(FLOOR(SYSDATE - data_nastere)/365) * 365)/30) * 30))||' zile' AS "VARSTA", (365 - FLOOR((FLOOR(SYSDATE - data_nastere) - FLOOR(FLOOR(SYSDATE - data_nastere)/365) * 365)))  AS "NR_ZILE" FROM studenti;
-- ... man

-- 12: Presupunând că în următoarea lună bursa de 450 RON se mărește cu 10%, cea de 350 RON cu 15% și cea de 250 RON cu 20%, afișați pentru fiecare student numele acestuia, data corespunzătoare primei zile din luna urmatoare și valoarea bursei pe care o va încasa luna următoare. Pentru cei care nu iau bursa, se va afisa valoarea 0.
SELECT nume, TRUNC(ADD_MONTHS(CURRENT_DATE, 1), 'MONTH'), bursa * 1.1 AS "bursa" FROM studenti WHERE bursa = 450 UNION SELECT nume, TRUNC(ADD_MONTHS(CURRENT_DATE, 1), 'MONTH'), bursa * 1.15 AS "bursa" FROM studenti WHERE bursa = 350 UNION SELECT nume, TRUNC(ADD_MONTHS(CURRENT_DATE, 1), 'MONTH'), bursa * 1.2 AS "bursa" FROM studenti WHERE bursa = 250 UNION SELECT nume, TRUNC(ADD_MONTHS(CURRENT_DATE, 1), 'MONTH'), 0 AS "bursa" FROM studenti WHERE bursa IS NULL;

-- 13: Pentru studentii bursieri (doar pentru ei) afisati numele studentului si bursa in stelute: fiecare steluta valoreaza 50 RON. In tabel, alineati stelutele la dreapta.
SELECT nume, TRIM(RPAD(' ', FLOOR(bursa / 50), '*')) FROM studenti WHERE bursa IS NOT NULL;



