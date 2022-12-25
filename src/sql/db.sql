DROP TABLE IF EXISTS RECINTO, ANIMAL, FUNCIONARIO, EXCURSAO,
PARTICIPANTE, VISITA, TRABALHA_EM, TELEFONE_FUNC, INSTALACAO;

CREATE TABLE RECINTO
(
  CodRec    INT PRIMARY KEY AUTO_INCREMENT,
  Nome      VARCHAR(64) DEFAULT NULL,
  Tamanho   FLOAT NOT NULL,
  DataCons  DATE NOT NULL
) DEFAULT CHARSET=latin1;

INSERT INTO RECINTO(Nome,Tamanho,DataCons)
VALUES
('Tapada do Lince-ibérico',32.0,'2014-05-06'),
('Templo dos Primatas',96.0,'2013-02-21'),
('Vale dos Tigres',84.0,'2003-05-08'),
('Quintinha do Lidl',45.0,'2009-03-02'),
(NULL,45.0,'2019-11-01'),
('Savana MEO',100.0,'2006-09-02'),
('Vale das Garças',70.0,'2021-07-12');

CREATE TABLE ANIMAL
(  
  CodAnimal INT PRIMARY KEY AUTO_INCREMENT,
  Nome      VARCHAR(16) DEFAULT NULL,
  Especie   VARCHAR(32) NOT NULL,
  Peso      FLOAT NOT NULL,
  Sexo      ENUM('M', 'F') NOT NULL,
  DataAdmis DATE NOT NULL,
  DataNasc  DATE NOT NULL,
  HabHumor  ENUM('MANSO', 'TEMPERADO', 'AGRESSIVO') NOT NULL,
  HabAtiv   ENUM('ATIVO', 'INATIVO', 'HIPERATIVO') NOT NULL,
  ComidaFav VARCHAR(16) DEFAULT NULL,
  CodRec    INT NOT NULL,
  FOREIGN KEY(CodRec) REFERENCES RECINTO(CodRec)
) DEFAULT CHARSET=latin1;

INSERT INTO ANIMAL(Nome,Especie,Peso,Sexo,DataAdmis,DataNasc,HabHumor,HabAtiv,ComidaFav,CodRec)
VALUES
('Gamma','Lince-ibérico',10.0,'F','2014-12-02','2013-09-12','MANSO','ATIVO','COELHO-BRAVO',1),
('Azahar','Lince-ibérico',14.0,'M','2014-12-02','2013-09-12','AGRESSIVO','ATIVO','AVES',1),
(NULL,'Chimpanzé',50.0,'M','2013-05-20','2013-05-20','TEMPERADO','INATIVO','BANANA',2),
('Pumpkin','Chimpanzé',45.0,'F','2013-05-20','2013-04-15','AGRESSIVO','ATIVO','BANANA',2),
('Sidney','Gorila',180.8,'M','2015-07-23','2014-08-12','TEMPERADO','HIPERATIVO','AIPO',2),
('Chu','Gorila',85.0,'F','2015-07-23','2015-07-23','MANSO','ATIVO','BROTO',2),
(NULL,'Orangotango',50.0,'F','2015-03-25','2013-05-16','AGRESSIVO','ATIVO','CASCA DE ÁRVORE',2),
('Tantan','Tigre-da-sibéria',205.7,'M','2006-07-15','2006-07-15','TEMPERADO','ATIVO','JAVALIS',3),
('Natália','Tigre-da-sibéria',125.5,'F','2012-07-08','2009-05-23','AGRESSIVO','HIPERATIVO','CERVOS',3),
('Sigli','Tigre-de-sumatra',91.8,'F','2004-04-21','2002-07-09','MANSO','INATIVO','PORCO-SELVAGEM',3),
(NULL,'Tigres-de-sumatra',123.7,'M','2006-02-01','2005-04-30','AGRESSIVO','ATIVO','CERVO',3),
('Azeitona','Burro',200.0,'F','2015-07-23','2013-08-09','MANSO','HIPERATIVO','FENO',4),
('Amora','Cabra-anã',33.4,'F','2010-09-23','2010-09-23','TEMPERADO','INATIVO','CENOURA',4),
('Sr.Cenoura','Coelho-bravo',3.5,'M','2013-09-08','2002-08-09','AGRESSIVO','INATIVO',NULL,4),
('Dourada','Galinha-sussex',3.2,'F','2020-07-07','2020-07-07','TEMPERADO','HIPERATIVO','MILHO',4),
('Algodão','Ovelha',30.9,'M','2014-04-03','2014-04-03','MANSO','ATIVO',NULL,4),
('Recruta','Pinguim-rei', 12.3,'M','2020-05-06','2020-05-06','TEMPERADO','INATIVO',NULL,5),
(NULL,'Golfinho-roaz',303.3,'M','2021-03-21','2021-02-28','MANSO','HIPERATIVO','LULA',5),
('Troia','Elefante-africano-de-savana',7000.0,'M','2006-09-08','2005-04-07','MANSO','ATIVO','BAMBU',6),
(NULL,'Girafa-de-angola',1002.1,'F','2012-12-05','2012-12-05','TEMPERADO','INATIVO','PLANTA DE ACACIA',6),
('Lili','Niala',100.2,'F','2020-08-05','2020-08-05','MANSO','HIPERATIVO',NULL,6),
('Glória','Hipopótamo',4500.0,'F','2015-05-07','2013-02-02','AGRESSIVO','ATIVO', NULL,6);

CREATE TABLE FUNCIONARIO
(
  CodFunc    INT PRIMARY KEY AUTO_INCREMENT,
  Nome       VARCHAR(32) NOT NULL,
  Sexo       ENUM('M', 'F') NOT NULL,
  Email      VARCHAR(64) NOT NULL,
  Orientador INT DEFAULT NULL,
  FOREIGN KEY(Orientador) REFERENCES FUNCIONARIO(CodFunc) ON DELETE SET NULL
) DEFAULT CHARSET=latin1;

INSERT INTO FUNCIONARIO(Nome,Sexo,Email,Orientador)
VALUES
('João Pedro', 'M', 'joaopedro@gmail.com', NULL),
('Alfonso Vargas', 'M', 'alvargas@outlook.com', 1),
('Maria Das Rosas', 'F', 'rosasvermelhas@proton.com', NULL),
('Louro Silva', 'M', 'louropaz@ceo.com', NULL),
('Gus Negro', 'M', 'bandodofalcao@gmail.com', NULL),
('Casca Kanji', 'F', 'kanjicas@yahoo.com', 5),
('Pietra Savi', 'F', 'piesavi@hotmail.com', NULL),
('Maria Eduarda', 'F', 'dudamaria@gmail.com', 3),
('Alex Fernandes', 'M', 'alefer@gmail.com', NULL),
('Raul Dias', 'M', 'raulol@outlook.com', 9),
('Nuno Almeida', 'M', 'nunoalm@proton.com', NULL),
('Sara Bando', 'F', 'sbando@outlook.com', NULL);

CREATE TABLE EXCURSAO
(
  CodExc   INT PRIMARY KEY AUTO_INCREMENT,
  Data     DATE NOT NULL,
  FuncGuia INT DEFAULT NULL,
  FOREIGN KEY(FuncGuia) REFERENCES FUNCIONARIO(CodFunc) ON DELETE SET NULL
) DEFAULT CHARSET=latin1;

INSERT INTO EXCURSAO(Data,FuncGuia)
VALUES
('2019-10-11', 2),
('2020-04-26', 5),
('2021-10-06', 9),
('2022-01-29', 11);

CREATE TABLE PARTICIPANTE
(
  Num       INT PRIMARY KEY AUTO_INCREMENT,
  CodExc    INT NOT NULL,
  Nome      VARCHAR(32) NOT NULL,
  Idade     INT NOT NULL,
  TelRespon INT DEFAULT NULL,
  FOREIGN KEY(CodExc) REFERENCES EXCURSAO(CodExc) ON DELETE CASCADE
) DEFAULT CHARSET=latin1;

INSERT INTO PARTICIPANTE(CodExc,Nome,Idade,TelRespon)
VALUES
(1, 'Vinicius Marcon', 22, NULL),
(1, 'Olívio Marcon', 04, 933789231),
(4, 'Pedro Vasconcelos', 55, NULL),
(4, 'Pedro Ribeiro', 43, NULL),
(4, 'Amanda Ribeiro', 14, 917745742),
(2, 'Isabela Carneiro', 18, NULL),
(2, 'Rodrigo Corceti', 21, NULL),
(1, 'Marcela Peretto', 46, NULL),
(1, 'José Peretto', 48, NULL),
(1, 'Lucas Peretto', 15, 982147756),
(2, 'Bruna Lopes', 17, 940236788),
(2, 'Mateus Pereira', 16, 938167292),
(4, 'Jorge Peixoto', 31, NULL),
(2, 'Caio Martins', 19, NULL),
(3, 'Renzo Alabre', 06, 942133764),
(3, 'Rafaela Proza', 06, 921188983),
(3, 'Vitor Toledo', 07, 923247633),
(3, 'Brenda Alexandra', 06, 945246572),
(3, 'Enzo Pardil',08, 932887921),
(3, 'Taisa Peixoto', 07, 913325487),
(2, 'Gabriel Jesus', 22, NULL),
(4, 'Zé Mariqueiro', 37, NULL),
(4, 'Maria Joaquina', 42, NULL),
(4, 'Cirilo Pescador', 40, NULL);

CREATE TABLE VISITA
(
  CodExc  INT NOT NULL,
  CodRec  INT NOT NULL,
  Horario TIME NOT NULL,
  PRIMARY KEY(CodExc, CodRec),
  FOREIGN KEY(CodExc) REFERENCES EXCURSAO(CodExc) ON DELETE CASCADE,
  FOREIGN KEY(CodRec) REFERENCES RECINTO(CodRec) ON DELETE CASCADE
) DEFAULT CHARSET=latin1;

INSERT INTO VISITA(CodExc, CodRec, Horario)
VALUES
(1, 1, '09:00:00'),
(1, 3, '09:20:00'),
(1, 2, '09:40:00'),
(1, 4, '10:00:00'),
(2, 3, '13:20:00'),
(2, 5, '13:35:00'),
(2, 2, '13:50:00'),
(2, 4, '14:00:00'),
(2, 6, '14:20:00'),
(3, 1, '10:15:00'),
(3, 3, '10:45:00'),
(3, 5, '11:10:00'),
(4, 1, '15:30:00'),
(4, 5, '15:45:00'),
(4, 3, '16:00:00'),
(4, 4, '16:10:00'),
(4, 6, '16:30:00'),
(4, 2, '16:40:00');

CREATE TABLE TRABALHA_EM
(
  CodFunc INT NOT NULL,
  CodRec  INT NOT NULL,
  PRIMARY KEY(CodRec, CodFunc),
  FOREIGN KEY(CodFunc) REFERENCES FUNCIONARIO(CodFunc) ON DELETE CASCADE,
  FOREIGN KEY(CodRec) REFERENCES RECINTO(CodRec) ON DELETE CASCADE
) DEFAULT CHARSET=latin1;

INSERT INTO TRABALHA_EM(CodFunc,CodRec)
VALUES
(1, 1),
(1, 2),
(2, 6),
(2, 5),
(2, 4),
(3, 3),
(4, 3),
(4, 1),
(5, 2),
(6, 2),
(6, 4),
(6, 5),
(7, 5),
(7, 6),
(8, 4),
(9, 1),
(9, 2),
(9, 5),
(10, 3),
(10, 6);

CREATE TABLE TELEFONE_FUNC
(
  NumTel  INT NOT NULL,
  CodFunc INT NOT NULL,
  PRIMARY KEY(NumTel, CodFunc),
  FOREIGN KEY(CodFunc) REFERENCES FUNCIONARIO(CodFunc) ON DELETE CASCADE
) DEFAULT CHARSET=latin1;

INSERT INTO TELEFONE_FUNC(NumTel, CodFunc)
VALUES
(932884321, 1),
(912342556, 2),
(958446520, 3),
(935844652, 4),
(933869652, 4),
(940283436, 5),
(922843211, 6),
(929532036, 7),
(929887336, 7),
(978775788, 8),
(978819788, 9),
(963752023, 10),
(987569027, 11),
(958372569, 11),
(925697471, 12);

CREATE TABLE INSTALACAO
(
  Instalacao VARCHAR(64) NOT NULL,
  CodRec     INT NOT NULL,
  PRIMARY KEY(Instalacao, CodRec),
  FOREIGN KEY(CodRec) REFERENCES RECINTO(CodRec) ON DELETE CASCADE
) DEFAULT CHARSET=latin1;

INSERT INTO INSTALACAO(CodRec,InstalaCao)
VALUES
(2,'Comedouro'),
(4,'Comedouro'),
(6,'Comedouro'),
(6,'Lago'),
(5,'Unidade de Refrigeração'),
(5,'Piscina'),
(4,'Horta'),
(3,'Lago'),
(2,'Plataformas elevadas'),
(2,'Árvores'),
(1,'Árvores'),
(3,'Árvores'),
(6,'Árvores'),
(4,'Bebedouro'),
(2,'Bebedouro'),
(3,'Ponte'),
(3,'Plataformas elevadas'),
(1,'Plataformas elevadas'),
(1,'Esconderijo');
