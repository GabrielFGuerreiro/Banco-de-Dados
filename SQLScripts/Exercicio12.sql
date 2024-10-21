--1. Faça uma lista de imóveis do mesmo bairro do imóvel 2. Exclua o imóvel 2 da sua busca. 
SELECT
    cd_imovel AS 'Código do imóvel'
FROM
    tb_imovel i,(
        select  cd_bairro, cd_cidade, sg_estado
        from tb_imovel
        where cd_imovel = 2
        ) imovel2
WHERE
    i.cd_bairro = imovel2.cd_bairro
    AND i.cd_cidade = imovel2.cd_cidade
    AND i.sg_estado = imovel2.sg_estado
    AND i.cd_imovel <> 2;

--2.Faça uma lista que mostre todos os imóveis que custam mais que a média de preço dos imóveis. 
SELECT
    cd_imovel
FROM 
    tb_imovel
WHERE
    vl_preco >(
        SELECT avg(vl_preco)
        FROM tb_imovel
    );

--3. Faça uma lista com todos os compradores que tenham ofertas cadastradas com o valor superior a 70 mil.
SELECT
    nm_comprador,
    vl_oferta
FROM
    tb_comprador c
JOIN
    tb_oferta o ON c.cd_comprador = o.cd_comprador
WHERE
    vl_oferta > 70000;

--4.Faça uma lista com todos os imóveis com oferta superior à média do valor das Ofertas.
SELECT
    i.cd_imovel
FROM
    tb_imovel i
JOIN
    tb_oferta o ON i.cd_imovel = o.cd_imovel
WHERE
    vl_oferta >(
        select avg(vl_oferta)
        from tb_oferta
    );

--5. Faça uma lista com todos os imóveis com preço superior à média de preço dos imóveis do mesmo bairro.
SELECT
    cd_imovel,
    vl_preco
FROM
    tb_imovel i
WHERE
    vl_preco > (
        SELECT AVG(vl_preco)
        FROM tb_imovel
        WHERE cd_bairro = i.cd_bairro --relação entre a subconsulta e a consulta principal
        AND cd_cidade = i.cd_cidade
        AND sg_estado = i.sg_estado
    );

--6. Faça uma lista dos imóveis com o maior preço agrupado por bairro, cujo maior preço seja superior à média de preços dos imóveis.
SELECT
	max(vl_preco), cd_imovel, cd_bairro
FROM
	tb_imovel
WHERE
	vl_preco > (
		select avg(vl_preco)
		from tb_imovel
		)
GROUP BY 
	cd_imovel, cd_bairro;

--7. Faça uma lista com os imóveis que tem o preço igual ao menor preço de cada vendedor.
SELECT
    i.cd_imovel,
    i.cd_vendedor
FROM
    tb_imovel i,( 
        select cd_vendedor, min(vl_preco) AS menorpreco
        from tb_imovel
        group by cd_vendedor
        ) min
WHERE
    i.cd_vendedor = min.cd_vendedor
    AND i.vl_preco = min.menorpreco

--8. Faça uma lista com as ofertas menores que todas as ofertas do comprador 2, exceto os imóveis do próprio comparador.
SELECT
    o.cd_imovel,
    o.vl_oferta
FROM
    tb_oferta o,(
        select MIN(vl_oferta) AS menor_oferta
        from tb_oferta
        where cd_comprador = 2
        ) o2
WHERE
    o.vl_oferta < o2.menor_oferta
    AND o.cd_comprador <> 2;

--9. Faça uma lista de todos os imóveis cujo Estado e Cidade sejam os mesmos do vendedor 3, exceto os imóveis do vendedor 3.
SELECT
    cd_imovel
FROM
    tb_imovel
WHERE cd_cidade =  (
    select cd_cidade
    from tb_imovel
    where cd_vendedor = 3
    ) 
AND sg_estado = (
    select sg_estado
    from tb_imovel
    where cd_vendedor = 3
    ) 
AND cd_vendedor <> 3

--10. Faça uma lista com todos os nomes de bairro cujos imóveis sejam do mesmo Estado, cidade e bairro do imóvel código 5.
SELECT
    b.nm_bairro
FROM
    tb_imovel i
JOIN 
    tb_bairro b 
ON
    i.cd_bairro = b.cd_bairro
    AND i.cd_cidade = b.cd_cidade
    AND i.sg_estado = b.sg_estado
WHERE
    i.cd_bairro = (
        SELECT cd_bairro
        FROM tb_imovel
        WHERE cd_imovel = 5
    )
AND
    i.cd_cidade = (
        SELECT cd_cidade
        FROM tb_imovel
        WHERE cd_imovel = 5
    )
AND
    i.sg_estado = (
        SELECT sg_estado
        FROM tb_imovel
        WHERE cd_imovel = 5
    );
