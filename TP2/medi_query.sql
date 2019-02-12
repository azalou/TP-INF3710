/*a) Affichez tous les docteurs et leurs détails.*/
SELECT *
FROM mediDB.doctor;

/*b) Affichez les patients et leurs paiements.*/
SELECT * 
FROM mediDB.patient
LEFT JOIN mediDB.payment USING (pID);

/*c) Quels sont les rendez-vous (Appointment) du docteur dont le matricule est D001 ?*/
SELECT *
FROM mediDB.appointment
WHERE (dId='D001');

/*d) Listez tous les spécialistes, incluant tous leurs attributs de médecin et leur champ de
spécialité (FieldArea).*/
SELECT * 
FROM mediDB.specialist
LEFT JOIN mediDB.doctor USING (dId);

/*e) Affichez le nom de tous les patients et leur date de naissance.*/
SELECT pName, pDOB
FROM mediDB.patient;

