SET search_path = universityDB;

-- 1) Une fonction nbEtudiants en PL/pgSQL qui retourne le nombre total d’étudiants
CREATE OR REPLACE FUNCTION nbEtudiants() RETURNS INT AS $nombre_etudiant$
DECLARE nbr INTEGER;
BEGIN
-- count the number of students
SELECT COUNT(sID) INTO nbr FROM universityDB.Student;
RETURN nbr;
END;
$nombre_etudiant$ LANGUAGE plpgsql;


-- 2) Un trigger auditGrade qui crée un enregistrement dans une table archive Audit. Ce trigger se déclenche lorsque la note du cours est mise à jour. L’archive devra conserver les informations d’inscription ainsi que la date où la modification de la note du cours a été effectuée ;
CREATE OR REPLACE FUNCTION auditGradeHistory() RETURNS trigger AS $audit_grade$
DECLARE 
    Student_num Varchar(10);
    Course_num  Varchar(10);
    Section_num Varchar(10);
    grade       INTEGER;
    
BEGIN
	IF NOT OLD.note = NEW.note THEN
    --create the audit table if it does not exist
        CREATE TABLE IF NOT EXISTS universityDB.Audit (
            sID         Varchar(10)         Not NULL,
            cID			Varchar(10)         Not NULL,
            secID	    VARCHAR(10),
            note        INTEGER,
            date_time   Timestamp           Not NULL,
            PRIMARY KEY (sID, cID, date_time)
        );
        

        SELECT OLD.sID, OLD.cID, OLD.secID, OLD.note INTO Student_num, Course_num, Section_num, grade;
            
        INSERT INTO universityDB.Audit VALUES (Student_num, Course_num, Section_num, grade, CURRENT_TIMESTAMP);
        --INSERT INTO universityDB.Audit VALUES (OLD.sID, OLD.cID, OLD.secID, OLD.note, CURRENT_TIMESTAMP);
        RETURN NEW;
    END IF;
END;
$audit_grade$ LANGUAGE plpgsql;

CREATE TRIGGER auditGrade
AFTER UPDATE ON universityDB.enrollment
FOR EACH ROW
EXECUTE PROCEDURE auditGradeHistory();
-- On teste
UPDATE enrollment SET
note = 65 where sID = 's1';
