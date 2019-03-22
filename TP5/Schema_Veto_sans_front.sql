DROP SCHEMA IF EXISTS vetoSansFrontiere CASCADE;

CREATE SCHEMA IF NOT EXISTS vetoSansFrontiere;

SET search_path = vetoSansFrontiere;

CREATE DOMAIN SEX AS CHAR
    CHECK (VALUE IN ('M','F'));
    
CREATE DOMAIN DOA AS VARCHAR(5)
    CHECK (VALUE IN ('Dead','Alive'));

CREATE TABLE IF NOT EXISTS Clinic (
    cID         Varchar(10)		UNIQUE Not NULL,
    phone       Varchar(20),
    fax         Varchar(50),
    road        Varchar(50),
    city        Varchar(50),
    province    Varchar(10),
    pCode       Varchar(10),
    PRIMARY KEY (cID)
);

CREATE TABLE IF NOT EXISTS Employe (
    eID         Varchar(10)     Not NULL,
    cID         Varchar(10)		Not NULL,
    NAS         Varchar(50)     Unique Not NULL,
    Ename       Varchar(50),
    surname     Varchar(50),
    phone       Varchar(20),
    DOB         Date,
    Esex         SEX,
    Eposition    Varchar(50),
    salary      Numeric(7,2),
    road        Varchar(50),
    city        Varchar(50),
    province    Varchar(10),
    pCode       Varchar(10),
    PRIMARY KEY (eID),
    FOREIGN KEY (cID) REFERENCES Clinic(cID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Owner (
    ownerID     Varchar(10)		Not NULL,
    cID         Varchar(10)		Not NULL,
    Oname       Varchar(50),
    surname     Varchar(50),
    phone       Varchar(20),
    road        Varchar(50),
    city        Varchar(50),
    province    Varchar(10),
    pCode       Varchar(10),
    UNIQUE (ownerID,cID),
    PRIMARY KEY (ownerID, cID),
    FOREIGN KEY (cID) REFERENCES Clinic(cID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Pet (
    ownerID     Varchar(10)		Not NULL,
    cID         Varchar(10)		Not NULL,
    petID       NUMERIC(2,0)     	Not NULL,
    specie      Varchar(20)     Not NULL,
    description Varchar,
    DOB         Date,
    status      DOA,
    UNIQUE (ownerID, cID, petID),
    PRIMARY KEY (ownerID, cID, petID),
    FOREIGN KEY (ownerID, cID) REFERENCES Owner(ownerID, cID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Enrollment (
    enID	Varchar(10)		Not NULL,
    ownerID     Varchar(10)		Not NULL,
    cID         Varchar(10)		Not NULL,
    petID       NUMERIC(2,0)     	Not NULL,
    enrol_date  Date            	Not NULL,
    PRIMARY KEY (enID),
    FOREIGN KEY (ownerID, cID, petID) REFERENCES Pet(ownerID, cID, petID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Physical_Exam (
    eID         Varchar(10)     Not NULL,
    ownerID     Varchar(10)		Not NULL,
    cID         Varchar(10)		Not NULL,
    petID       NUMERIC(2,0)     	Not NULL,
    examID      Varchar(10)     Not NULL,
    examDate    Date            Not NULL,
    examTime    Time            Not NULL,
    description VARCHAR,
    PRIMARY KEY (examID),
    FOREIGN KEY (eID) REFERENCES Employe(eID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ownerID, cID, petID) REFERENCES Pet(ownerID, cID, petID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Treatment (
    treatID     Varchar(10)     Not NULL,
    description Varchar,
    tcost       Numeric(5,2),
    PRIMARY KEY (treatID)
);

CREATE TABLE IF NOT EXISTS ProposedTreatment(
    treatID     Varchar(10)     Not NULL,
    examID      Varchar(10)     Not NULL,
    ownerID     Varchar(10)		Not NULL,
    cID         Varchar(10)		Not NULL,
    petID       NUMERIC(2,0)     	Not NULL,
    qtity       INTEGER         Not NULL,
    sDate       Date,
    eDate       Date,
    PRIMARY KEY (treatID),
    FOREIGN KEY (examID) REFERENCES Physical_Exam(examID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ownerID, cID, petID) REFERENCES Pet(ownerID, cID, petID) ON DELETE RESTRICT ON UPDATE CASCADE
);

