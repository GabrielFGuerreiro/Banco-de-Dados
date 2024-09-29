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
cd_grauParentescoDepen int)

CREATE TABLE tb_parentesco(
cd_parentesco INT NOT NULL,
nm_parentesco CHAR (25))

ALTER TABLE tb_empregado ADD PRIMARY KEY (cd_empregado)
ALTER TABLE tb_dependente ADD PRIMARY KEY (cd_empregado, cd_dependente)
ALTER TABLE tb_parentesco ADD PRIMARY KEY (cd_parentesco)

ALTER TABLE tb_dependente ADD FOREIGN KEY (cd_empregado) REFERENCES tb_empregado (cd_empregado)
ALTER TABLE tb_dependente ADD FOREIGN KEY (cd_grauParentescoDepen) REFERENCES tb_parentesco (cd_parentesco)
