
Bonjour, je te mets ici la correction pour le moment, en attendant
que amal la publie sur moodle


-- Requête 1:
-- Affichez tous les docteurs et leurs détails. Vous devez retourner tous les attributs.
SELECT * 
FROM MEDICDB.Doctor;
 
-- Requête 2:
-- Affichez les patients et leurs paiements. Vous devez retourner tous les attributs.
SELECT * 
FROM MEDICDB.Patient p , MEDICDB.Payment py 
WHERE p.Patientno=py.Patientno;
 
-- Requête 3:
-- Quels sont les rendez-vous (Appointment) du docteur dont le matricule est D001?Vous devez retourner tous les attributs.
SELECT * 
FROM MEDICDB.Doctor D, MEDICDB.Appoinment A 
WHERE D.Doctorid=A.Doctorid and D.Doctorid='D001';
 
-- Requête 4:
-- Listez tous les spécialistes, incluant tous leurs attributs de médecin et leur champ de spécialité (FieldArea).
 
SELECT *
FROM MEDICDB.Specialist s, MEDICDB.Doctor d
WHERE s.DoctorID = d.DoctorID;
 
-- Requête 5:
-- Affichez le nom de tous les patients et leur date de naissance
SELECT name, Dob 
FROM MEDICDB.Patient;