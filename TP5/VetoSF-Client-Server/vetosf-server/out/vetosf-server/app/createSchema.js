"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.schema = `
SET search_path = hotelDB;

DROP SCHEMA IF EXISTS HOTELDB CASCADE;
CREATE SCHEMA HOTELDB;

CREATE TABLE IF NOT EXISTS  HOTELDB.Hotel (
		hotelNo		VARCHAR(10)		NOT NULL,
		hotelName 	VARCHAR(20)		NOT NULL,
		city		VARCHAR(50)		NOT NULL,
		PRIMARY KEY (hotelNo));

CREATE TABLE IF NOT EXISTS HOTELDB.Room(
roomNo VARCHAR(10) NOT NULL,
hotelNo VARCHAR(10)	NOT NULL,
typeroom VARCHAR(10)	NOT NULL,
price NUMERIC(6,3) NOT NULL,
PRIMARY KEY (roomNo, hotelNo),
FOREIGN KEY(hotelNo) REFERENCES HOTELDB.Hotel(hotelNo) ON DELETE RESTRICT ON UPDATE CASCADE);


CREATE DOMAIN HOTELDB.sexType AS CHAR
	CHECK (VALUE IN ('M', 'F'));

CREATE TABLE IF NOT EXISTS HOTELDB.Guest(
guestNo		VARCHAR(10)		NOT NULL,
nas		VARCHAR(10)		UNIQUE NOT NULL,
guestName 	VARCHAR(20)		NOT NULL,
gender		sexType			DEFAULT 'M',
guestCity	VARCHAR(50)		NOT NULL,
PRIMARY KEY (guestNo));

CREATE TABLE IF NOT EXISTS HOTELDB.Booking(
		hotelNo		VARCHAR(10)		NOT NULL,
		guestNo	  	VARCHAR(10)		NOT NULL,
		dateFrom 	DATE			NOT NULL,
		dateTo		DATE			NULL,
		roomNo		VARCHAR(10)		NOT NULL,
		PRIMARY KEY (hotelNo, guestNo, roomNO, dateFrom),
		FOREIGN KEY (guestNo) REFERENCES HOTELDB.Guest(guestNo)
		ON DELETE SET NULL ON UPDATE CASCADE,
		FOREIGN KEY (hotelNo, roomNo) REFERENCES HOTELDB.Room (hotelNo, roomNo)
		ON DELETE NO ACTION ON UPDATE CASCADE,
		CONSTRAINT date CHECK (dateTo >= dateFrom),
		CONSTRAINT dateFrom CHECK (dateFrom >= current_date));

ALTER TABLE HOTELDB.Guest ALTER gender DROP DEFAULT;
`;
//# sourceMappingURL=createSchema.js.map