/*a) Affichez tous les docteurs et leurs détails.*/
SELECT *
FROM medi_schema.doctor;

/*b) Affichez les patients et leurs paiements.*/
SELECT * 
FROM medi_schema.patient
LEFT JOIN medi_schema.payment USING (pID);

/*c) Quels sont les rendez-vous (Appointment) du docteur dont le matricule est D001 ?*/
SELECT *
FROM medi_schema.appointment
WHERE (dId='D001');

/*d) Listez tous les spécialistes, incluant tous leurs attributs de médecin et leur champ de
spécialité (FieldArea).*/
SELECT * 
FROM medi_schema.specialist
LEFT JOIN medi_schema.doctor USING (dId);

/*e) Affichez le nom de tous les patients et leur date de naissance.*/
SELECT pName, pDOB
FROM medi_schema.patient;

