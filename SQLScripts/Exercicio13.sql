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
drop PROCEDURE SP_Valor_Bairro
select * from tb_bairro

exec SP_Valor_Bairro AEROPORTO, 10


