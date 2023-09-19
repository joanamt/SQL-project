/*NOTA: APENAS SE USOU A COMMAND LINE DO SQL PELO QUE ESTE FICHEIRO TXT APRESENTA TODAS AS 
INSTRUÇÕES USADAS NO TERMINAL.

CREATE DATABASE IF NOT EXISTS HARRYPOTTER;

USE HARRYPOTTER;*/

     

/*-- -----------------------------------------------------
               -- Table 'FEITIÇO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS FEITIÇO(
  ID INT NOT NULL,
  Tipo ENUM('Poção', 'Feitiço') NOT NULL,
  Dificuldade ENUM('Fácil', 'Médio', 'Dificil') NOT NULL,
  PRIMARY KEY (ID));


/*-- -----------------------------------------------------
                 -- Table 'NOME_DO_FEITIÇO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS NOME_DO_FEITIÇO(
  ID INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID, Nome),
  FOREIGN KEY (ID) REFERENCES FEITIÇO(ID) 
  ON UPDATE CASCADE ON DELETE CASCADE);


/*-- -----------------------------------------------------
                 --Table 'TORNEIO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS TORNEIO(
  FaseID INT NOT NULL,
  Dificuldade ENUM('Fácil', 'Médio', 'Difícil') NOT NULL,
  NumeroDeParticipantes INT NOT NULL,
  PRIMARY KEY (FaseID));

/*-- -----------------------------------------------------
                -- Table 'USA_FEITIÇO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS USA_FEITIÇO(
  IDFeitiço INT NOT NULL,
  IDTorneio INT NOT NULL,
  PRIMARY KEY (IDFeitiço,IDTorneio),
  FOREIGN KEY (IDFeitiço) REFERENCES FEITIÇO(ID) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (IDTorneio) REFERENCES TORNEIO(FaseID)
  ON UPDATE CASCADE ON DELETE CASCADE);
/*
-- -----------------------------------------------------
               -- Table 'ESCOLA'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS ESCOLA(
  ID INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Diretor VARCHAR(45) NOT NULL UNIQUE,
  Localidade VARCHAR(45) NOT NULL,
  Cidade VARCHAR(45) NOT NULL,
  País VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID));
/*
-- -----------------------------------------------------
               -- Table 'PROFESSOR'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS PROFESSOR(
  ID INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Escola VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID));
/*
-- -----------------------------------------------------
               -- Table 'CARGO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS CARGO(
  ID INT NOT NULL,
  Cargo VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID, Cargo),
  FOREIGN KEY (ID) REFERENCES PROFESSOR(ID)
  ON UPDATE CASCADE ON DELETE CASCADE);

/*- -----------------------------------------------------
             --Table 'VARINHA'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS VARINHA(
  Código BIGINT(8) NOT NULL,
  PRIMARY KEY (Código));
/*
-- -----------------------------------------------------
            --Table 'TIPO_DE_MATERIAL'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS TIPO_DE_MATERIAL(
  Código BIGINT(8) NOT NULL,
  TipoDeMaterial VARCHAR(45) NOT NULL,
  PRIMARY KEY (Código, TipoDeMaterial),
  FOREIGN KEY (Código) REFERENCES VARINHA(Código)
  ON UPDATE CASCADE ON DELETE CASCADE);
/*
-- -----------------------------------------------------
          --   Table 'ALUNO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS ALUNO(
  NumMec BIGINT(8) NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  DataNasc DATE NOT NULL,
  IDEscola INT NOT NULL,
  IDSupervisor INT NOT NULL,
  Origem ENUM('Muggle', 'Wizard') NOT NULL,
  Sexo ENUM('F', 'M'),
  Casa VARCHAR(45) NOT NULL,
  AnimalEstimação VARCHAR(45),
  IDVarinha BIGINT(8) NOT NULL,
  PRIMARY KEY (NumMec),
  FOREIGN KEY (IDEscola) REFERENCES ESCOLA(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (IDSupervisor) REFERENCES PROFESSOR(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (IDVarinha) REFERENCES VARINHA(Código)
  ON UPDATE CASCADE ON DELETE CASCADE);

/*-- -----------------------------------------------------
                 -- Table 'COMPETIÇÃO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS COMPETIÇÃO(
  IDOponente1 BIGINT(8) NOT NULL,
  IDOponente2 BIGINT(8) NOT NULL,
  PRIMARY KEY (IDOponente1,IDOponente2),
  FOREIGN KEY (IDOponente1) REFERENCES ALUNO(NumMec)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (IDOponente2) REFERENCES ALUNO(NumMec)
  ON UPDATE CASCADE ON DELETE CASCADE);
/*
-- -----------------------------------------------------
                -- Table 'PARTICIPAÇÃO'
-- -----------------------------------------------------*/
CREATE TABLE IF NOT EXISTS PARTICIPAÇÃO(
  IDAluno BIGINT(8) NOT NULL,
  IDFaseTorneio INT NOT NULL,
  PRIMARY KEY (IDAluno),
  FOREIGN KEY (IDAluno) REFERENCES ALUNO(NumMec)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (IDFaseTorneio) REFERENCES TORNEIO(FaseID)
  ON UPDATE CASCADE ON DELETE CASCADE);
/*

         --PREENCHIMENTO DE TABELAS EM SQL

-- -----------------------------------------------------
               -- Table 'FEITIÇO'
-- -----------------------------------------------------*/
INSERT INTO FEITIÇO(ID, Tipo, Dificuldade)
VALUES (1, 'Feitiço', 'Fácil'),
(2,'Feitiço','Fácil'),
(3,'Poção','Dificil'), 
(4,'Poção','Médio'),
(5,'Poção','Médio'),
(6,'Feitiço','Dificil'),
(7,'Poção','Fácil'),
(8,'Feitiço','Dificil');

/*-- -----------------------------------------------------
                 -- Table 'NOME_DO_FEITIÇO'
-- -----------------------------------------------------*/
INSERT INTO NOME_DO_FEITIÇO(ID,Nome)
VALUES (1,'Accio'),(2,'Bombarda'),
(3,'Poção da Paz'),(4,'Elixir da Vida'),
(5,'Glisseo'),(6,'Confundus'),
(7,'Confringo'),(8,'Inflatus');

/*-- -----------------------------------------------------
                 --Table 'TORNEIO'
-- -----------------------------------------------------*/
INSERT INTO TORNEIO(FaseID, Dificuldade, NumeroDeParticipantes)
VALUES (1, 'Fácil', 3),
(2,'Médio',2),
(3,'Difícil',2);

/*-- -----------------------------------------------------
                -- Table 'USA_FEITIÇO'
-- -----------------------------------------------------*/
INSERT INTO USA_FEITIÇO(IDFeitiço, IDTorneio)
VALUES (1,1),(4,3),(7,2),(2,2),(3,1),(5,1),(2,3),(8,1),(4,2),(1,3);

/*-- -----------------------------------------------------
               -- Table 'ESCOLA'
-- -----------------------------------------------------*/
INSERT INTO ESCOLA(ID,Nome,Diretor,Localidade,Cidade,País)
VALUES (123,'Hogwarts','Alvo Dumbledore','Hogwarts','Londres','Inglaterra'),
(234,'Durmstrang','Igor Karkaroff','Durmst','Arvika','Suécia'),
(567,'Beauxbatons','Olimpia Maxime','Beaux','Cannes','França');

/*-- -----------------------------------------------------
               -- Table 'PROFESSOR'
-- -----------------------------------------------------*/
INSERT INTO PROFESSOR(ID,Nome,Escola)
VALUES (12,'Rubeus Hagrid','Hogwarts'),
(13, 'Minerva McGonagall','Hogwarts'),
(23, 'Nerida Vulchanova','Durmstrang'),
(26,'Harfang Munter','Durmstrang'),
(43,'Vincent Duc','Beauxbatons'),
(46,'Luc Millefeuille','Beauxbatons');
/*
-- -----------------------------------------------------
               -- Table 'CARGO'
-- -----------------------------------------------------*/
INSERT INTO CARGO(ID,Cargo) 
VALUES (12,'Guardeão das chaves e das terras'),
(13,'Vice-diretor'),
(13,'Diretor de casa'),
(13,'Professor'),
(23,'Fundadora'),
(26,'Diretor'),
(26,'Professor'),
(43,'Professor'),
(46,'Professor');

/*-- -----------------------------------------------------
             --Table 'VARINHA'
-- -----------------------------------------------------*/
INSERT INTO VARINHA(Código)
VALUES (12345),(12346),(21036),(31234),(12348),(12349),(32134),(21078);

/* -----------------------------------------------------
            --Table 'TIPO_DE_MATERIAL'
-- -----------------------------------------------------*/
INSERT INTO TIPO_DE_MATERIAL(Código,TipoDeMaterial)
VALUES
(12345,'Phoenix Feather'),
(12346,'Unicorn Tail Hair'),
(21036,'Dragon Heartstring'),
(31234,'Veela Hair'),
(12348,'Unicorn Tail Hair'),
(12349,'Dragon Heartstring'),
(12349,'Veela Hair'),
(32134,'Dragon Heartstring'),
(21078,'Unicorn Tail Hair');


/*-- -----------------------------------------------------
             Table 'ALUNO'
-- -----------------------------------------------------*/
INSERT INTO ALUNO(NumMec,Nome,DataNasc,IDEscola,IDSupervisor,Origem,Sexo,Casa, AnimalEstimação,IDVarinha)
VALUES
(12345678,'Harry Potter', '1980-01-03',123,13,'Muggle','M','Gryffindor','Coruja',12345),
(12345679,'Cedric Diggory', '1979-10-01',123,13,'Wizard','M','Gryffindor','Coruja',12346),
(23456716,'Viktor Klum', '1979-03-21',234,26,'Wizard','M','Durmstrang',Null,21036),
(31234443,'Fleur Delacour','1978-12-13',567,43,'Muggle','F','Beauxbatons',Null,31234),
(12345673,'Ron Weasly', '1980-02-04',123,13,'Wizard','M','Gryffindor','Rato',12348),
(12345674,'Hermione Granger','1980-06-09',123,13,'Muggle','F','Gryffindor',Null,12349),
(31234423,'Perenelle Flamel','1982-07-09',567,43,'Wizard','F','Beauxbatons',Null,32134),
(23652345,'Barty Crouch','1982-10-08',234,26,'Muggle',Null,'Durmstrang','Gato',21078);

/*
-- -----------------------------------------------------
                 -- Table 'COMPETIÇÃO'
-- -----------------------------------------------------*/
INSERT INTO COMPETIÇÃO(IDOponente1,IDOponente2)
VALUES (12345678,12345679),
(31234443,23456716), 
(23652345,31234423),
(31234423,12345673);

/*
-- -----------------------------------------------------
                -- Table 'PARTICIPAÇÃO'
-- -----------------------------------------------------*/
INSERT INTO PARTICIPAÇÃO(IDAluno,IDFaseTorneio)
VALUES 
(12345678,3),
(12345679,3),
(31234423,1),
(12345673,1),
(23652345,1),
(31234443,2),
(23456716,2);




