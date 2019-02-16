


-- DEPARTEMENT
INSERT into universityDB.dept (dID, dnbrPHDs) VALUES ('genChem', 9);
INSERT into universityDB.dept (dID, dnbrPHDs) VALUES ('gigl', 40);
INSERT into universityDB.dept (dID, dnbrPHDs) VALUES ('Maths', 5);


-- Cours
INSERT into universityDB.course (cID, cName,	dID) VALUES ('105', 'programmation','gigl');
INSERT into universityDB.course (cID, cName,	dID) VALUES ('200', 'NLP','gigl');
INSERT into universityDB.course (cID, cName,	dID) VALUES ('304',	'Geometrie 101', 'Maths');
INSERT into universityDB.course (cID, cName,	dID) VALUES ('305',	'Theoremes en geometrie', 'Maths');
INSERT into universityDB.course (cID, cName,	dID) VALUES ('306',	'Geometrie intermediaire', 'Maths');
INSERT into universityDB.course (cID, cName,	dID) VALUES ('307',	'Geometrie','Maths');


-- Prof
INSERT into universityDB.prof (pID, pName, dID) VALUES ('p1', 'AZ', 'gigl');
INSERT into universityDB.prof (pID, pName, dID) VALUES ('p2', 'MG', 'gigl');
INSERT into universityDB.prof (pID, pName, dID) VALUES ('p3', 'NZ', 'Maths');
INSERT into universityDB.prof (pID, pName, dID) VALUES ('p4', 'LH', 'Maths');


-- Section
INSERT into universityDB.section (cID, secID, pID) VALUES ('105', '1', 'p1');
INSERT into universityDB.section (cID, secID, pID) VALUES ('105', '2', 'p1');	
INSERT into universityDB.section (cID, secID, pID) VALUES ('305', '1', 'p3');
INSERT into universityDB.section (cID, secID, pID) VALUES ('305', '2', 'p4');


--ETUDIANTS

INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Simon Nissan', 's1', 'M', 20, '4.2');
INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Laurent Passepartout', 's2', 'M', 30, '3.2');
INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Alexandra Laplace', 's3', 'F', 40, '2.8');
INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Alex Laplace', 's4', 'F', 30, '3.5');
INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Simon Belanger', 's5', 'M', 20, '3.2');
INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Mark Zuck', 's6', 'M', 30, '1.2');
INSERT into universityDB.student (sName, sID, sSex, sAge, sGPA) VALUES ('Sophie Yenamarre', 's7', 'M', 30, '4.2');


-- enrollment
INSERT into universityDB.enrollment (sID, cID, secID, note) VALUES ('s3', '105', '1', 90);
INSERT into universityDB.enrollment (sID, cID, secID, note) VALUES ('s2', '105', '1', 60);
INSERT into universityDB.enrollment (sID, cID, secID, note) VALUES ('s1', '105', '2', 70);
INSERT into universityDB.enrollment (sID, cID, secID, note) VALUES ('s5', '105', '2', 70);
INSERT into universityDB.enrollment (sID, cID, secID, note) VALUES ('s5', '305', '2', 100);
INSERT into universityDB.enrollment (sID, cID, secID, note) VALUES ('s6', '305', '2', 65);
/* 
Une tentative d'insertion dans enrollment échoue si le numéros de cours n'existe pas. En effet cID est une clef étrangère qui reférencie nécessairement une entrée dans l'entitée cours.

message d'erreur est
ERROR:  insert or update on table "enrollment" violates foreign key constraint "enrollment_sid_fkey"
DETAIL:  Key (sid)=(s3) is not present in table "etudiant".
*/
