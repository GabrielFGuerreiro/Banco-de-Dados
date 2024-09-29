--SQL Server

CREATE TABLE tb_empregado(
cd_empregado CHAR (8) NOT NULL,
nm_empregado CHAR (30),
dt_nasciEmpre DATE,
ds_enderecoEmpre CHAR (50),
nm_cidadeEmpre CHAR (20),
nm_estadoEmpre CHAR (2),
cd_telefoneEmpre CHAR (11))


CREATE TABLE tb_dependente(
cd_empregado CHAR (8) NOT NULL,
cd_dependente INT NOT NULL,
nm_dependente CHAR (30),
dt_nasciDepen DATE,
cd_grauParentesco int)

CREATE TABLE tb_parentesco(
cd_grauParentesco INT NOT NULL,
nm_parentesco CHAR (25))

ALTER TABLE tb_empregado ADD PRIMARY KEY (cd_empregado)
ALTER TABLE tb_dependente ADD PRIMARY KEY (cd_empregado, cd_dependente)
ALTER TABLE tb_parentesco ADD PRIMARY KEY (cd_parentesco)

ALTER TABLE tb_dependente ADD FOREIGN KEY (cd_empregado) REFERENCES tb_empregado (cd_empregado)
ALTER TABLE tb_dependente ADD FOREIGN KEY (cd_grauParentesco) REFERENCES tb_parentesco (cd_grauParentesco)


INSERT INTO tb_empregado(cd_empregado, nm_empregado, dt_nasciEmpre, ds_enderecoEmpre, nm_cidadeEmpre, nm_estadoEmpre, cd_telefoneEmpre)
VALUES
(1, "Empregado1", "1973-01-01", "Rua das Flores, 123", "Cidade1", "SP", "11912345678"),         --  >50
(2, "Empregado2", "1988-01-01", "Rua do Sol, 456", "Cidade2", "RJ", "11912345678"),             --  35 ~ 49
(3, "Empregado3", "2000-01-01", "Avenida Paulista, 98", "Cidade3", "SP", "11912345678"),        --  20 ~ 34
(4, "Empregado4", "1979-01-01", "Travessa das Palmeiras, 78", "Cidade4", "RJ", "11912345678"),  --  35 ~ 49
(5, "Empregado5", "1968-01-01", "Rua dos Pinheiros, 32", "Cidade5", "SP", "11912345678"),       --  >50
(6, "Empregado6", "1976-01-01", "Avenida Beira Mar, 250", "Cidade6", "RJ", "11912345678"),      --  35 ~ 49
(7, "Empregado7", "1997-01-01", "Rua do Mercado, 101", "Cidade7", "SP", "11912345678"),         --  20 ~ 34
(8, "Empregado8", "1993-01-01", "Avenida Brasil, 555", "Cidade8", "RJ", "11912345678"),         --  20 ~ 34
(9, "Empregado9", "1970-01-01", "Rua das Pedras, 89", "Cidade9", "SP", "11912345678");          --  >50


