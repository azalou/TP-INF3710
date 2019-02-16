/*
1) (0.5 point) 
2) (0.5 point) 
3) (1 point) 

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
SELECT * FROM universityDB.student WHERE NOT EXISTS (SELECT sID FROM universityDB.enrollment); -- a revoir


