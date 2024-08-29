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


--Criando chaves primárias usando o ALTER TABLE
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
