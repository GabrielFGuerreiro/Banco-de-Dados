--1.Liste todas as linhas e os campos cd_Comprador, nm_Comprador e ds_Email da tabela COMPRADOR 
SELECT cd_comprador, nm_comprador, ds_email
FROM tb_comprador

--2.Liste todas as linhas e os campos cd_Vendedor, nm_Vendedor e ds_Email da tabela VENDEDOR em ordem alfabética decrescente. 
SELECT cd_vendedor, nm_vendedor, ds_email
FROM tb_vendedor
ORDER BY nm_vendedor DESC

--3.Liste as colunas cd_Imovel, cd_Vendedor e vl_Preco de todos os imóveis do vendedor 2
SELECT cd_imovel, cd_vendedor, vl_preco
FROM tb_imovel
WHERE cd_vendedor = 2

--4.Liste as colunas cd_Imovel, cd_Vendedor, vl_Preco e sg_Estado dos imóveis cujo preço de venda seja inferior a 150 mil e sejam do Estado do RJ. 
SELECT cd_imovel, cd_vendedor, vl_preco, sg_estado
FROM tb_imovel
WHERE vl_preco < 150000 AND sg_estado = 'RJ'

--5.Liste as colunas cd_Imovel, cd_Vendedor, vl_Preco e sg_Estado dos imóveis cujo preço de venda seja inferior a 150 mil e o vendedor não seja 2. 
SELECT cd_imovel, cd_vendedor, vl_preco, sg_estado
FROM tb_imovel
WHERE vl_preco < 150000 AND cd_vendedor != 2

--6.Liste as colunas cd_Comprador, nm_Comprador, ds_Endereco e sg_Estado da tabela COMPRADOR em que o Estado seja nulo.
SELECT cd_comprador, nm_comprador, ds_endereco, sg_estado
FROM tb_comprador
WHERE sg_estado IS NULL

--7.Liste todas as ofertas cujo valor esteja entre 100 mil e 150 mil.
SELECT * FROM tb_oferta
WHERE vl_oferta > 100000 AND vl_oferta < 150000

--8.Liste todas as ofertas cuja data da oferta esteja entre 01/01/2009 e 01/03/2009.
SELECT * FROM tb_oferta
WHERE dt_oferta >= '2009-01-01' AND dt_oferta <= '2009-03-01'

--Outra forma usando o convert para o formato "DD/MM/AAAA". 103 é o estilo de formato DD/MM/YYYY
--SELECT * FROM tb_oferta
--WHERE dt_oferta >= CONVERT(DATE, '01/01/2009', 103) AND dt_oferta <= CONVERT(DATE, '01/03/2009', 103);

--9.Liste todos os vendedores que comecem com a letra M.
SELECT * FROM tb_vendedor
WHERE nm_vendedor LIKE 'M%'

--LIKE é usado para buscar registros de caracteres que correspondem a um padrão específico:
--	%: Representa zero ou mais caracteres.
--	_: Representa exatamente um caractere.
--	[ ]: Define um intervalo ou uma lista de caracteres.
--	[^]: Exclui caracteres (encontra qualquer caractere que não esteja na lista).

--10.Liste todos vendedores que tenham a letra A na segunda posição do nome
SELECT * FROM tb_vendedor
WHERE nm_vendedor LIKE '_A%'

--11.Liste todos os compradores que tenham a letra U em qualquer posição do endereço 
SELECT * FROM tb_comprador
WHERE ds_endereco LIKE '%U%'

--12.Liste todos os imóveis cujo código seja 2 ou 3 em ordem alfabética de endereço.
SELECT * FROM tb_imovel
WHERE cd_imovel = 2 OR cd_imovel = 3
ORDER BY ds_endereco ASC

--13.Liste todas as ofertas cujo imóvel seja 2 ou 3 e o valor da oferta seja maior que 140 mil, em ordem decrescente de data.
SELECT * FROM tb_oferta
WHERE (cd_imovel = 2 OR cd_imovel = 3) AND vl_oferta > 140000 --O operador AND tem maior precedência que o OR, então é preciso agrupar as condições com ()
ORDER BY dt_oferta DESC

--14.Liste todos os imóveis cujo preço de venda esteja entre 110 mil e 200 mil ou seja do vendedor 4 em ordem crescente de área útil.
SELECT * FROM tb_imovel
WHERE vl_preco > 110000 AND vl_preco < 200000 OR cd_vendedor = 4
ORDER BY qt_areaUtil ASC

--15.Verifique a maior, a menor e o valor médio das ofertas desta tabela.
SELECT MAX(vl_oferta) FROM tb_oferta

SELECT MIN(vl_oferta) FROM tb_oferta

SELECT AVG(vl_oferta) AS 'Valor Médio das Ofertas' FROM tb_oferta

--16.Mostre o maior, o menor, o total e a média de preço de venda dos imóveis.
SELECT MAX(vl_preco) FROM tb_imovel

SELECT MIN(vl_preco) FROM tb_imovel

SELECT SUM (vl_preco) AS 'Total de Preços de Venda' FROM tb_imovel

SELECT AVG(vl_preco) 'Valor Médio de Preços de Venda' FROM tb_imovel

--17.Faça uma busca que retorne o total de ofertas realizadas nos anos de 2008, 2009 e 2010. 
SELECT COUNT(*) FROM tb_oferta
WHERE dt_oferta >= '2008-01-01' AND dt_oferta < '2011-01-01'

--SELECT COUNT(*) FROM tb_oferta --Outra forma usando o LIKE
--WHERE dt_oferta LIKE '2008%' OR dt_oferta LIKE '2009%' OR  dt_oferta LIKE '2010%'