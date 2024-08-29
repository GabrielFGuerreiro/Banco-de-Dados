create table tb_faixaImovel(
cd_faixa  int NOT NULL,  --PK precisa ser NOT NULL
nm_faixa varchar (30),
vl_maximo money,
vl_minimo money)

-----||-----
create table tb_vendedor(
cd_vendedor int NOT NULL,
nm_vendedor varchar (40),
ds_endereco varchar (40),
cd_CPF decimal (11,0),
nm_cidade varchar (20), 
nm_bairro varchar (20),
sg_estado char (2),
cd_telefone varchar (20),
ds_email varchar (80))

-----||-----
create table tb_comprador(
cd_comprador int NOT NULL,
nm_comprador varchar (40),
ds_endereco varchar (40),
cd_CPF decimal (11,0),
nm_cidade varchar (20),
nm_bairro varchar (20),
sg_estado varchar (2),
cd_telefone varchar (20),
ds_email varchar (80))

create table tb_oferta(
cd_comprador int NOT NULL,
cd_imovel int NOT NULL,
vl_oferta money,
dt_oferta date)

-----||-----
create table tb_estado(
sg_estado char (2) NOT NULL,
nm_estado varchar (20))

create table tb_cidade(
cd_cidade int NOT NULL,
sg_estado char (2) NOT NULL,
nm_cidade varchar (20));

create table tb_bairro(
cd_bairro int NOT NULL,
cd_cidade int NOT NULL,
sg_estado char (2) NOT NULL,
nm_bairro char (20));

-----||-----
create table tb_imovel( 
cd_imovel int NOT NULL,
cd_vendedor int,
cd_bairro int,
cd_cidade int,
sg_estado char (2),
ds_endereco varchar (40),
qt_areaUtil decimal (10,2),
qt_areaTotal decimal (10,2),
ds_imovel varchar (300),
vl_preco money,
qt_ofetas int,
ic_vendido char (1),
dt_lancto date,
qt_imovelIndicado int)

--Criando chaves primárias usando o ALTER TABLE.
-- ALTER TABLE *tabela*  ADD PRIMARY KEY *(campo)*

ALTER TABLE tb_faixaImovel  ADD PRIMARY KEY (cd_faixa);
ALTER TABLE tb_vendedor ADD PRIMARY KEY (cd_vendedor);
ALTER TABLE tb_oferta ADD PRIMARY KEY (cd_comprador,cd_imovel);
ALTER TABLE tb_estado ADD PRIMARY KEY (sg_estado);
ALTER TABLE tb_cidade ADD PRIMARY KEY (sg_estado, cd_cidade);
ALTER TABLE tb_bairro ADD PRIMARY KEY (sg_estado, cd_cidade, cd_bairro); --PKs compostas (sempre de msm tabela) // != de declarar separadamente
ALTER TABLE tb_imovel ADD PRIMARY KEY (cd_imovel);


--Criando chaves estrangeiras usando o ALTER TABLE
-- ALTER TABLE *tabela1* ADD FOREIGN KEY *(campo1)* REFERENCES *tabela2* *(campo2)*;

ALTER TABLE tb_oferta ADD FOREIGN KEY (cd_comprador) REFERENCES tb_comprador (cd_comprador);
ALTER TABLE tb_oferta ADD FOREIGN KEY (cd_imovel) REFERENCES tb_imovel (cd_imovel);
ALTER TABLE tb_cidade ADD FOREIGN KEY (sg_estado) REFERENCES tb_estado (sg_estado);
ALTER TABLE tb_bairro
	ADD FOREIGN KEY (sg_estado, cd_cidade) REFERENCES tb_cidade (sg_estado, cd_cidade);
ALTER TABLE tb_imovel ADD FOREIGN KEY (cd_vendedor) REFERENCES tb_vendedor (cd_vendedor);
ALTER TABLE tb_imovel
	ADD FOREIGN KEY (cd_bairro, cd_cidade, sg_estado) REFERENCES tb_bairro (cd_bairro, cd_cidade, sg_estado);

-- Incluindo valores nas tabelas
INSERT INTO tb_estado (sg_estado, nm_estado)
VALUES
('SP', 'SÃO PAULO'),
('RJ', 'RIO DE JANEIRO');
	   
INSERT INTO tb_cidade (cd_cidade, nm_cidade, sg_estado) 
VALUES
(1, 'SÃO PAULO', 'SP'),
(2, 'SANTO ANDRÉ', 'SP'),
(3, 'CAMPINAS', 'SP'),
(1, 'RIO DE JANEIRO', 'RJ'),
(2, 'NITERÓI', 'RJ');

INSERT INTO tb_bairro (cd_bairro, nm_bairro, cd_cidade, sg_estado)
VALUES	
(1, 'JARDINS', 1, 'SP'),
(2, 'MORUMBI', 1, 'SP'),
(3, 'AEROPORTO', 1, 'SP'),
(1, 'AEROPORTO', 1, 'RJ'),
(2, 'NITERÓI', 2, 'RJ');

INSERT INTO tb_vendedor (cd_vendedor, nm_vendedor, ds_endereco, ds_email)
VALUES
(1, 'MARIA DA SILVA', 'RUA DO GRITO, 45', 'msilva@nova.com'),
(2, 'MARCO ANDRADE', 'AV. DA SAUDADE, 325', 'mandrade@nova.com'),
(3, 'ANDRÉ CARDOSO', 'AV. BRASIL, 401', 'acardosoa@nova.com'),
(4, 'TATIANA SOUZA', 'RUA DO IMPERADOR, 778', 'tsouza@nova.com');

INSERT INTO tb_imovel (cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areaUtil, qt_areaTotal, vl_preco)
VALUES
(1, 1, 1, 1, 'SP', 'AL. TIETE, 3304/101', 250, 400, 180000),
(2, 1, 2, 1, 'SP', 'AV. MORUMBI, 2230', 150, 250, 135000),
(3, 2, 1, 1, 'RJ', 'R. GAL. OSORIO, 445/34', 250, 400, 185000),
(4, 2, 2, 2, 'RJ', 'R. D. PEDRO 1, 882', 120, 200, 110000),
(5, 3, 3, 1, 'SP', 'AV. RUBENS BERTA, 2355', 110, 200, 95000),
(6, 4, 1, 1, 'RJ', 'AV. GETULIO VARGAS, 552', 200, 300, 99000);

INSERT INTO tb_comprador (cd_comprador, nm_comprador, ds_endereco, ds_email)
VALUES
(1, 'EMMANUEL ANTUNES', 'R. SARAIVA, 452', 'eantunes@nova.com'),
(2, 'JOANA PEREIRA', 'AV. PORTUGAL, 52', 'jpereira@nova.com'),
(3, 'RONALDO CAMPELO', 'R. ESTADOS UNIDOS, 13', 'rcampelo@nova.com'),
(4, 'MANFRED AUGUSTO', 'AV. BRASIL, 351', 'maugusto@nova.com');

INSERT INTO tb_oferta (cd_comprador, cd_imovel, vl_oferta, dt_oferta)
VALUES
(1, 1, 170000, '10/01/09'), 
(1, 3, 180000, '10/01/09'), 
(2, 2, 135000, '15/01/09'), 
(2, 4, 100000, '15/02/09'), 
(3, 1, 160000, '05/01/09'), 
(3, 2, 140000, '20/02/09');
