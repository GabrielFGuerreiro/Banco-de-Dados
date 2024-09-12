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
(3, 'ANDRÉ CARDOSO', 'AV. BRASIL, 401', 'acardoso@nova.com'),
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


--Aumente o preço de vendas dos imóveis em 10%
UPDATE tb_imovel
SET vl_preco = vl_preco + (vl_preco*0.10)

--Abaixe o preço de venda dos imóveis do vendedor 1 em 5% 
UPDATE tb_imovel
SET vl_preco = vl_preco - (vl_preco*0.05)
WHERE cd_vendedor = 1

--Aumente em 5% o valor das ofertas do comprador 2
UPDATE tb_oferta
SET vl_oferta = vl_oferta + (vl_oferta*0.05)
WHERE cd_comprador = 2

--Altere o endereço do comprador 3 para R. ANANÁS, 45 e o estado para RJ
UPDATE tb_comprador
SET ds_endereco = 'R. ANANÁS, 45', sg_estado = 'RJ'
WHERE cd_comprador = 3

--Altere a oferta do comprador 2 no imóvel 4 para 101.000 
UPDATE tb_oferta
SET vl_oferta = 101000
WHERE cd_comprador = 2 AND cd_imovel = 4

--Exclua a oferta do comprador 3 no imóvel 1
DELETE FROM tb_oferta
WHERE cd_comprador = 3 AND cd_imovel = 1

--Exclua a cidade 3 do estado SP
DELETE FROM tb_cidade
WHERE cd_cidade = 3 AND sg_estado = 'SP'

--Inclua linhas na tabela FAIXA_IMOVEL: 
--cd_Faixa nmFaixa vl_Minimo vl_Maximo
--  1      BAIXO      0       105000
--  2      MÉDIO    105001    180000
--  3      ALTO     180001    999999 
INSERT INTO tb_faixaImovel (cd_faixa, nm_faixa, vl_minimo, vl_maximo)
VALUES
(1, 'BAIXO', 0, 105000),
(2, 'MÉDIO', 105001, 180000),
(3, 'ALTO', 180001, 999999 );



--Liste todas as linhas e os campos cd_Comprador, nm_Comprador e ds_Email da tabela COMPRADOR 
SELECT cd_comprador, nm_comprador, ds_endereco
FROM tb_comprador

--Liste todas as linhas e os campos cd_Vendedor, nm_Vendedor e ds_Email da tabela VENDEDOR em ordem alfabética decrescente. 
SELECT cd_vendedor, nm_vendedor, ds_endereco
FROM tb_vendedor
ORDER BY nm_vendedor DESC

--Liste as colunas cd_Imovel, cd_Vendedor e vl_Preco de todos os imóveis do vendedor 2
SELECT cd_imovel, cd_vendedor, vl_preco
FROM tb_imovel
WHERE cd_vendedor = 2

--Liste as colunas cd_Imovel, cd_Vendedor, vl_Preco e sg_Estado dos imóveis cujo preço de venda seja inferior a 150 mil e sejam do Estado do RJ. 
SELECT cd_imovel, cd_vendedor, vl_preco, sg_estado
FROM tb_imovel
WHERE vl_preco < 150000 AND sg_estado = 'RJ'

--Liste as colunas cd_Imovel, cd_Vendedor, vl_Preco e sg_Estado dos imóveis cujo preço de venda seja inferior a 150 mil e o vendedor não seja 2. 
SELECT cd_imovel, cd_vendedor, vl_preco, sg_estado
FROM tb_imovel
WHERE vl_preco < 150000 AND cd_vendedor != 2

--Liste as colunas cd_Comprador, nm_Comprador, ds_Endereco e sg_Estado da tabela COMPRADOR em que o Estado seja nulo.
SELECT cd_comprador, nm_comprador, ds_endereco, sg_estado
FROM tb_comprador
WHERE NOT EXISTS (
	SELECT 1
	FROM tb_estado
	WHERE tb_comprador.sg_estado = tb_estado.sg_estado)

--Liste todas as ofertas cujo valor esteja entre 100 mil e 150 mil.
SELECT * FROM tb_oferta
WHERE vl_oferta > 100000 AND vl_oferta < 150000

--Liste todas as ofertas cuja data da oferta esteja entre 01/01/2009 e 01/03/2009.
SELECT * FROM tb_oferta
WHERE dt_oferta >= '2009-01-01' AND dt_oferta <= '2009-03-01'

--Outra forma usando o convert para o formato "DD/MM/AAAA". 103 é o estilo de formato DD/MM/YYYY
--SELECT * FROM tb_oferta
--WHERE dt_oferta >= CONVERT(DATE, '01/01/2009', 103) AND dt_oferta <= CONVERT(DATE, '01/03/2009', 103);

--Liste todos os vendedores que comecem com a letra M.
SELECT * FROM tb_vendedor
WHERE nm_vendedor LIKE 'M%'

--LIKE é usado para buscar registros de caracteres que correspondem a um padrão específico:
--	%: Representa zero ou mais caracteres.
--	_: Representa exatamente um caractere.
--	[ ]: Define um intervalo ou uma lista de caracteres.
--	[^]: Exclui caracteres (encontra qualquer caractere que não esteja na lista).

--Liste todos vendedores que tenham a letra A na segunda posição do nome
SELECT * FROM tb_vendedor
WHERE nm_vendedor LIKE '_A%'

