
-- INSERT SOME DOCTORS
INSERT into medidb.doctor (dID, dName, dAddress, dPhone, dDOB, dSalary) VALUES ('D0001', 'Salim Nichols', '315 Olivier Ave, Westmount, QC H3Z 2C8', '514-123-4567', DATE'1975-05-30', 123000);
INSERT into medidb.specialistd (DiD, ) VALUES ('D0001', 'Dermatology');
INSERT into medidb.doctor VALUES ('D0002', 'Samina Burt', '768 Avenue Hartland, Outremont, QC H2V 2X6', '514-333-43437', DATE'1972-12-23', 130399);
INSERT into medidb.medicald VALUES ('D0002', 500);
INSERT into medidb.doctor VALUES ('D0003', 'Arvin Chen', '2541 Duke Street, Montreal, QC H3C 5K4', '514-333-43437', DATE'1972-12-23', 234399);
INSERT into medidb.medicald VALUES ('D0003', 600);
INSERT into medidb.doctor VALUES ('D0004', 'Phoenix Mercado', '2680 rue Levy, Montreal, QC H3C 5K4', '514-111-4437', DATE'1975-10-20', 133229);
INSERT into medidb.specialistd VALUES ('D0004', 'Immunology');

-- INSERT SOME PATIENT
