SET search_path = medi;

DROP SCHEMA IF EXISTS mediDB CASCADE;

CREATE SCHEMA IF NOT EXISTS mediDB;

CREATE TABLE IF NOT EXISTS mediDB.patient (
	pID			Varchar(10)		Not NULL,
	pName		Varchar(20)		Not NULL,
	pNAS        VARCHAR(15)     UNIQUE Not NULL,
	pAddress	Varchar(100)	Not NULL,
	pPhone		Varchar(50)		Not NULL,
	pDOB		Date			Not NULL,
	PRIMARY KEY (pID)
);

CREATE TABLE IF NOT EXISTS mediDB.doctor(
	dID			Varchar(10)		UNIQUE Not NULL,
	dName		Varchar(20)		Not NULL,
	dAddress	Varchar(100)	Not NULL,
	dPhone		Varchar(50)		Not NULL,
	dDOB		Date			Not NULL,
	dSalary		Numeric(8,2)	Not Null,
	PRIMARY KEY (dID),
	CONSTRAINT onSalary CHECK (dSalary>=100000.00)
);

CREATE TABLE IF NOT EXISTS mediDB.medicald(
	dID			Varchar(10)		Not NULL,
	dOtimeRate	Numeric(6,2)	Not NULL,
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
	bID			Varchar(10)		Not NULL,-- pas sur ici
	PRIMARY KEY (payID, bID),
	FOREIGN KEY (payID) REFERENCES mediDB.payment(payID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (bID) REFERENCES mediDB.bill(bID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TRIGGER medicald_not_specialistd
BEFORE INSERT ON mediDB.medicald
WHEN EXISTS (SELECT * FROM medidb.specialistd WHERE dID = NEW.dID)
BEGIN
	SELECT RAISE(FAIL, "a Doctor can either be medical or specialist not both"
END;

CREATE TRIGGER specialistd_not_medicald
BEFORE INSERT ON mediDB.specialistd
WHEN EXISTS (SELECT * FROM medidb.medicald WHERE dID = NEW.dID)
EXECUTE FUNCTION raise_exeption();


CREATE FUNCTION raise_exeption()
BEGIN
	SELECT RAISE(FAIL, "a Doctor can either be medical or specialist not both"
END;

