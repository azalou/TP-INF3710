-- Connectez-vous à une fenêtre psql.
-- Créez une base de données TP4

CREATE DATABASE tp4;
\c tp4;

-- connectez-vous à la base de données TP4
\c tp4;

-- Executez:
DROP TABLE IF EXISTS Compte;

--Q1.  Exécutez les commandes suivantes dans psql 
create table Compte (username varchar(8), fullname varchar(128), balance int);
insert into Compte values ('ajones', 'Alice Jones', 82);
insert into Compte values ('sgain', 'Serge Gainsbourg', 10002);
insert into Compte values ('jbirkin', 'Jane Birkin', 5000);

---Q2. Examinez la structure de la table en utilisant la commande spéciale  \d :
\d Compte
--- Lancez les requêtes suivantes:
select username, fullname, balance from Compte;
select fullname from Compte where balance > 75;
select sum(balance) from Compte;
--Q3. Nous allons maintenant simuler des transactions concurrentes en ouvrant deux terminaux psql.  
--- Nous allons utiliser la couleur bleue et rouge pour les différencier (voir le document pdf qui accompagne le TP)
--Ecrivez une transaction dans le terminal T1 qui affiche tous les comptes. 

--Maintenant, dans le second terminal (rouge), démarrez une transaction et ajoutez un compte pour l’usager ‘Charlotte Gainsbourg’:

--Q4. Générez une liste de tous les comptes dans le terminal T2. Quelle sortie obtenez-vous ? 


---Q5. Générez une liste de tous les comptes dans le terminal 1 (bleu). Quelle sortie obtenez-vous ? inclut-elle Charlotte Gainsbourg ? Pourquoi?


---Q6. Validez la transaction dans le terminal T2 rouge et listez l’ensemble des comptes dans les deux terminaux.


--Vous voyez maintenant que les deux terminaux voient les mêmes données.
-- validez la transaction dans T1


--Q7.  Dans le terminal 1 bleu, commencez une transaction et ajoutez 5$ dans le compte de Jane Birkin. 

--Dans le second terminal rouge, commencez une transaction et enlevez 10$ du compte de Jane Birkin:

--Q8. Que se passe-t-il dans le terminal T2 rouge. Pourquoi?
--Essayons d’interrompre la transaction dans le terminal T1 (bleu) avec la commande abort
abort;
--Q9. Que se passe-t-il dans le terminal T2 rouge ?
--Q10. Valider la transaction dans le terminal T2.  Quel est le solde de Jane Birkin ? 
--Q11. Effectuons un transfert de 15$ entre Serge gainsbourg et Charlotte Gainsbourg. 



--Dans un premier temps, dans le terminal T1 bleu, listez les soldes de tous les comptes. Ensuite commencez une transaction et effectuez le retrait de 15$ dans le terminal T2 rouge. 

--Q12. Si on regarde tous les soldes dans le premier terminal bleu, est-ce que les soldes ont changé ? 
--Q13. Finissez le transfert en executant les commandes suivantes dans le terminal T2 rouge. 
-- Après chaque commande, listez l’ensembles des soldes dans le terminal T1 bleu pour voir à partir de quand les effets de la seconde transaction deviennent visibles.

--Q14. Dans chaque terminal, supprimez le mode autocommit. 

-- Créez une nouvelle transaction dans le terminal 1 en ajoutant 15$ à Charlotte Gainsbourg.

-- Effectuez maintenant la même opération dans T2. Que constatez-vous? 

-- Validez maintenant chaque transaction. Que se passe-t-il?

-- Répétez l'opération avec la commande suivante dans chaque fenêtre
begin;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
update Compte set balance=balance+15 where username='cgain';

-- Validez maintenant chaque transaction. Que se passe-t-il?
commit;
