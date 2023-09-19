/*


--------------------------------------------------------------------------------------------------

      EXERCITAÇÃO DE VÁRIOS ASPETOS DO UNIVERSO HARRY POTTER EM SQL:

---------------------------------------------------------------------------------------------------
1º: OBTER UMA DESCRIÇÃO DO NOSSO UNIVERSO: 
-------------------------------------------
-- VERIFIFICAR TABELAS QUE COMPÕEM A BD, DESCRIÇÃO DE TABELAS E CONSULTAR CONTEÚDO DE TABELAS:
*/

SHOW TABLES;
DESC ALUNO;
SELECT * FROM ALUNO; 
/*
-----------------------------------------
2º: OPERAÇÕES DE MANIPULAÇÃO DE DADOS:
-----------------------------------------
-- INSERIR UM NOVO NOME DE FEITIÇO NA TABELA E UMA NOVA POÇÃO NA TABELA DE FEITIÇOS: */

INSERT INTO NOME_DO_FEITIÇO(ID,Nome) VALUES (2,'ABRACADABRA');

INSERT INTO FEITIÇO(ID,Tipo,Dificuldade) VALUES (9,'Poção','Fácil');
/*
-- SUPONDO QUE AGORA QUEREMOS VER O NOME E A DATA DE NASCIMENTO IDADE DOS ALUNOS QUE PARTICIPAM NO TORNEIO: */

SELECT NumMec,Nome, TIMESTAMPDIFF(YEAR,DataNasc,NOW()) AS Idade,IDAluno FROM ALUNO,PARTICIPAÇÃO
WHERE NumMec = IDAluno ORDER BY Nome;

/*-- QUEREMOS AGRUPAR POR DIFICULDADE DE FEITIÇOS/POÇÕES E SABER QUANTOS EXISTEM DE CADA NÍVEL:  */

SELECT COUNT(Dificuldade),Dificuldade FROM FEITIÇO GROUP BY Dificuldade;

/*-- QUEREMOS AGRUPAR POR TIPO DE FEITIÇO (SE É FEITIÇO OU POÇÃO) E CONTAR QUANTOS EXISTEM DE CADA:*/

SELECT Tipo,COUNT(Tipo) FROM FEITIÇO GROUP BY Tipo;

/*-- QUEREMOS VER O NOME DE TODOS OS FEITIÇOS USADOS NO TORNEIO:

SELECT DISTINCT(Nome), IDFeitiço FROM NOME_DO_FEITIÇO, FEITIÇO, USA_FEITIÇO
WHERE IDFeitiço = NOME_DO_FEITIÇO.ID
ORDER BY IDFeitiço;*/

/*-- ATUALIZAR A COLUNA DE AnimalEstimação - os que tem null values vão ter agora peixes:*/

UPDATE ALUNO SET AnimalEstimação = 'Peixe' WHERE AnimalEstimação IS NULL;


/*
--------------------------------------------------
3º: Operações com consultas encadeadas
--------------------------------------------------
----Ver os nomes dos alunos que participam na primeira fase do torneio */

Select Nome from ALUNO Where NumMec IN (
select IDAluno from PARTICIPAÇÃO where IDFaseTorneio=1);

/*--- Ver o nome dos alunos que não participam em nenhuma fase do torneio*/
Select Nome from ALUNO where NumMec Not in (
select IDAluno from PARTICIPAÇÃO);

/*--- Apagar da tabela de Alunos os alunos que não participam em nenhuma fase do torneio*/
Delete from ALUNO where NumMec Not in (
select IDAluno from PARTICIPAÇÃO);
/*--- confirmação*/
Select * from ALUNO;

/*--reposicao*/
INSERT INTO ALUNO(NumMec,Nome,DataNasc,IDEscola,IDSupervisor,Origem,Sexo,Casa, AnimalEstimação,IDVarinha)
VALUES
(12345674,'Hermione Granger','1980-06-09',123,13,'Muggle','F','Gryffindor',Null,12349);
/*
---------------------------------------------------
4º: Operações com consultas em múltiplas tabelas
----------------------------------------------------
---Ver os nomes dos alunos que participam em cada fase do torneio, ordenado pela fase*/

Select Nome as Aluno, IDFaseTorneio as Participa_na_fase from ALUNO A, PARTICIPAÇÃO P
where A.NumMec=P.IDAluno
order by P.IDFaseTorneio;

/*---Contar quantos feitiços de Dificuldade máxima foram utilizados em cada fase do torneio*/
Select U.IDTorneio, count(*) as Num_Feitiços_Dificeis from USA_FEITIÇO U, FEITIÇO F
where (F.ID=U.IDFeitiço) and (F.Dificuldade='Dificil')
group by U.IDTorneio;
/*
----------------------------------------------------
5º Operações com junções (JOIN)
----------------------------------------------------
---Para cada professor contar o número de cargos (natural join)*/
select P.Nome,count(*) as NCargos from
PROFESSOR P JOIN CARGO C 
USING(ID)
group by P.Nome;
/*
---Para cada aluno contar o número de materiais da sua varinha, ordenado pelo numero de materiais de cada varinha do máximo para o minimo (junção interna e natural join)
*/
select A.NumMec,A.Nome,count(M.TipoDeMaterial) as Nmateriais from
(ALUNO A JOIN VARINHA V on (A.IDVarinha=V.Código))
join TIPO_DE_MATERIAL M USING (Código)
group by A.NumMec,A.Nome
order by Nmateriais DESC;

/*
---obter os números mecanográficos dos alunos que não participam no torneio com uma junção externa
*/
select A.NumMec from
ALUNO A LEFT OUTER JOIN PARTICIPAÇÃO P on A.NumMec=P.IDAluno 
WHERE IDFaseTorneio is NULL;
/*
-----------------------------------------------------------
6º: Alterar Tabelas
-----------------------------------------------------------
-- Na tabela varinha acrescentar uma coluna Qualidade com valores de 'Boa','Média','Má' em que o default é 'Boa'
*/
ALTER TABLE VARINHA ADD COLUMN QUALIDADE ENUM('Boa','Média','Má') NOT NULL DEFAULT 'Boa';

/*---Remover a coluna Qualidade da tabela VARINHA*/
ALTER TABLE VARINHA
DROP COLUMN QUALIDADE;

/*---Alterar o tipo de dados da coluna Casa da tabela ALUNO para uma string de 16 caracteres em vez de 45*/
ALTER TABLE ALUNO
MODIFY Casa VARCHAR(16) NOT NULL;

/*--Confirmação*/
DESC ALUNO;
/*
--------------------------------------------------------------------
7º: Operações com vistas (VIEWS)
--------------------------------------------------------------------
--criar uma view para ver o nome do aluno associado a cada varinha*/
create view DONO_DA_VARINHA (Nome,id_Varinha,Material) as
select A.Nome,V.Código,T.TipodeMaterial from
(ALUNO A JOIN VARINHA V ON (A.IDVarinha=V.Código) )
join TIPO_DE_MATERIAL T USING (Código);

/*--consultar*/
select * from DONO_DA_VARINHA;

/*--descartar*/
drop view DONO_DA_VARINHA;


