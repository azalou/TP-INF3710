﻿DROP TABLE IF EXISTS medidb.doctor CASCADE;
DROP TABLE IF EXISTS medidb.patient CASCADE;
DROP TABLE IF EXISTS medidb.bill CASCADE;
DROP TABLE IF EXISTS medidb.payment CASCADE;

DROP SCHEMA IF EXISTS mediDB CASCADE;

CREATE SCHEMA IF NOT EXISTS mediDB;

SET search_path = mediDB;

CREATE TABLE IF NOT EXISTS mediDB.patient (
	pID			Varchar(10)		Not NULL,
	pName		Varchar(20)		Not NULL,
	pAddress	Varchar(100),
	pPhone		Varchar(50),
	pDOB		Date,
	PRIMARY KEY (pID)
);

CREATE TABLE IF NOT EXISTS mediDB.doctor(
	dID			Varchar(10)		Not NULL,
	dName		Varchar(20)		Not NULL,
	dAddress	Varchar(100),
	dPhone		Varchar(50)		Not NULL,
	dDOB		Date,
	dSalary		Numeric(8,2),
	PRIMARY KEY (dID),
	CONSTRAINT onSalary CHECK (dSalary>=100000.00)
);

CREATE TABLE IF NOT EXISTS mediDB.appointment (
	aID        VARCHAR(10)     NOT NULL,
	aDate      DATE            NOT NULL,
	aTime      TIME            NOT NULL,
	pID        VARCHAR(10)     NOT NULL,
	dID        VARCHAR(10)     NOT NULL,
	PRIMARY KEY (aID, pID, dID),
	FOREIGN KEY (pID) REFERENCES mediDB.patient(pID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (dID) REFERENCES mediDB.doctor(dID) ON DELETE RESTRICT ON UPDATE CASCADE
	--CONSTRAINT onDate CHECK (aDate >= current_date)
);

CREATE TABLE IF NOT EXISTS mediDB.medicald(
	dID			Varchar(10)		Not NULL,
	dOtimeRate	Numeric(6,2),
	PRIMARY KEY (dID),
	FOREIGN KEY (dID) REFERENCES mediDB.doctor(dID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS mediDB.specialistd(
	dID			Varchar(10)		Not NULL,
	dFieldArea	Varchar(30)		Not NULL,
	PRIMARY KEY (dID),
	FOREIGN KEY (dID) REFERENCES mediDB.doctor(dID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS mediDB.bill(
	bID			Varchar(10)		UNIQUE Not NULL,
	dID			Varchar(10)		Not NULL,
	bTotal      Numeric(8,2)    Not NULL,
	PRIMARY KEY (bID, dID),
	FOREIGN KEY (dID) REFERENCES mediDB.doctor(dID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS mediDB.payment(
	payID		Varchar(10)		UNIQUE Not NULL,
	pID			Varchar(10)		Not NULL,
	pDetails	Numeric(8,2)	Not NULL,
	pMethod		Varchar(100)	Not NULL,
	PRIMARY KEY (payID, pID),
	FOREIGN KEY (pID) REFERENCES mediDB.patient(pID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS mediDB.billpayments(
	payID		Varchar(10)		Not NULL,
	pID		    Varchar(10)		Not NULL,
	bID			Varchar(10)		Not NULL,
	dID			Varchar(10)		Not NULL,
	PRIMARY KEY (payID, bID),
	FOREIGN KEY (payID, pID) REFERENCES mediDB.payment(payID, pID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (bID, dID) REFERENCES mediDB.bill(bID, dID) ON DELETE RESTRICT ON UPDATE CASCADE
);

---- ALTERATIONS
ALTER TABLE medidb.patient ADD COLUMN pNAS VARCHAR(15) UNIQUE;

---- FONCTIONS

-- CREATE OR REPLACE FUNCTION mediDB.speclialistd_exor_medicald() RETURNS trigger AS $check_mandatoryor$
-- BEGIN
-- -- Check that dID is not in medicald
-- IF EXISTS (SELECT dID FROM medidb.medicald WHERE dID = NEW.dID) OR
-- 	EXISTS (SELECT dID FROM medidb.specialistd WHERE dID = NEW.dID) THEN
-- RAISE EXCEPTION 'Doctor cannot be both medicald and specialistd';
-- END IF;
-- RETURN NEW;
-- END;
-- $check_mandatoryor$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION prevent_delete_on_doctor_with_bill() RETURNS trigger AS
-- $check_preventdbil$
-- BEGIN
-- IF EXISTS (SELECT dID FROM medidb.doctor WHERE dID = OLD.dID) THEN
--     RAISE EXCEPTION 'Cannot delete a doctor that produced a bill';
-- END IF;
-- RETURN NEW;
-- END;
-- $check_preventdbil$ LANGUAGE plpgsql;
    

-- CREATE TRIGGER exclusive_specialist_medical
--     BEFORE INSERT OR UPDATE 
--     ON medidb.specialistd
--     FOR EACH ROW
--     EXECUTE PROCEDURE medidb.speclialistd_exor_medicald();
-- 	
-- CREATE TRIGGER exclusive_medical_specialist
--     BEFORE INSERT OR UPDATE 
--     ON medidb.medicald
--     FOR EACH ROW
--     EXECUTE PROCEDURE medidb.speclialistd_exor_medicald();
    
-- CREATE TRIGGER avoid_delete_if_bill
--     BEFORE DELETE
--     ON medidb.doctor
--     FOR EACH ROW
--     EXECUTE PROCEDURE prevent_delete_on_doctor_with_bill();
