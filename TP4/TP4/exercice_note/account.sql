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
\set AUTCOMMIT off
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
WHERE acctID = 101; -- Transaction attend que A finisse


-- TRANSACTION A
SELECT acctID, balance FROM Accounts WHERE acctID = 101;
COMMIT;


-- TRANSACTION B
SELECT acctID, balance FROM Accounts WHERE acctID = 101;
COMMIT;

-- Q1a.
/*
    Ici le problème c'est que la transaction A est complètement ignorée et seule la valeur de la transaction B est prise en compte à la fin: La transaction A retire 200 dollars du compte et la transaction b retire 500 dollars. On s'attendrait donc que le résultat final soit une réduction de 700. Mais on voit qu'on a juste le retrait de 500 de la transaction B dans l'état final. Ceci est du au fait que la mise à jour de la transaction B s'est faite sur la valeur lue précédemment par la transaction B. Donc lorsque la transaction A écrit sur la table, la valeur se fait effacer par la tranasaction B.
*/
 
  -- Q1b.
 /*
    On doit verrouiller la table à la ligne qui sera modifiée. On peut utiliser un lock table ou, mieux, select ....... for update;
 */
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;


--------------------------------------
UPDATE Accounts                                         
SET balance = 1000 WHERE acctID = 101;
commit;
--------------------------------------

--- Q1 b

-- TRANSACTION A
\set AUTOCOMMIt off
begin transaction isolation level READ COMMITTED;
SELECT balance -200 as bal
into balancea
FROM Accounts WHERE acctID = 101 FOR UPDATE;
SELECT bal FROM balancea;


-- TRANSACTION B
\set AUTCOMMIT off
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance - 500 as bal into balanceb
FROM Accounts WHERE acctID = 101 FOR UPDATE;
SELECT bal from balanceb;


-- TRANSACTION A
UPDATE Accounts
SET balance = (select bal from balancea)
WHERE acctID = 101;


-- TRANSACTION B
UPDATE Accounts
SET balance = (select bal from balanceb)
WHERE acctID = 101; -- Transaction attend que A finisse


-- TRANSACTION A
SELECT acctID, balance FROM Accounts WHERE acctID = 101;
COMMIT;


-- TRANSACTION B
SELECT acctID, balance FROM Accounts WHERE acctID = 101;
COMMIT;


--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;

---------------------############----------------------------
/*
    Q2
*/
--ISOLATION LEVEL REPEATABLE READ;
-- TRANSACTION A
\set AUTCOMMIT off
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
SELECT * FROM Accounts
WHERE balance > 500;


-- TRANSACTION B
\set AUTCOMMIT off
BEGIN;
UPDATE Accounts 
SET balance = balance - 500
WHERE acctID = 101;

UPDATE Accounts
SET balance = balance + 500
WHERE acctID = 202;

SELECT * FROM Accounts;
COMMIT;

-- TRANSACTION A
SELECT * FROM Accounts
WHERE balance > 500;
COMMIT;


-- Q2.a
 
 /*
    Quand la tranaction A utilise l'isolation READ COMMITTED, si la transaction B fait un commit la transaction A a des résultats différent lorsque la même commande de lecture est utilisée avant et après le commit. En effet: le deuxième SELECT utilise la nouvelle valeur des montants dans les comptes.
 */


-- Transaction A


-- Transaction B


-- Transaction A

-- Q2.b
/*
    Avec Repeatable READ par contre, lorsque la transaction B fait un commit, la transaction A utilise encore les anciennes valeurs de Accounts: celle qui ont été validées avant le début de la transaction A.
*/

--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;


---------------#####################################----------------

--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;

-- Transaction A
\set AUTCOMMIT off
BEGIN;
SET TRANSACTION
ISOLATION LEVEL REPEATABLE READ READ ONLY;

-- Transaction B
\set AUTCOMMIT off
BEGIN;
INSERT INTO Accounts(acctID, balance)
VALUES (301,3000);

-- Transaction A
SELECT * FROM Accounts
WHERE balance > 1000;

-- Transaction B
INSERT INTO Accounts (acctID, balance) 
VALUES (302,3000);

-- Transaction A
SELECT * FROM Accounts
WHERE balance > 1000;
COMMIT;

/* 
    Q2.c
    Similairement lorsqu'on utilise l'isolation Repeatable READ en mode Lecture seule, La transaction A voit les valeurs de la table qui ont été validée avant que la transaction commence. Donc quand la transaction B valide sa transaction, ceci est toujours invisible à la tranaction A. Le mode read only n'affecte que la transaction A, l'empéchant de modifier les tables. La tranaction B peut encore changer les données des tables.
*/

/*
    Q3.
*/
-- Q4- Deadlock

--- Transaction A
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance - 500 as bal into balancebb From accounts where acctID=202 FOR UPDATE;

-- Transaction B
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance - 500 as bal into balanceaa From accounts where acctID=302 FOR UPDATE;

--- Transaction A
UPDATE Accounts SET balance = (SELECT bal FROM balancebb) WHERE acctID=302;

-- Transaction B
UPDATE Accounts SET balance = (SELECT balance FROM balanceaa) WHERE acctID=202;

-- INTERBLOCAGE DÉTECTÉ
