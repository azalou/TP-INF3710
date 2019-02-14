SET search_path=HOTELDB;

---- Fonction checkRoom qui implante le comportement désiré
CREATE OR REPLACE FUNCTION checkRoom() RETURNS TRIGGER AS $checkroomtrigger$

END;
$checkroomtrigger$ LANGUAGE plpgsql;


--- Trigger qui se déclenche avant d'insérer des données
DROP TRIGGER IF EXISTS checkroomtrigger on Room;



-- Test du trigger
INSERT INTO HOTELDB.Room VALUES ('2', 'H112', 'D', 50.00); 

