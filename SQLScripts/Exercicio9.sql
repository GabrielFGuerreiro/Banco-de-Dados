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

