SET search_path=vetoSansFrontiere;


/*1) Lister les le numéro des cliniques, leur adresse et leur gestionnaire, ordonnés par le numéro de clinique*/
SELECT Clinic.cID, road, city, province, pCode, eID FROM vetoSansFrontiere.Clinic, vetoSansFrontiere.Employe WHERE Eposition = 'Manager' ORDER BY Clinic.cID;

/*2) Lister les names des animaux sans doublons dans toutes les cliniques*/
SELECT DISTINCT name FROM vetoSansFrontiere.Pet;

/*3) Lister les numéros et noms des propriétaires d’animaux ainsi que les détails de leurs animaux dans une clinique donnée (j’ai choisi la clinique 'c000002')*/
SELECT Owner.ownerID, Owner.name, petID, Pet.cID, Pet.name, Pet.specie, Pet.description, Pet.DOB, Dateinscription, Pet.status FROM vetoSansFrontiere.Pet , vetoSansFrontiere.Owner 
WHERE Owner.cID=Pet.cID AND Pet.ownerID = Owner.ownerID AND Owner.cID= 'c000002';

/*4) Lister l’ensemble des examens d’un animal donné (je choisi l'animal 2)*/
SELECT * FROM vetoSansFrontiere.Exam WHERE petID='2';

/*5) Lister les détails des traitements d’un animal suite à un examen donné (je choisi l'exam 'exa000002')*/
SELECT * FROM vetoSansFrontiere.Treatment WHERE examID= 'exa000002'; 

/*6) Lister le salaire total des employés par clinique ordonné par numéro de clinique*/
SELECT cl.cID, SUM(e.salary) AS salaryTotal FROM vetoSansFrontiere.Employe as e, vetoSansFrontiere.Clinic as cl 
WHERE e.cID=cl.cID
GROUP BY cl.cID
ORDER BY cl.cID;

/*7) Lister le nombre total d’animaux d’un type donné (j'ai choisi 'lion') dans chaque clinique*/
SELECT cl.cID, COUNT (an.*) as NamebreDeLions FROM vetoSansFrontiere.Clinic as cl, vetoSansFrontiere.Pet as an WHERE specie= 'lion' and an.cID=cl.cID
GROUP BY cl.cID;

/*8) Lister le coût minimum, maximum et moyen des traitements*/ 
SELECT MIN(tcost)as tcostMinimum, MAx(tcost)as tcostMaximum, CAST(AVG(tcost) as NUMERIC(5,2)) as tcostMoyen FROM vetoSansFrontiere.Treatment;

/*9) Quels sont les noms des employés de plus de 50 ans ordonnés par nom?*/
SELECT name, surname FROM vetoSansFrontiere.Employe 
GROUP BY eID
HAVING (select date_part('year',now()::date)-DATE_Part('year',DOB::date))>50
ORDER BY name;

/*10) Quels sont les propriétaires dont le nom contient « blay » ?*/
SELECT * FROM vetoSansFrontiere.Owner WHERE name LIKE '%blay%';

/*11) Supprimez le vétérinaire « Jean Tremblay »*/
DELETE FROM vetoSansFrontiere.Employe WHERE Eposition='Veterinaire' AND surname='Tremblay' AND name='Jean';

/*12) Lister les détails des propriétaires qui ont un chat et un chien*/
SELECT * FROM vetoSansFrontiere.Owner 
WHERE ownerID IN (SELECT ownerID FROM vetoSansFrontiere.Pet WHERE specie ='cat') 
		AND ownerID IN (SELECT ownerID FROM vetoSansFrontiere.Pet WHERE specie ='dog'); 

/*13) Lister les détails des propriétaires qui ont un chat ou un chien*/
SELECT * FROM vetoSansFrontiere.Owner 
WHERE ownerID IN (SELECT DISTINCT ownerID FROM vetoSansFrontiere.Pet WHERE specie ='cat' OR specie ='dog'); 

/*14) Lister les détails des propriétaires qui ont un chat mais pas de chien vacciné contre la grippe (la condition vacciné contre la grippe ne s’applique qu’aux chiens)*/
SELECT * FROM vetoSansFrontiere.Owner as pr 
WHERE ownerID IN (SELECT ownerID FROM vetoSansFrontiere.Pet 
						WHERE specie='chat') AND 
						((ownerID NOT IN (SELECT ownerID FROM vetoSansFrontiere.Pet WHERE specie='dog')) OR 
						 (ownerID IN (SELECT a1.ownerID FROM vetoSansFrontiere.Pet as a1 WHERE a1.specie='dog' AND a1.petID NOT IN (SELECT petID FROM vetoSansFrontiere.Exam WHERE examID IN (SELECT examID FROM vetoSansFrontiere.Treatment WHERE treatID='T112' AND sDate<now())))));

/*15) Lister tous les animaux d’une clinique donnée avec leurs traitements s’ils existent. Dans le
cas contraire, affichez null.*/
SELECT petID, Pet.name, trCl.treatID, trCl.description, trCl.tcost, trCl.examID, trCl.quantite, trCl.datedebut, trCl.eDate
FROM vetoSansFrontiere.Pet as an LEFT OUTER JOIN (SELECT * FROM vetoSansFrontiere.Exam NATURAL INNER JOIN 
			(SELECT * FROM vetoSansFrontiere.Treatment NATURAL INNER JOIN vetoSansFrontiere.Treatment) as tr) as trCl 
			 ON petID=trCl.petID
WHERE an.cID='C001'
ORDER BY petID;
