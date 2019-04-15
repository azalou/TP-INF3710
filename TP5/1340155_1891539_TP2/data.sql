SET search_path = vetoSansFrontiere;


-- ############# Clinic ################
INSERT INTO Clinic VALUES (
'c000001',
'514-323-2223',
'514-231-5058',
'1409 Duke Street',
'Montreal',
'QC',
'H3C 5K4'
);

INSERT INTO Clinic VALUES (
'c000002',
'506-471-4228',
'506-471-4232',
'1850 Ross Terrasse',
'Fredericton',
'NB',
'E3B 5W5'
);

INSERT INTO Clinic VALUES (
'c000003',
'418-454-9029',
'418-454-9052',
'2104 rue Garneau',
'Quebec',
'QC',
'G1V 3V5'
);

-- ############# Employe ################
INSERT INTO Employe VALUES (
'emp000001',
'c000001',
'124-234-345',
'Zidou',
'Mitchcock',
'514-586-3387',
'1963-10-07',
'M',
'Manager',
3000,
'1072 René-Lévesque Blvd\nMontreal QC H3B 4W8'
);

INSERT INTO Employe VALUES (
'emp000002',
'c000001',
'127-234-345',
'Jean',
'Tremblay',
'514-589-3387',
'1964-10-07',
'M',
'veterinaire',
2000,
'1067 René-Lévesque Blvd\nMontreal QC H3B 4W8'
);

INSERT INTO Employe VALUES (
'emp000003',
'c000002',
'124-678-345',
'bidou',
'Mitchlook',
'514-586-3345',
'1963-10-10',
'M',
'Manager',
3000,
'4472 René-Lévesque Blvd\nMontreal QC H3B 4W8'
);

INSERT INTO Employe VALUES (
'emp000004',
'c000002',
'127-234-000',
'Miyuou',
'Zitrwegchcock',
'438-589-3387',
'1965-10-07',
'M',
'veterinaire',
2000,
'1072 René-Lévesque Blvd\nMontreal QC H3B 4W8'
);

INSERT INTO Employe VALUES (
'emp000005',
'c000003',
'124-999-245',
'bidosggdgu',
'Mitchggglook',
'514-526-3345',
'1963-10-10',
'F',
'Manager',
3000,
'4472 René-Lévesque Blvd\nMontreal QC H3B 4W8'
);

INSERT INTO Employe VALUES (
'emp000006',
'c000003',
'127-777-000',
'Miyuou',
'Zitrwegchcock',
'438-587-3387',
'1965-10-07',
'M',
'veterinaire',
2000,
'1072 René-Lévesque Blvd\nMontreal QC H3B 4W8'
);	
	
-- ############# Owner--Pet ################

-- owner
INSERT INTO owner VALUES (
'o000000001',
'c000001',
'Eric A Hitchblay',
'514-586-8787',
'1072 René-Lévesque Blvd\nMontreal QC H3B 4W8',
'1995-10-07'
);
-- Pet
INSERT INTO pet VALUES (
'o000000001',
'c000001',
1,
'Petulis',
'cat',
'yellow stripes and red paws',
DATE'2010-02-23',
'Alive'
);
INSERT INTO pet VALUES (
'o000000001',
'c000001',
2,
'Omaha',
'dog',
'magenta and fushia',
DATE'2007-12-23',
'Alive'
);
INSERT INTO pet VALUES (
'o000000001',
'c000001',
3,
'Petulis',
'cat',
'yellow stripes and red paws',
DATE'2002-05-07',
'Dead'
);

-- owner
INSERT INTO owner VALUES (
'o000000002',
'c000001',
'Christal W Peteblay',
'514-583-5227',
'4650 René-Lévesque Blvd\nMontreal QC H4S 4W8',
'1996-10-07'
);
-- Pet
INSERT INTO pet VALUES (
'o000000002',
'c000001',
1,
'Losoie',
'flamingo',
'amputated beak',
DATE'2018-01-31',
'Alive'
);

-- owner
INSERT INTO owner VALUES (
'o000000003',
'c000001',
'Antoinette Ramirez',
'514-512-7965',
'3812 Sherbrooke Ouest\n Montreal QC H4A 1H3',
'1995-10-08'
);
-- Pet
INSERT INTO pet VALUES (
'o000000003',
'c000001',
1,
'Cledor',
'dog',
'chiwawa',
DATE'2017-10-24',
'Alive'
);

-- owner
INSERT INTO owner VALUES (
'o000000001',
'c000002',
'Lillian Kidwell',
'506-471-2521',
'3292 Ross Terrasse\nFredericton NB E3B 5W5',
'1995-11-07'
);
-- Pet
INSERT INTO pet VALUES (
'o000000001',
'c000002',
1,
'Aris',
'dog',
'missing rear leg',
DATE'2013-05-14',
'Alive'
);

-- owner
INSERT INTO owner VALUES (
'o000000002',
'c000002',
'Fred Hill',
'506-471-6953',
'745 Palmer St\nFredericton NB 3B 3V2',
'1995-10-07'
);
-- Pet
INSERT INTO pet VALUES (
'o000000002',
'c000002',
1,
'M. Goldo',
'aligator',
'why an aligator..',
DATE'2013-05-14',
'Alive'
);

-- owner
INSERT INTO owner VALUES (
'o000000001',
'c000003',
'Annie Mayrand',
'418-681-3992',
'4012 Saskatchewan Dr\nQuebec QC G1N 2W9',
'1995-10-07'
);
-- Pet
INSERT INTO pet VALUES (
'o000000001',
'c000003',
1,
'D. Emperor',
'lion',
'very big cat. immortal',
DATE'1035-06-03',
'Alive'
);

-- ############# Examen ################

INSERT INTO Exam VALUES (
'emp000002',
'o000000001',
'c000001',
2,
'exa000002',
'2018-03-30',
'08:00:00',
'La situation nest pas grave.'
);

INSERT INTO Exam VALUES (
'emp000002',
'o000000001',
'c000001',
2,
'exa000003',
'2018-03-30',
'08:00:00',
'La situation nest pas grave.'
);

INSERT INTO Exam VALUES (
'emp000004',
'o000000001',
'c000002',
1,
'exa000004',
'2016-03-30',
'08:00:00',
'La situation n est pas grave.'
);		

-- ############# Treatment ################

INSERT INTO Treatment VALUES (
'tre000001',
'Soignes',
200,
'exa000002',
3,
'1963-10-07',
'2019-03-30'
);

INSERT INTO Treatment VALUES (
'tre000002',
'Soignes',
200,
'exa000002',
3,
'1963-10-07',
'2019-03-30'
);

INSERT INTO Treatment VALUES (
'tre000003',
'Soignes ',
200,
'exa000004',
3,
'2019-03-30',
'2019-03-30'
);		
		

