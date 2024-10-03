--SQL Server

CREATE TABLE tb_empregado(
cd_empregado CHAR (8) NOT NULL,
nm_empregado CHAR (30),
dt_nasciEmpre DATE,
ds_enderecoEmpre CHAR (50),
nm_cidadeEmpre CHAR (20),
nm_estadoEmpre CHAR (2),
cd_telefoneEmpre CHAR (11))

CREATE TABLE tb_parentesco(
cd_grauParentesco INT NOT NULL,
nm_parentesco CHAR (25))

CREATE TABLE tb_dependente(
cd_empregado CHAR (8) NOT NULL,
cd_dependente INT NOT NULL,
nm_dependente CHAR (30),
dt_nasciDepen DATE,
cd_grauParentesco int)


ALTER TABLE tb_empregado ADD PRIMARY KEY (cd_empregado)
ALTER TABLE tb_dependente ADD PRIMARY KEY (cd_empregado, cd_dependente)
ALTER TABLE tb_parentesco ADD PRIMARY KEY (cd_grauParentesco)

ALTER TABLE tb_dependente ADD FOREIGN KEY (cd_empregado) REFERENCES tb_empregado (cd_empregado)
ALTER TABLE tb_dependente ADD FOREIGN KEY (cd_grauParentesco) REFERENCES tb_parentesco (cd_grauParentesco)


INSERT INTO tb_empregado(cd_empregado, nm_empregado, dt_nasciEmpre, ds_enderecoEmpre, nm_cidadeEmpre, nm_estadoEmpre, cd_telefoneEmpre)
VALUES
('1', 'Empregado1', '1973-01-01', 'Rua das Flores, 123', 'Cidade1', 'SP', '11912345678'),         --  >50
('2', 'Empregado2', '1988-01-01', 'Rua do Sol, 456', 'Cidade2', 'RJ', '11912345678'),             --  35 ~ 49
('3', 'Empregado3', '2000-01-01', 'Avenida Paulista, 98', 'Cidade3', 'SP', '11912345678'),        --  20 ~ 34
('4', 'Empregado4', '1979-01-01', 'Travessa das Palmeiras, 78', 'Cidade4', 'RJ', '11912345678'),  --  35 ~ 49
('5', 'Empregado5', '1968-01-01', 'Rua dos Pinheiros, 32', 'Cidade5', 'SP', '11912345678'),       --  >50
('6', 'Empregado6', '1976-01-01', 'Avenida Beira Mar, 250', 'Cidade6', 'RJ', '11912345678'),      --  35 ~ 49
('7', 'Empregado7', '1997-01-01', 'Rua do Mercado, 101', 'Cidade7', 'SP', '11912345678'),         --  20 ~ 34
('8', 'Empregado8', '1993-01-01', 'Avenida Brasil, 555', 'Cidade8', 'RJ', '11912345678'),         --  20 ~ 34
('9', 'Empregado9', '1970-01-01', 'Rua das Pedras, 89', 'Cidade9', 'SP', '11912345678');          --  >50

INSERT INTO tb_parentesco (cd_grauParentesco, nm_parentesco)
VALUES
(1, 'Filho'),
(2, 'Filha'),
(99, 'Esposa');

INSERT INTO tb_dependente(cd_empregado, cd_dependente, nm_dependente, dt_nasciDepen, cd_grauParentesco)
VALUES
('1', 1, 'Esposa1', '1975-01-01', 99), ('1', 2, 'Filho1', '2008-01-01', 2), ('1', 3, 'Filha1', '2005-01-01', 1),    --Empregado1
('2', 1, 'Esposa2', '1984-01-01', 99), ('2', 2, 'Filho2', '2013-01-01', 2), ('2', 3, 'Filha2', '2008-01-01', 1),    --Empregado2
('3', 1, 'Esposa3', '2002-01-01', 99), ('3', 2, 'Filho3', '2020-01-01', 2), ('3', 3, 'Filha3', '2018-01-01', 1),    --Empregado3
('4', 1, 'Esposa4', '1985-01-01', 99), ('4', 2, 'Filho4', '2014-01-01', 2), ('4', 3, 'Filha4', '2009-01-01', 1),    --Empregado4
('5', 1, 'Esposa5', '1974-01-01', 99), ('5', 2, 'Filho5', '2010-01-01', 2), ('5', 3, 'Filha5', '2006-01-01', 1),    --Empregado5
('6', 1, 'Esposa6', '1980-01-01', 99), ('6', 2, 'Filho6', '2015-01-01', 2), ('6', 3, 'Filha6', '2011-01-01', 1),    --Empregado6
('7', 1, 'Esposa7', '1999-01-01', 99), ('7', 2, 'Filho7', '2021-01-01', 2), ('7', 3, 'Filha7', '2015-01-01', 1),    --Empregado7
('8', 1, 'Esposa8', '1995-01-01', 99), ('8', 2, 'Filho8', '2022-01-01', 2), ('8', 3, 'Filha8', '2013-01-01', 1),    --Empregado8    
('9', 1, 'Esposa9', '1976-01-01', 99), ('9', 2, 'Filho9', '2015-01-01', 2), ('9', 3, 'Filha9', '2004-01-01', 1);    --Empregado9
      --Esposas                              Filhos                             Filhas

SELECT DISTINCT
    e.nm_empregado AS "Nome Empregado", 
    e.dt_nasciEmpre AS "Data de Nascimento", 
    d1.nm_dependente AS "Nome da Esposa", 
    d2.nm_dependente AS "Nome do Filho", 
    d3.nm_dependente AS "Nome da Filha"
FROM 
    tb_empregado e, 
    tb_dependente d1,   -- Apelido para esposa
    tb_dependente d2,   -- Apelido para filho
    tb_dependente d3    -- Apelido para filha
WHERE 
    e.cd_empregado = d1.cd_empregado AND d1.cd_grauParentesco = 99  -- Esposa
    AND e.cd_empregado = d2.cd_empregado AND d2.cd_grauParentesco = 2  -- Filho
    AND e.cd_empregado = d3.cd_empregado AND d3.cd_grauParentesco = 1;  -- Filha

--Escreva uma query para mostrar empregados e seus dependentes com as seguintes colunas:
--colunas -> nome empregado, data de nascimento do empregado, nome da esposa, nome dos filho e nome das filha.

SELECT DISTINCT
    e.nm_empregado AS "Nome do Empregado", 
    e.dt_nasciEmpre AS "Data de Nascimento do Empregado", 
    d1.nm_dependente AS "Nome da Esposa", 
    d2.nm_dependente AS "Nome do Filho", 
    d3.nm_dependente AS "Nome da Filha"
FROM 
    tb_empregado e       
JOIN 
    tb_dependente d1 ON e.cd_empregado = d1.cd_empregado AND d1.cd_grauParentesco = 99  --Esposa
JOIN 
    tb_dependente d2 ON e.cd_empregado = d2.cd_empregado AND d2.cd_grauParentesco = 2   --Filho
JOIN 
    tb_dependente d3 ON e.cd_empregado = d3.cd_empregado AND d3.cd_grauParentesco = 1;  --Filha


-- Escreva uma query para mostrar empregados e seus dependentes com as seguintes colunas:
--colunas -> nome empregado, nome da esposa, nome do filho, data de nascimento, nome da
--filha, data de nascimento
SELECT
    nm_empregado,
    d1.nm_dependente AS "Nome da Esposa", 
    d2.nm_dependente AS "Nome do Filho", 
    d2.dt_nasciDepen,
    d3.nm_dependente AS "Nome da Filha",
    d3.dt_nasciDepen
FROM 
    tb_empregado e       
JOIN 
    tb_dependente d1 ON e.cd_empregado = d1.cd_empregado AND d1.cd_grauParentesco = 99  --Esposa
JOIN 
    tb_dependente d2 ON e.cd_empregado = d2.cd_empregado AND d2.cd_grauParentesco = 2   --Filho
JOIN 
    tb_dependente d3 ON e.cd_empregado = d3.cd_empregado AND d3.cd_grauParentesco = 1;  --Filha

    select * from tb_dependente