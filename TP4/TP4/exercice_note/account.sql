SET search_path = public;
CREATE TABLE Accounts (
acctID INTEGER NOT NULL PRIMARY KEY,
balance INTEGER NOT NULL,
CONSTRAINT remains_nonnegative CHECK (balance >= 0)
);

--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;


--Q1 a
-- TRANSACTION A
\set AUTOCOMMIt off
begin transaction isolation level READ COMMITTED;
SELECT balance -200 as bal
into balancea
FROM Accounts WHERE acctID = 101;
SELECT bal FROM balancea;

-- TRANSACTION B
\set AUTCOMMIT 'off';
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance - 500 as bal into balanceb
FROM Accounts WHERE acctID = 101;
SELECT bal from balanceb;


-- TRANSACTION A
UPDATE Accounts
SET balance = (select bal from balancea)
WHERE acctID = 101;


-- TRANSACTION B
UPDATE Accounts
SET balance = (select bal from balanceb)
WHERE acctID = 101;


-- TRANSACTION A
SELECT acctID, balance FROM Accounts WHERE acctID = 101;
COMMIT;


-- TRANSACTION B
SELECT acctID, balance FROM Accounts WHERE acctID = 101;
COMMIT;

-- Q1a.
/*
    Ici le problème c'est que la transaction A est complètement ignorée et seule la valeur de la transaction B est prise en compte à la fin: La transaction A retire 200 dollars du compte et la transaction b retire 500 dollars. On s'attendrait donc que le résultat final devrait etre un retrait de 700. Mais on voit que on a juste le retrait de 500 de la transaction B.
*/

 -- Q2)b.
 
 /*
    On ob
--  datatient l'erreur suivante avec repeatable read lorsque la transaction A met à jour les données du compte:
    ERROR:  could not serialize access due to concurrent update
 */
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;

--- Q1 b

-- TRANSACTION A


-- TRANSACTION B


-- TRANSACTION A


-- TRANSACTION B


-- TRANSACTION A


-- TRANSACTION B


-- Q2-a

--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;

-- Transaction A


-- Transaction B


-- Transaction A

-- Q2-b

--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;

-- Transaction A


-- Transaction B


-- Transaction A

--- Q3 
--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;

-- Transaction A

-- Transaction B


-- Transaction A

-- Transaction B



-- Transaction A


-- Q4- Deadlock

--- Transaction A


-- Transaction B

--- Transaction A


