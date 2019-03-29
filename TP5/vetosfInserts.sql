SET search_path = vetoSansFrontiere;

INSERT INTO clinic VALUES (
'c000001',
'514-323-2223',
'514-231-5058',
'1409 Duke Street',
'Montreal',
'QUEBEC',
'H3C 5K4'
);

INSERT INTO clinic VALUES (
'c000002',
'506-471-4228',
'506-471-4232',
'1850 Ross Terrasse',
'Fredericton',
'New Brunswick',
'E3B 5W5'
);

INSERT INTO clinic VALUES (
'c000003',
'418-454-9029',
'418-454-9052',
'2104 rue Garneau',
'Quebec',
'QUEBEC',
'G1V 3V5'
);

-- ############# Owner ################

INSERT INTO owner VALUES (
'o000000001',
'c000001',
'Eric A',
'Hitchcock',
'514-586-8787',
'1072 René-Lévesque Blvd',
'Montreal',
'QUEBEC',
'H3B 4W8'
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

INSERT INTO owner VALUES (
'o000000002',
'c000001',
'Christal W',
'Peterson',
'514-583-5227',
'4650 René-Lévesque Blvd',
'Montreal',
'QUEBEC',
'H4S 4W8'
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

INSERT INTO owner VALUES (
'o000000003',
'c000001',
'Antoinette',
'Ramirez',
'514-512-7965',
'3812 Sherbrooke Ouest',
'Montreal',
'QUEBEC',
'H4A 1H3'
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


INSERT INTO owner VALUES (
'o000000001',
'c000002',
'Lillian',
'Kidwell',
'506-471-2521',
'3292 Ross Terrasse',
'Fredericton',
'New Brunswick',
'E3B 5W5'
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

INSERT INTO owner VALUES (
'o000000002',
'c000002',
'Fred',
'Hill',
'506-471-6953',
'745 Palmer St',
'Fredericton',
'New Brunswick',
'E3B 3V2'
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

INSERT INTO owner VALUES (
'o000000001',
'c000003',
'Annie',
'Mayrand',
'418-681-3992',
'4012 Saskatchewan Dr',
'Quebec',
'QUEBEC',
'G1N 2W9'
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
