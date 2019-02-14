SET search_path=HOTELDB;

		
---- Fonction checkRoom qui implante le comportement désiré
CREATE OR REPLACE FUNCTION checkRoomDouble() RETURNS TRIGGER AS $checkroomtrigger2$


$checkroomtrigger2$ LANGUAGE plpgsql;


--- Trigger qui se déclenche avant d'insérer des données
DROP TRIGGER IF EXISTS checkroomtrigger2 on Room;



-- Test du trigger
-- Insertion OK
INSERT INTO HOTELDB.Room VALUES ('2162', 'H112', 'D', 150.00); 
-- Insertion non OK
INSERT INTO HOTELDB.Room VALUES ('2154', 'H112', 'D', 50.00); 


