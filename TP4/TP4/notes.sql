--commencer une transaction:

begin transaction isolation level serializable; -- commencer une transaction dans le mode sérializable pour éviter les problèmes de concurrence.

\set AUTOCOMMIT {ON|OFF} -- pas de point virgule ici.
\echo :AUTOCOMMIT -- pour verifier état

--On ne met pas de ; lorsqu'on fait une commande \foo

--Ne pas oublier de se connecter à la bonne base de données avant de commencer. attention C'est case sensitive
