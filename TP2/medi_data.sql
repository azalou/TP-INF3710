-- REINITIALISATION
DELETE FROM medidb.billpayments;
DELETE FROM medidb.bill;
DELETE FROM medidb.appointment;
DELETE FROM medidb.doctor;
DELETE FROM medidb.patient;
DELETE FROM medidb.payment;


-- INSERT SOME DOCTORS
INSERT into medidb.doctor (dID, dName, dAddress, dPhone, dDOB, dSalary)
VALUES ('D001', 'Salim Nichols', '315 Olivier Ave, Westmount, QC H3Z 2C8', '514-123-4567', DATE'1975-05-30', 123000);
INSERT into medidb.specialistd (dID, dFieldArea) VALUES ('D001', 'Dermatology');

INSERT into medidb.doctor VALUES ('D002', 'Samina Burt', '768 Avenue Hartland, Outremont, QC H2V 2X6', '514-333-43437', DATE'1972-12-23', 130399);
INSERT into medidb.medicald (dID, dOTimeRate) VALUES ('D002', 500);

INSERT into medidb.doctor VALUES ('D003', 'Arvin Chen', '2541 Duke Street, Montreal, QC H3C 5K4', '514-333-43437', DATE'1972-12-23', 234399);
INSERT into medidb.medicald VALUES ('D003', 600);

INSERT into medidb.doctor VALUES ('D004', 'Phoenix Mercado', '2680 rue Levy, Montreal, QC H4R 2P1', '514-111-4437', DATE'1975-10-20', 133229);
INSERT into medidb.specialistd VALUES ('D004', 'Immunology');

INSERT into medidb.doctor VALUES ('D005', 'Doris J Dawson', '994 Ste. Catherine Ouest, Montreal, QC H2A 2Z3', '514-743-5391', DATE'1972-03-17', 298229);
INSERT into medidb.specialistd VALUES ('D005', 'gastroenterology');

INSERT into medidb.doctor VALUES ('D006', 'Kenneth T Perez', '4620 Papineau Avenue, QC H2K 4J5', '514-111-4437', DATE'1969-04-24', 298229);
INSERT into medidb.medicald VALUES ('D006', 645);




-- INSERT SOME PATIENTS
INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000001', 'Jaxon OBrien', '4465 Duke Street, Montreal, QC H3C 5K4', '514-123-4567', DATE'1985-03-12', '987 345 256' );

INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000002', 'Jayne Davidson', '2986 rue Ontario Ouest, Montreal, QC H2X 1Y8', '514-283-7931', DATE'1981-09-11', '846 345 453' );

INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000003', 'Carys Horn', '2567 rue Levy, Montreal, QC H3C 5K4', '514-378-5389', DATE'1965-05-15', '878 345 453' );

INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000004', 'James A Burgess', '2777 Ste. Catherine Ouest, Montreal, QC H2A 2Z3', '514-777-7412', DATE'1983-02-23', '859 345 453' );

INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000005', 'Dupont A Haddock', '3456 rue Bourret, Montreal, QC H3W 2K3', '514-987-6453', DATE'1993-08-12', '800 345 453' );

INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000006', 'Israel V Gant', '3748 René-Lévesque Blvd, Montreal, QC H3B 4W8', '514-573-5968', DATE'1988-09-25', '846 111 453' );

INSERT INTO medidb.patient (pID, pName, pAddress, pPhone, pDOB, pNAS)
VALUES ('P0000007', 'Ethel I Cleaver', '2863 Papineau Avenue, Montreal, QC H2K 4J5', '514-924-9393', DATE'1937-08-19', '846 345 777' );


-- INSERT SOME APPOINTMENTS
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000001', DATE'2019-04-15', TIME'08:00', 'P0000001', 'D003');
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000002', DATE'2019-07-31', TIME'10:00', 'P0000001', 'D004');
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000003', DATE'2019-11-06', TIME'08:00', 'P0000001', 'D003');

INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000004', DATE'2019-04-15', TIME'08:00', 'P0000002', 'D001');
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000005', DATE'2019-07-31', TIME'10:30', 'P0000002', 'D002');
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000006', DATE'2019-11-06', TIME'09:00', 'P0000002', 'D001');

INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000007', DATE'2019-04-15', TIME'08:00', 'P0000003', 'D005');
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000008', DATE'2019-07-31', TIME'10:30', 'P0000003', 'D006');
INSERT INTO medidb.appointment (aID, aDate, aTime, pID, dID)
VALUES ('A000000009', DATE'2019-11-06', TIME'09:00', 'P0000003', 'D005');


-- INSERT SOME PAYMENTS
INSERT INTO medidb.payment (payID, pID, pDetails, pMethod)
VALUES ('PAY0000001', 'P0000001', 545, 'VIREMENT');
INSERT INTO medidb.payment (payID, pID, pDetails, pMethod)
VALUES ('PAY0000004', 'P0000001', 545, 'VIREMENT');
INSERT INTO medidb.payment (payID, pID, pDetails, pMethod)
VALUES ('PAY0000005', 'P0000001', 1000, 'VIREMENT');

INSERT INTO medidb.payment (payID, pID, pDetails, pMethod)
VALUES ('PAY0000002', 'P0000002', 345, 'VIREMENT');
INSERT INTO medidb.payment (payID, pID, pDetails, pMethod)
VALUES ('PAY0000006', 'P0000002', 1000, 'VIREMENT');

INSERT INTO medidb.payment (payID, pID, pDetails, pMethod)
VALUES ('PAY0000003', 'P0000003', 300, 'VIREMENT');

-- INSERT SOME BILLS
INSERT INTO medidb.bill
VALUES ('B000000001', 'D003', 2400);
INSERT INTO medidb.bill
VALUES ('B000000005', 'D004', 3400);
INSERT INTO medidb.bill
VALUES ('B000000002', 'D001', 4999);
INSERT INTO medidb.bill
VALUES ('B000000003', 'D002', 200);
INSERT INTO medidb.bill
VALUES ('B000000004', 'D006', 300);


-- INSERT RELATIONSHIP BETWEEN BILL AND PAYMENTS
INSERT INTO medidb.billpayments (payID, pID, bID, dID)
VALUES ('PAY0000001', 'P0000001', 'B000000001', 'D003');
INSERT INTO medidb.billpayments (payID, pID, bID, dID)
VALUES ('PAY0000004', 'P0000001', 'B000000001', 'D003');
INSERT INTO medidb.billpayments (payID, pID, bID, dID)
VALUES ('PAY0000005', 'P0000001', 'B000000005', 'D004');

INSERT INTO medidb.billpayments (payID, pID, bID, dID)
VALUES ('PAY0000002', 'P0000002', 'B000000002', 'D001');
INSERT INTO medidb.billpayments (payID, pID, bID, dID)
VALUES ('PAY0000006', 'P0000002', 'B000000002', 'D001');

INSERT INTO medidb.billpayments (payID, pID, bID, dID)
VALUES ('PAY0000003', 'P0000003', 'B000000004', 'D006');

