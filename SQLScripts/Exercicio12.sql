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
