-- -- Check that Employe position is veterinaire
CREATE OR REPLACE FUNCTION Examen() RETURNS trigger AS $Examin$
DECLARE 
    eID         Varchar(10);   
	Eposition    Varchar(50),
    
BEGIN        
	
	IF NOT EXISTS (SELECT eID FROM vetoSansFrontiere.Employe WHERE eID=NEW.eID and Eposition = 'veterinaire') THEN
	RAISE EXCEPTION 'THE FUNCTION OF EMPLOYEE MUST BE veterinaire';
	END IF;
	RETURN NEW;
	END;
	$Examin$ LANGUAGE plpgsql;

CREATE TRIGGER Examin
BEFOR INSERT OR UPDATE ON vetoSansFrontiere.Exam
FOR EACH ROW
EXECUTE PROCEDURE Examen();
