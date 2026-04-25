-- 1: Afișați numele studenților care iau cea mai mare bursa acordată.
SELECT * FROM studenti WHERE bursa IN (SELECT MAX(bursa) from studenti);

-- 2: Afișați numele studenților care sunt colegi cu un student pe nume Arhire (coleg = același an si aceeași grupă).
SELECT s1.nume FROM studenti s1 JOIN 
(SELECT * from studenti WHERE TRIM(LOWER(nume))='arhire') s2
ON s1.an = s2.an AND s2.grupa=s1.grupa AND s1.nr_matricol != s2.nr_matricol;

-- 3: Pentru fiecare grupă afișați numele studenților care au obținut cea mai mică notă la nivelul grupei.
SELECT * FROM 
    (SELECT s.nr_matricol, s.nume, s.grupa, MIN(n.valoare) VAL FROM studenti s JOIN note n ON s.nr_matricol = n.nr_matricol
    GROUP BY s.nr_matricol, s.nume, s.grupa) s
JOIN
    (SELECT s.grupa, MIN(n.valoare) VAL FROM studenti s JOIN note n ON s.nr_matricol = n.nr_matricol
    GROUP BY s.grupa) t
ON s.val = t.val AND s.grupa = t.grupa ORDER BY t.grupa;

-- 4: Identificați studenții a căror medie este mai mare decât media tuturor notelor din baza de date. Afișați numele și media acestora.
SELECT s.nr_matricol, s.nume, s.prenume, AVG(n.valoare) FROM studenti s JOIN note n ON n.nr_matricol = s.nr_matricol GROUP BY s.nr_matricol, s.nume, s.prenume HAVING ROUND(AVG(n.valoare), 2) > (SELECT AVG(valoare) FROM note)

-- 5: Afișați numele și media primilor trei studenți ordonați descrescător după medie.
SELECT * FROM (SELECT s.nr_matricol, s.nume, ROUND(AVG(n.valoare), 2) FROM studenti s JOIN note n ON n.nr_matricol = s.nr_matricol
GROUP BY s.nr_matricol, s.nume ORDER BY ROUND(AVG(n.valoare), 2) DESC) WHERE ROWNUM <= 3;

-- 6: Afișați numele studentului (studenților) cu cea mai mare medie precum și valoarea mediei (atenție: limitarea numărului de linii poate elimina studenții de pe poziții egale; găsiți altă soluție).
SELECT s.nr_matricol, s.nume, s.prenume, AVG(n.valoare) FROM studenti s JOIN note n ON n.nr_matricol = s.nr_matricol
GROUP BY s.nr_matricol, s.nume, s.prenume HAVING AVG(n.valoare) = (SELECT MAX(val) FROM (SELECT s.nr_matricol, AVG(n.valoare) val FROM studenti s JOIN note n ON n.nr_matricol = s.nr_matricol GROUP BY s.nr_matricol));



-- 7: Afişaţi numele şi prenumele tuturor studenţilor care au luat aceeaşi nota ca şi Ciprian Ciobotariu la materia Logică. Excludeţi-l pe acesta din listă. (Se știe în mod cert că există un singur Ciprian Ciobotariu și că acesta are o singură notă la logică)
SELECT s.nume, s.prenume FROM 
(
SELECT s.nume, s.prenume, n.valoare FROM studenti s JOIN note n ON n.nr_matricol = s.nr_matricol
JOIN cursuri c ON c.id_curs = n.id_curs AND c.titlu_curs = 'Logica'
)
s 
WHERE s.valoare = 
(SELECT n.valoare FROM note n JOIN studenti s ON s.nr_matricol = n.nr_matricol 
AND TRIM(s.nume)='Ciobotariu' AND TRIM(s.prenume)='Ciprian' JOIN cursuri c ON c.id_curs = n.id_curs AND c.titlu_curs='Logica'
) AND TRIM(s.nume) != 'Ciobotariu' AND TRIM(s.prenume) != 'Ciprian'
;

-- 8: Din tabela studenti, afisati al cincilea prenume in ordine alfabetica.
SELECT * FROM (SELECT * FROM (SELECT s.prenume FROM studenti s WHERE ROWNUM <= 5 ORDER BY s.prenume) s ORDER BY s.prenume DESC) s WHERE ROWNUM <= 1;

-- 9: Punctajul unui student se calculeaza ca fiind o suma intre produsul dintre notele luate si creditele la materiile la care au fost luate notele. Afisati toate informatiile studentului care este pe locul 3 in acest top.
SELECT s.nr_matricol, s.nume, s.prenume, SUM(s.punctaj) punctaj FROM
    (
    SELECT s.nr_matricol, s.nume, s.prenume, n.valoare * c.credite punctaj FROM note n JOIN cursuri c ON n.id_curs = c.id_curs
    JOIN studenti s ON n.nr_matricol = s.nr_matricol 
    
    ) s GROUP BY s.nr_matricol, s.nume, s.prenume
    ORDER BY punctaj DESC
    
    ;

-- 10: Afișați studenții care au notă maximă la o materie precum și nota și materia respectivă.
SELECT s.nume, s.prenume, c.titlu_curs, n.valoare FROM 
studenti s
JOIN note n ON n.nr_matricol = s.nr_matricol JOIN cursuri c ON c.id_curs = n.id_curs WHERE (c.titlu_curs, n.valoare) IN
(SELECT c.titlu_curs curs, MAX(n.valoare) FROM note n JOIN cursuri c ON c.id_curs = n.id_curs GROUP BY c.titlu_curs)
;