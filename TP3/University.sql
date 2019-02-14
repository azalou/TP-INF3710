DROP SCHEMA IF EXISTS universityDB CASCADE;

CREATE SCHEMA IF NOT EXISTS universityDB;

SET search_path = universityDB;

CREATE TABLE IF NOT EXISTS universityDB.etudiant (
	sID        Varchar(10)		Not NULL,
	sName      Varchar(20)		Not NULL,
	sSex       Varchar(100),
	sAge       INTEGER,
	sGPA       NUMERIC(3,2),
	PRIMARY KEY (sID)
);

CREATE TABLE IF NOT EXISTS universityDB.dept(
	dID			Varchar(5)       Not NULL,
	dnbrPHDs	INTEGER          Not NULL,
	PRIMARY KEY (dID),
	CONSTRAINT onSalary CHECK (dSalary>=100000.00)
);

CREATE TABLE IF NOT EXISTS universityDB.prof(
	pID			Varchar(10)       Not NULL,
	dnbrPHDs	INTEGER          Not NULL,
	dID	        VARCHAR(5)          Not NULL,
	PRIMARY KEY (pID),
	FOREIGN KEY (dID) REFERENCES dept(dID)
);

CREATE TABLE IF NOT EXISTS universityDB.cours(
	cID			Varchar(10)       Not NULL,
	cName	    VARCHAR(20)          Not NULL,
	dID	        VARCHAR(5)          Not NULL,
	PRIMARY KEY (cID),
	FOREIGN KEY (dID) REFERENCES dept(dID)
);

CREATE TABLE IF NOT EXISTS universityDB.section(
	cID			Varchar(10)       Not NULL,
	secID	    VARCHAR(10)          Not NULL,
	pID	        VARCHAR(5)          Not NULL,
	PRIMARY KEY (cID, secID),
	FOREIGN KEY (pID) REFERENCES prof(pID),
	FOREIGN KEY (cID) REFERENCES cours(cID)
);

CREATE TABLE IF NOT EXISTS universityDB.inscription(
    sID        Varchar(10)		Not NULL,
	cID			Varchar(10)       Not NULL,
	secID	    VARCHAR(10)          Not NULL,
	note        NUMERIC(3,2)          Not NULL,
	PRIMARY KEY (sID, cID, secID),
	FOREIGN KEY (sID) REFERENCES etudiant(sID),
	FOREIGN KEY (cID, secID) REFERENCES section(cID, secID)
);


