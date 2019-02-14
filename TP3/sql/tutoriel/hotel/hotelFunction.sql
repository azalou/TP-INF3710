SET SEARCH_PATH = hoteldb;

CREATE OR REPLACE FUNCTION totalHotelRecords () RETURNS integer AS $total$
DECLARE
	total integer;
BEGIN
	SELECT count(*) INTO total FROM hoteldb.hotel;
	RETURN total;
END
$total$ LANGUAGE plpgsql;

select hotelDB.totalHotelRecords();

-- Pour vérifier que la fonction est correcte, comptez le nombre de tuples: 
select * from Hotel;
