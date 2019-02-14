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

CREATE OR REPLACE FUNCTION check_room() RETURNS TRIGGER AS $check_room_trigger$
BEGIN
IF (new.typeroom= 'D' AND new.price < 100) THEN
	BEGIN
		RAISE EXCEPTION 'Price for double room must be over 100';
	END;
END IF;
RETURN NEW;
END;
$check_room_trigger$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_room() RETURNS TRIGGER AS $check_room_trigger2$
BEGIN
IF (new.typeroom='D') then
DECLARE max_price_single NUMERIC(6,3);
BEGIN
	SELECT MAX(price) into max_price_single FROM Room WHERE typeroom='S';
	IF (NEW.price < max_price_single) THEN
		RAISE EXCEPTION 'double room price must be greater than pricier single room price';
	END IF;
END;
END IF;
RETURN NEW;
END;
$check_room_trigger2$ LANGUAGE plpgsql;

CREATE TRIGGER check_room_trigger2
BEFORE INSERT ON Room 
FOR EACH ROW EXECUTE PROCEDURE check_room();

-- Pour vérifier que la fonction est correcte, comptez le nombre de tuples: 
select * from Hotel;
