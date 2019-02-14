---- MOVIE EXAMPLE --------------------------------------------------

DROP TABLE IF EXISTS Films CASCADE;

CREATE TABLE films (
id SERIAL primary key,
title VARCHAR(50),
classification VARCHAR(2),
kind VARCHAR(10)
);

INSERT INTO Films (title, classification, kind) VALUES ('Autant en emporte le vent', 'U', 'drama');
INSERT INTO Films (title, classification, kind) VALUES ('Com1', 'U', 'comedy');
INSERT INTO Films (title, classification, kind) VALUES ('Com2', 'PG', 'comedy');

-- Création de la vue Comedy
-- A COMPLETER


---- Toutes les insertions fonctionnent même la deuxième qui ne respecte pas la définition de la vue!
INSERT INTO comedies (title, classification, kind) VALUES ('test1', 'U', 'comedy');   
INSERT INTO comedies (title, classification, kind) VALUES ('test2', 'U', 'Drame');   

-- Création de la vue universal_comedies
-- A COMPLETER


-- TEST DE LA VUE
--- AUCUN CHECK  - TOUTES LES INSERTIONS FONCTIONNENT - 
INSERT INTO universal_comedies (title, classification, kind) VALUES ('test1', 'U', 'comedy');   
INSERT INTO universal_comedies (title, classification, kind) VALUES ('test1', 'U', 'drama');
INSERT INTO universal_comedies (title, classification, kind) VALUES ('test1', 'PG', 'comedy');

--- Local Check Option: Ici, si on insère un tuple dans la vue, on ne rejettera que les lignes qui ne correspondent pas à une 
---- classification U sans vérifier si le type est bien une comédie

DROP VIEW IF EXISTS universal_comedies  CASCADE;

-- Création de la vue universal_comedies avec LOCAL CHECK OPTION
-- A COMPLETER

-- TEST DE LA VUE
--- Seule cette troisième insertion échoue à cause du LOCAL

INSERT INTO universal_comedies (title, classification, kind) VALUES ('test1', 'U', 'comedy');
    
INSERT INTO universal_comedies (title, classification, kind) VALUES ('test1', 'U', 'drama');

INSERT INTO universal_comedies (title, classification, kind) VALUES ('test1', 'PG', 'comedy');


DROP VIEW IF EXISTS pg_comedies  CASCADE;


-- Création de la vue pg_comedies avec  CASCADED CHECK OPTION
-- A COMPLETER

-- TEST DE LA VUE
--- Les deux premières insertions échouent
INSERT INTO pg_comedies (title, classification, kind) VALUES ('test1', 'U', 'comedy');
    
INSERT INTO pg_comedies (title, classification, kind) VALUES ('test1', 'U', 'drama');
    
INSERT INTO pg_comedies (title, classification, kind) VALUES ('test1', 'PG', 'comedy');
