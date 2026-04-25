-- 1:  Afisati studentii doi cate doi impreuna cu diferenta de varsta dintre ei. Sortati in ordine crescatoare in functie de aceste diferente. Aveti grija sa nu comparati un student cu el insusi.
SELECT s.nume||' - '||t.nume||' : diferenta varsta: '|| FLOOR(ABS((MONTHS_BETWEEN(CURRENT_DATE, s.data_nastere) - MONTHS_BETWEEN(CURRENT_DATE, t.data_nastere))/12))  FROM studenti s JOIN studenti t ON s.nr_matricol != t.nr_matricol;
-- inc

-- 2: Afisati posibilele prietenii dintre studenti si profesori. Un profesor si un student se pot imprieteni daca numele lor de familie are acelasi numar de litere.
SELECT * FROM studenti s JOIN profesori p ON LENGTH(s.nume)=LENGTH(p.nume) ORDER BY s.nume;

-- 3: Afisati denumirile cursurilor la care s-au pus note cel mult egale cu 8 (<=8).
SELECT DISTINCT c.titlu_curs FROM cursuri c JOIN note n ON c.id_curs = n.id_curs AND n.valoare <= 8
MINUS
SELECT DISTINCT c.titlu_curs FROM cursuri c JOIN note n ON c.id_curs = n.id_curs AND n.valoare > 8
;

-- 4: Afisati numele studentilor care au toate notele mai mari ca 7 sau egale cu 7.
SELECT DISTINCT s.nume FROM studenti s JOIN note n ON s.nr_matricol = n.nr_matricol AND n.valoare >= 7
MINUS
SELECT DISTINCT s.nume FROM studenti s JOIN note n ON s.nr_matricol = n.nr_matricol AND n.valoare < 7
;

-- 5: Sa se afiseze studentii care au luat nota 7 sau nota 10 la OOP intr-o zi de marti.
SELECT DISTINCT s.nume, s.prenume FROM studenti s JOIN note n ON n.nr_matricol = s.nr_matricol
JOIN cursuri c ON n.id_curs = c.id_curs WHERE (n.valoare = 7 OR (n.valoare = 10 AND c.titlu_curs = 'OOP')) AND TO_CHAR(n.data_notare, 'day')='tuesday'
; 

-- 6: O sesiune este identificata prin luna si anul in care a fost tinuta. Scrieti numele si prenumele studentilor ce au promovat o anumita materie, cu notele luate de acestia si sesiunea in care a fost promovata materia. Formatul ce identifica sesiunea este "LUNA, AN", fara alte spatii suplimentare (De ex. "JUNE, 2015" sau "FEBRUARY, 2014"). In cazul in care luna in care s-a tinut sesiunea a avut mai putin de 30 de zile afisati simbolul "+" pe o coloana suplimentara, indicand faptul ca acea sesiune a fost mai grea (avand mai putine zile), in caz contrar (cand luna are mai mult de 29 de zile) valoarea coloanei va fi null.


