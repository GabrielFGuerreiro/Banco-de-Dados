--1. Faça uma lista de imóveis do mesmo bairro do imóvel 2. Exclua o imóvel 2 da sua busca. 
SELECT
    cd_imovel AS "Código do imóvel",
    nm_bairro
FROM
    tb_imovel i
JOIN tb_bairro b ON i.cd_bairro = b.cd_bairro
    AND i.cd_cidade = b.cd_cidade
    AND i.sg_estado = b.sg_estado
WHERE 
    b.cd_bairro = (
        SELECT cd_bairro
        FROM tb_imovel 
        WHERE cd_imovel = 2
    )
AND cd_imovel <> 2;

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

