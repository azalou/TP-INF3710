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
    Ici, le problème est que la transaction A est complètement ignorée. Seule la valeur de la transaction B est prise en compte à la fin. En effet, la transaction A retire 200$ du compte et la transaction b retire 500$. On s'attendrait donc que le résultat final soit une réduction de 700$ du compte. 
    Mais on voit qu'on a juste le retrait de 500 de la transaction B dans l'état final. Ceci est dû au fait que la mise à jour du compte par la transaction B s'est faite sur la valeur lue précédemment par la transaction B. Une valeur qui avait été lue avant que la transaction A n'ait validé sa transaction. Ainsi, lorsque la transaction A écrit sur la table et valide, cette valeur se fait écraser par la transaction B.
*/
 
  -- Q1b.
 /*
    On doit verrouiller la table à la ligne qui sera modifiée. On peut utiliser un lock table ou, mieux, select ....... for update;
    18662124318
 */
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;
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
SELECT bal from balanceb;  -- Transaction attend que A finisse avec le tuple


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

-- Q2.a
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

 
 /*
    Quand la tranaction A utilise l'isolation READ COMMITTED, si la transaction B fait un commit pendant que A est encore en cours, la transaction A lit des valeurs différentes lorsqu’elle fait des SELECT sur les tuples que B écrit et valide. En effet: le deuxième SELECT utilise la nouvelle valeur des montants dans les comptes comme écrit par B. 
 */

-- Q2.b
--  data
DROP TABLE if EXISTS balancea CASCADE;
DROP TABLE if EXISTS balanceb CASCADE;
DELETE FROM Accounts;
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
SELECT * FROM Accounts;
/*
    Avec Repeatable READ par contre, lorsque la transaction B fait un commit, la transaction A utilise encore les anciennes valeurs de Accounts: celle qui ont été validées avant le début de la transaction A.
*/
\set AUTCOMMIT off
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
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



/* 
    Q2.c
    Similairement lorsqu'on utilise l'isolation Repeatable READ en mode Lecture seule, La transaction A voit les valeurs de la table qui ont été validée avant que la transaction commence. Donc quand la transaction B valide sa transaction, ceci est toujours invisible à la tranaction A. Le mode read only n'affecte que la transaction A, l'empéchant de modifier les tables. La tranaction B peut encore changer les données des tables.
*/

/*
    Q3. Deadlock
*/
-- Transaction A
\set AUTCOMMIT off
BEGIN;
INSERT INTO Accounts(acctID, balance)
VALUES (301,3000);
INSERT INTO Accounts (acctID, balance) 
VALUES (302,3000);
COMMIT;

--- Transaction B
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance - 500 as bal into balanceb 
FROM accounts WHERE acctID=202 FOR UPDATE;

-- Transaction A
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT balance - 500 as bal into balancea 
FROM accounts WHERE acctID=302 FOR UPDATE;

--- Transaction B
UPDATE Accounts 
SET balance = (SELECT bal FROM balanceb) 
WHERE acctID=302;

-- Transaction A
UPDATE Accounts 
SET balance = (SELECT balance FROM balancea) 
WHERE acctID=202;

-- INTERBLOCAGE DÉTECTÉ
