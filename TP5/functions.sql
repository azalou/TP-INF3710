CREATE OR REPLACE FUNCTION enrollpet() RETURNS trigger AS $e_pet$
DECLARE 
    owner_ID  Varchar(10);
    Clinic_ID Varchar(10);
    pet_ID NUMERIC(2,0);
    
BEGIN        
	SELECT NEW.ownerID, NEW.cID, NEW.petID INTO owner_ID, Clinic_ID, pet_ID;   
	INSERT INTO vetoSansFrontiere.Enrollment(ownerID, cID, petID, enrol_date) VALUES (owner_ID, Clinic_ID, pet_ID, CURRENT_DATE);
	RETURN NEW;
END;
$e_pet$ LANGUAGE plpgsql;

CREATE TRIGGER petin
AFTER INSERT ON vetoSansFrontiere.Pet
FOR EACH ROW
EXECUTE PROCEDURE enrollpet();
