set search_path = universityDB;
/*
	Requètes SQL
*/

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
--Solution 1
DROP VIEW IF EXISTS universityDB.NumCOURS_NomCOURS_NumEtudiant_NomEtudiant CASCADE;
CREATE VIEW universityDB.NumCOURS_NomCOURS_NumEtudiant_NomEtudiant (Num_Cours, Nom_Cours, Num_Etudiant, Nom_Etudiant )
AS SELECT Co.cID, Co.cNAme, En.sID, St.sName
FROM universityDB.course Co, universityDB.enrollment En, universityDB.Student St
WHERE Co.cID = En.cID
AND En.sID = St.sID
GROUP BY Co.cID, En.sID, St.sName;
SELECT Nom_Etudiant FROM universityDB.NumCOURS_NomCOURS_NumEtudiant_NomEtudiant
WHERE Nom_Cours SIMILAR TO '%(g|G)_om%';
--Solution 2 (Mêmes resultats)
SELECT sName AS Nom_Etudiant FROM (
(SELECT course.cID, course.cNAme, E.sID FROM universityDB.enrollment E
LEFT JOIN universityDB.course USING (cID)) AS foo
LEFT JOIN universityDB.Student USING (sID))
WHERE cName SIMILAR TO '%(g|G)_om%';

--11)  Imprimer le nom des étudiants qui sont inscrits à au moins un cours du département GIGL et au moins un cours du département de mathématiques - Utilisez INTERSECT

(SELECT sName From universityDB.student S, universityDB.enrollment E, universityDB.course C
Where s.sID = E.sID
AND E.cID = C.cID
AND C.dID = 'gigl')
INTERSECT
(SELECT sName From universityDB.student S, universityDB.enrollment E, universityDB.course C
Where s.sID = E.sID
AND E.cID = C.cID
AND C.dID='Maths'
);

--12)   Imprimer le nom des étudiants qui suivent un cours du département GIGL OU un cours du département de mathématiques
(SELECT sName From universityDB.student S, universityDB.enrollment E, universityDB.course C
Where s.sID = E.sID
AND E.cID = C.cID
AND C.dID = 'gigl')
UNION
(SELECT sName From universityDB.student S, universityDB.enrollment E, universityDB.course C
Where s.sID = E.sID
AND E.cID = C.cID
AND C.dID='Maths'
);

--13) Quelle est la différence d'âge entre le plus vieux et le plus jeune étudiant ? Affichez le résultat dans une colonne nommée Differenc
SELECT MAX(sage) - MIN(sage) AS difference FROM universityDB.student;

--14)  Quel est le nombre d'étudiants dont la moyenne est supérieure à la moyenne de tous les étudiants ?
SELECT COUNT(sID) FROM universityDB.enrollment WHERE note > (SELECT AVG(enrollment.note) FROM enrollment);

--15)  Quels sont le ou les étudiants avec la plus grande moyenne ? Affichez le nom des étudiants et leur moyenne
SELECT sName FROM student WHERE sGPA = (SELECT MAX(sGPA) FROM Student);



