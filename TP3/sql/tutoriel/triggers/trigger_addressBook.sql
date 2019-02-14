DROP TABLE IF EXISTS addressbook CASCADE;
DROP TABLE IF EXISTS phonebook CASCADE;

CREATE TABLE addressbook (
id SERIAL Primary Key,
name VARCHAR(10),
address VARCHAR (20),
phoneNum VARCHAR);


CREATE TABLE phonebook (
id SERIAL Primary Key,
name VARCHAR(10),
phoneNum VARCHAR);



CREATE OR REPLACE FUNCTION add_to_phonebook() RETURNS TRIGGER AS $phonebook$
DECLARE
	new_name varchar;
	new_phonenum varchar;
BEGIN
	IF (TG_OP='INSERT') THEN
		INSERT INTO phonebook(name,phonenum) VALUES(NEW.NAME, NEW.phonenum);
	END IF;
RETURN NEW;
END
$phonebook$ LANGUAGE plpgsql;


--- Création du trigger
CREATE TRIGGER phonebook
AFTER INSERT ON addressbook
FOR EACH ROW EXECUTE PROCEDURE add_to_phonebook();


-- Test du trigger
insert into addressbook(name, address, phoneNum) VALUES ('AZ','rue des 100 soucis', '613-9696363');

select * from phonebook;

-- Insertion de données pour test
INSERT INTO phonebook(name, phonenum) VALUES ('Alassane', '514-222-3333');

