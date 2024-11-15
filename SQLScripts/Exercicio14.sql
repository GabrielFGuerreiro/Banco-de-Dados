-- 1. Escreva um trigger que realize a atualização do campo valor médio do Imóvel a cada nova oferta cadastrada,alterada ou excluída.  
CREATE TRIGGER ATT_VALOR_MEDIO_IMOVEL
ON tb_oferta
AFTER INSERT, UPDATE, DELETE
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

