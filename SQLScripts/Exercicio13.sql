---1. Escreva uma procedure que receba o nome do bairro e um valor percentual como  parâmetro, aplique este percentual de acréscimo nos imóveis deste bairro.  

CREATE PROCEDURE SP_Valor_Bairro
    @bairro varchar (30),
    @valorporcent int
AS
BEGIN
    UPDATE i
    SET i.vl_preco = i.vl_preco * (1 + @valorporcent / 100.0)
    FROM tb_imovel i
    JOIN tb_bairro b on i.cd_bairro = b.cd_bairro
    WHERE b.nm_bairro = @bairro
    AND b.cd_bairro = i.cd_bairro
    AND b.cd_cidade = i.cd_cidade
    AND b.sg_estado = i.sg_estado
END;

exec SP_Valor_Bairro AEROPORTO, 10

--2. Escreva uma procedure que receba o código do comprador e um valor percentual como parâmetro,
--aplique este percentual de acréscimo na última oferta com o  maior valor que esse comprador fez,
--se o valor desta oferta representar um valor inferior a 10% de acréscimo do valor do Imóvel, desconsiderar o reajuste.
CREATE PROCEDURE SP_AUMENTA_OFERTA
    @codigoComprador int,
    @valorPercent money
AS
BEGIN
    UPDATE o
    SET vl_oferta = vl_oferta * (1 + @valorPercent / 100.0)
    FROM tb_oferta o
    WHERE cd_comprador = @codigoComprador
    AND vl_oferta = (
        select max(vl_oferta)
        from tb_oferta
        WHERE cd_comprador = @codigoComprador
        )
    AND o.vl_oferta >= (
        select vl_preco * 1.10
        from tb_imovel
        WHERE cd_imovel = o.cd_imovel
        )
END

exec SP_AUMENTA_OFERTA 2, 10

--3. Escreva uma procedure que calcule a média dos valores das ofertas de cada imóvel e salve esta média no registro do imóvel.
ALTER TABLE tb_imovel
ADD vl_media_oferta money;

CREATE PROCEDURE SP_CALCULA_MEDIA_OFERTAS
AS
BEGIN
    UPDATE i
    SET i.vl_media_oferta = (
        SELECT AVG(vl_oferta)
        FROM tb_oferta o
        WHERE o.cd_imovel = i.cd_imovel
        )
    FROM tb_imovel i
END

exec SP_CALCULA_MEDIA_OFERTAS

--4. Faça uma procedure que aplique um aumento no valor do Imóvel (cujo valor deve  ser recebido como parâmetro),
--somente para os imóveis que estão com um índice de “BAIXO” na faixa de imóveis.  
CREATE PROCEDURE SP_AUMENTA_VALOR_IMOVEL_FAIXA
    @valorAumento int
AS
BEGIN
    UPDATE i
    SET vl_preco += @valorAumento
    FROM tb_imovel i
    WHERE vl_preco BETWEEN 0 AND 105000
END

exec SP_AUMENTA_VALOR_IMOVEL_FAIXA 1000

