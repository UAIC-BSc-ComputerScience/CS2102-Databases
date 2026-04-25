-- 1: Afişaţi studenţii şi notele pe care le-au luat si profesorii care le-au pus acele note.
SELECT * FROM studenti s JOIN note n ON s.nr_matricol=n.nr_matricol JOIN didactic d ON d.id_curs=n.id_curs JOIN profesori p ON p.id_prof=d.id_prof;

-- 2: Afisati studenţii care au luat nota 10 la materia 'BD'. Singurele valori pe care aveţi voie să le hardcodaţi în interogare sunt valoarea notei (10) şi numele cursului ('BD').
SELECT * FROM studenti s JOIN note n ON s.nr_matricol=n.nr_matricol JOIN cursuri c ON n.id_curs=c.id_curs WHERE n.valoare=10 AND c.titlu_curs='BD';

-- 3: Afisaţi profesorii (numele şi prenumele) impreuna cu cursurile pe care fiecare le ţine.
SELECT p.nume, p.prenume, c.titlu_curs FROM profesori p JOIN didactic d ON d.id_prof=p.id_prof JOIN cursuri c ON c.id_curs=d.id_curs;

-- 4: Modificaţi interogarea de la punctul 3 pentru a fi afişaţi şi acei profesori care nu au încă alocat un curs.
SELECT p.nume, p.prenume, c.titlu_curs FROM profesori p LEFT OUTER  JOIN didactic d ON d.id_prof=p.id_prof LEFT OUTER JOIN cursuri c ON c.id_curs=d.id_curs;

-- 5: Modificaţi interogarea de la punctul 3 pentru a fi afişate acele cursuri ce nu au alocate încă un profesor.
SELECT p.nume, p.prenume, c.titlu_curs FROM profesori p LEFT OUTER  JOIN didactic d ON d.id_prof=p.id_prof RIGHT OUTER JOIN cursuri c ON c.id_curs=d.id_curs WHERE p.nume IS NULL;

-- 6: Modificaţi interogarea de la punctul 3 astfel încât să fie afişaţi atat profesorii care nu au nici un curs alocat cât şi cursurile care nu sunt încă predate de nici un profesor.
SELECT p.nume, p.prenume, c.titlu_curs FROM profesori p LEFT OUTER  JOIN didactic d ON d.id_prof=p.id_prof FULL OUTER JOIN cursuri c ON c.id_curs=d.id_curs;

-- 7: In tabela studenti există studenţi care s-au nascut în aceeasi zi a săptămânii. De exemplu, Cobzaru George şi Pintescu Andrei s-au născut amândoi într-o zi de marti. Construiti o listă cu studentii care s-au născut in aceeaşi zi grupându-i doi câte doi în ordine alfabetică a numelor (de exemplu in rezultat va apare combinatia Cobzaru-Pintescu dar nu va apare şi Pintescu-Cobzaru). Lista va trebui să conţină doar numele de familie a celor doi împreună cu ziua în care cei doi s-au născut. Evident, dacă există şi alţi studenti care s-au născut marti, vor apare si ei in combinatie cu cei doi amintiţi mai sus. Lista va fi ordonată în funcţie de ziua săptămânii în care s-au născut si, în cazul în care sunt mai mult de trei studenţi născuţi în aceeaşi zi, rezultatele vor fi ordonate şi după numele primei persoane din listă [pont: interogarea trebuie să returneze 10 rânduri daca nu se iau in considerare si perechile de studenti care au acelasi nume, 12 randuri daca se iau in considerare si studentii care au acelasi nume].
SELECT DISTINCT s.nume||'-'||t.nume, TO_CHAR(s.data_nastere, 'Day') FROM studenti s JOIN studenti t ON TO_CHAR(s.data_nastere, 'day')=TO_CHAR(t.data_nastere, 'day') AND s.nume < t.nume
ORDER BY TO_CHAR(s.data_nastere, 'Day') ASC
;

-- 8: Sa se afiseze, pentru fiecare student, numele colegilor care au luat nota mai mare ca ei la fiecare dintre cursuri. Formulati rezultatele ca propozitii (de forma "Popescu Gigel a luat nota mai mare ca Vasilescu Ionel la matera BD."). Dati un nume corespunzator coloanei [pont: interogarea trebuie să returneze 118 rânduri].
SELECT DISTINCT s.nume||' '||s.prenume||' a luat nota mai mare ca '||t.nume||' '||t.prenume||' la materia '||c.titlu_curs FROM studenti s
JOIN note n ON s.nr_matricol=n.nr_matricol JOIN cursuri c ON c.id_curs=n.id_curs, studenti t JOIN note ns ON t.nr_matricol=ns.nr_matricol JOIN cursuri cs ON cs.id_curs=ns.id_curs

WHERE s.nr_matricol != t.nr_matricol AND n.valoare > ns.valoare
; -- ?????


