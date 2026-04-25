-- 1: Afişaţi toţi studenţii care au în an cu ei măcar un coleg care să fie mai mare ca ei (vezi data naşterii). Atentie, un student s1 este mai mare daca are data_nastere mai mica decat celalat student s2.
SELECT * FROM studenti s1 WHERE EXISTS(SELECT * FROM studenti s2 WHERE s1.data_nastere > s2.data_nastere);

-- 2: Afişaţi toţi studenţii care au media mai mare decât media tuturor studenţilor din an cu ei. Pentru aceştia afişaţi numele, prenumele şi media lor.
SELECT * FROM 
(SELECT s1.nr_matricol, s1.nume an, s1.an, AVG(n.valoare) medie FROM studenti s1 JOIN note n
ON s1.nr_matricol = n.nr_matricol GROUP BY s1.nr_matricol, s1.nume, s1.an) s2
WHERE s2.medie > (SELECT AVG(n.valoare) FROM note n JOIN studenti s3 ON n.nr_matricol = s3.nr_matricol AND s2.an = s3.an);

-- 3: Afişaţi numele, prenumele si grupa celui mai bun student din fiecare grupa în parte.
SELECT s.nr_matricol, s.nume, s.grupa, s.medie FROM (SELECT s.nr_matricol, s.nume, s.grupa, AVG(n.valoare) medie FROM studenti s JOIN note n ON s.nr_matricol = n.nr_matricol GROUP BY s.nr_matricol, s.nume, s.grupa) s 
JOIN (SELECT s.grupa, MAX(s.medie) medie FROM (SELECT s.nr_matricol, s.grupa,  s.nume, AVG(n.valoare) medie FROM studenti s JOIN note n ON s.nr_matricol = n.nr_matricol GROUP BY s.nr_matricol, s.nume, s.grupa) s GROUP BY grupa) s1 ON s1.medie = s.medie AND s1.grupa = s.grupa;

-- 4: Găsiţi toţi studenţii care au măcar un coleg în acelaşi an care să fi luat aceeaşi nota ca şi el la măcar o materie.

-- 5: Afișați toți studenții care sunt singuri în grupă (nu au alți colegi în aceeași grupă).

-- 6: Afișați profesorii care au măcar un coleg (profesor) ce are media notelor puse la fel ca și el.

-- 7: Fara a folosi join, afisati numele si media fiecarui student.

-- 8: Afisati cursurile care au cel mai mare numar de credite din fiecare an (pot exista si mai multe pe an). - Rezolvati acest exercitiu si corelat si necorelat (se poate in ambele moduri). Care varianta este mai eficienta ?


