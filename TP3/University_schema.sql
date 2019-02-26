DROP SCHEMA IF EXISTS universityDB CASCADE;

CREATE SCHEMA IF NOT EXISTS universityDB;

SET search_path = universityDB;

CREATE DOMAIN universityDB.SEX AS CHAR
	CHECK (VALUE IN ('M', 'F'));

CREATE TABLE IF NOT EXISTS universityDB.student (
	sID		Varchar(10)		Not NULL,
	sName      	Varchar(50)		Not NULL,
	sSex		SEX,
	sAge		INTEGER,
	sGPA		NUMERIC(3,2),
	PRIMARY KEY (sID)
);

CREATE TABLE IF NOT EXISTS universityDB.dept(
	dID		Varchar(10)       Not NULL,
	dnbrPHDs	INTEGER          Not NULL,
	PRIMARY KEY (dID)
);

CREATE TABLE IF NOT EXISTS universityDB.prof(
	pID		Varchar(10)       Not NULL,
	pName		VARCHAR(50)       Not NULL,
	dID	        Varchar(10)        Not NULL,
	PRIMARY KEY (pID),
	FOREIGN KEY (dID) REFERENCES dept(dID)
);

CREATE TABLE IF NOT EXISTS universityDB.course(
	cID		Varchar(10)       Not NULL,
	cName		VARCHAR(50)       Not NULL,
	dID	        Varchar(10)        Not NULL,
	PRIMARY KEY (cID),
	FOREIGN KEY (dID) REFERENCES dept(dID)
);

CREATE TABLE IF NOT EXISTS universityDB.section(
	cID		Varchar(10)       Not NULL,
	secID		VARCHAR(10)       Not NULL,
	pID		Varchar(10)        Not NULL,
	PRIMARY KEY (cID, secID),
	FOREIGN KEY (pID) REFERENCES prof(pID) ON DELETE SET NULL,
	FOREIGN KEY (cID) REFERENCES course(cID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS universityDB.enrollment(
    sID         Varchar(10)         Not NULL,
	cID			Varchar(10)         Not NULL,
	secID	    VARCHAR(10)         Not NULL,
	note        INTEGER,
	PRIMARY KEY (sID, cID, secID),
	FOREIGN KEY (sID) REFERENCES student(sID),
	FOREIGN KEY (cID, secID) REFERENCES section(cID, secID)
);


