DROP SCHEMA IF EXISTS vetoSansFrontiere CASCADE;

CREATE SCHEMA IF NOT EXISTS vetoSansFrontiere;

SET search_path = vetoSansFrontiere;

CREATE DOMAIN SEX AS CHAR
    CHECK (VALUE IN ('M','F'));
    
CREATE DOMAIN DOA AS VARCHAR(5)
    CHECK (VALUE IN ('Dead','Alive'));

CREATE TABLE IF NOT EXISTS Clinique (
    cID         Varchar(10)		Not NULL,
    phone       Varchar(20),
    fax         Varchar(50),
    road        Varchar(50),
    city        Varchar(50),
    province    Varchar(10),
    pCode       Varchar(10),
    PRIMARY KEY (cID)
);

CREATE TABLE IF NOT EXISTS Personel (
    persID      Varchar(10)     Not NULL,
    NAS         Varchar(50)     Unique Not NULL,
    name        Varchar(50),
    surname     Varchar(50),
    phone       Varchar(20),
    DOB         Date,
    sex         SEX,
    position    Varchar(50),
    salary      Numeric(7,2)
    road        Varchar(50),
    city        Varchar(50),
    province    Varchar(10),
    pCode       Varchar(10),
    PRIMARY KEY (persID, name),
    ALTERNATE KEY (NAS)
);

CREATE TABLE IF NOT EXISTS Owner (
    ownerID     Varchar(10)		Not NULL,
    name        Varchar(50),
    surname     Varchar(50),
    phone       Varchar(20),
    road        Varchar(50),
    city        Varchar(50),
    province    Varchar(10),
    pCode       Varchar(10),
    PRIMARY KEY (ownerID)
);

CREATE TABLE IF NOT EXISTS Pet (
    ownerID     Varchar(10)		Not NULL,
    petID       Varchar(10)     Not NULL,
    specie      Varchar(20)     Not NULL,
    description Varchar,
    DOB         Date,
    status      DOA,
    PRIMARY KEY (ownerID, petID),
    FOREIGN KEY (ownerID) REFERENCES Owner(ownerID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Enrollment (
    cID         Varchar(10)		Not NULL,
    petID       Varchar(10)     Not NULL,
    ownerID     Varchar(10)		Not NULL,
    enrol_date  Date            Not NULL,
    PRIMARY KEY (cID, petID, ownerID),
    FOREIGN KEY (cID) REFERENCES Clinique(cID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (petID) REFERENCES Pet(petID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ownerID) REFERENCES Owner(ownerID) ON DELETE ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Physical_Exam (
    persID      Varchar(10)     Not NULL,
    vetName     Varchar(50)     Not NULL,
    petID       Varchar(10)     Not NULL,
    examID      Varchar(10)     Not NULL,
    examDate    Date            Not NULL,
    examTime    Time            Not NULL,
    description VARCHAR,
    PRIMARY KEY (persID, vetName, petID, examID, examDate),
    FOREIGN KEY (persID, vetName) REFERENCES Personel(persID, name),
    FOREIGN KEY (petID) REFERENCES Pet(petID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS treatment (
    treatID     Varchar(10)     Not NULL,
    description Varchar,
    tcost       Numeric(5,2),
    PRIMARY KEY (treatID)
);

CREATE TABLE IF NOT EXISTS ProposedTreatment(
    treatID     Varchar(10)     Not NULL,
    examID      Varchar(10)     Not NULL,
    examDate    Date            Not NULL,
    petID       Varchar(10)     Not NULL,
    qtity       INTEGER         Not NULL,
    sDate       Date,
    eDate       Date,
    PRIMARY KEY (treatID, examID, examDate, petID),
    FOREIGN KEY (examID, examDate) REFERENCES Physical_Exam(examID, examDate) ON DELETE RESTRICT ON UPDATE CASCADE
    FOREIGN KEY (petID) REFERENCES Pet(petID) ON DELETE RESTRICT ON UPDATE CASCADE
);

