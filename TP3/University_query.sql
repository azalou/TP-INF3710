-- 1) Retourner tous les étudiants par ordre croissant sur leur nom
SELECT * FROM universityDB.student ORDER BY sname ASC;

-- 2) Retourner le nom des professeurs et leur département. Nommez les colonnes Professeur et Dep
SELECT pName AS Professeur, dID AS Dep FROM universityDB.prof;

-- 3) Retourner le nom des professeurs qui travaillent dans un département de plus de 10 PHDs
SELECT prof.pName AS Professeur FROM universityDB.prof, universityDB.dept WHERE universityDB.dept.dnbrPHDs > 10;

-- 4) Retourner la plus haute note du cours '105' (toutes sections confondues)
SELECT MAX(note) FROM universityDB.enrollment WHERE cID = '105';

-- 5) Retourner la plus haute note du cours '105' par section
SELECT MAX(note)  FROM universityDB.enrollment WHERE cID = '105' GROUP BY SECID;

-- 6) Pour chaque cours, retourner le nombre d'étudiants par section pour les sections de plus d'un étudiant (exemple : c3, s1, 20)
DROP VIEW IF EXISTS COURS_SEC_NBR CASCADE;
CREATE VIEW COURS_SEC_NBR (Cours, Section, Nbr_Etudiant) 
AS SELECT cID, secID, COUNT(sID)
FROM universityDB.enrollment
GROUP BY cID, secID
ORDER BY cID;

SELECT Cours, Section, Nbr_Etudiant FROM COURS_SEC_NBR WHERE Nbr_Etudiant > 1;

-- 7) Retourner les infos des étudiants et de leurs inscriptions. La table doit également comprendre les étudiants qui ne sont inscrits dans aucun cours
SELECT * FROM universityDB.student 
LEFT JOIN universityDB.enrollment USING (sID);

--8)  Retourner l'info des étudiants qui ne sont inscrits à aucun cours - Utilisez une sous-requête
SELECT * FROM universityDB.student WHERE sID NOT IN (SELECT sID FROM universityDB.enrollment);

--9)  Imprimer les informations des cours qui parlent de géométrie (toutes les combinaisons de titres possibles)
SELECT * FROM universityDB.course WHERE cName SIMILAR TO '%(g|G)_om%';

--10) Imprimer le nom des étudiants qui suivent un cours de géométrie (toutes les combinaisons de titres possibles)
DROP VIEW IF EXISTS NumCOURS_NomCOURS_NumEtudiant CASCADE;
CREATE VIEW NumCOURS_NomCOURS_NumEtudiant (Num_Cours, Nom_Cours, Num_Etudiant )
AS SELECT course.cID, course.cNAme, enrollment.sID FROM universityDB.course
LEFT JOIN universityDB.enrollment USING (cID)

SELECT sName, cName FROM (
SELECT course.cID, course.cNAme, enrollment.sID FROM universityDB.course
LEFT JOIN universityDB.enrollment USING (cID)
WHERE enrollment.sID IS NOT NULL) AS foo
LEFT JOIN universityDB.Student USING (sID)
WHERE cName SIMILAR TO '%(g|G)_om%';

SELECT S.sName, C.cName
FROM universityDB.course C, universityDB.student S, universityDB.enrollment E
WHERE E.sID IS NOT NULL
AND cName SIMILAR TO '%(g|G)_om%';

--11)  Imprimer le nom des étudiants qui sont inscrits à au moins un cours du département GIGL et au moins un cours du département de mathématiques - Utilisez INTERSECT
(SELECT sName FROM universityDB.student WHERE sID IN (
SELECT sID FROM universityDB.enrollment WHERE cID IN (
SELECT cID from universitydb.course where dID = 'gigl'
)))
INTERSECT
(SELECT sName FROM universityDB.student WHERE sID IN (
SELECT sID FROM universityDB.enrollment WHERE cID IN (
SELECT cID from universitydb.course where dID = 'Maths'
)));

--12)   Imprimer le nom des étudiants qui suivent un cours du département GIGL OU un cours du département de mathématiques
(SELECT sName FROM universityDB.student WHERE sID IN (
SELECT sID FROM universityDB.enrollment WHERE cID IN (
SELECT cID from universitydb.course where dID = 'gigl'
)))
UNION
(SELECT sName FROM universityDB.student WHERE sID IN (
SELECT sID FROM universityDB.enrollment WHERE cID IN (
SELECT cID from universitydb.course where dID = 'Maths'
)));

--13) Quelle est la différence d'âge entre le plus vieux et le plus jeune étudiant ? Affichez le résultat dans une colonne nommée Differenc
SELECT MAX(sage) - MIN(sage) AS difference FROM universityDB.student;

--14)  Quel est le nombre d'étudiants dont la moyenne est supérieure à la moyenne de tous les étudiants ?
SELECT COUNT(sID) FROM universityDB.enrollment WHERE note > (SELECT AVG(enrollment.note) FROM enrollment);


