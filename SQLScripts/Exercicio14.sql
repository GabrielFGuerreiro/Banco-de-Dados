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

--2. Escreva um trigger que não permita a alteração de dados na tabela Estado e a sua exclusão.
CREATE TRIGGER IMPEDE_ALTERACAO_EXCLUSAO
ON tb_estado
AFTER UPDATE, DELETE
AS
BEGIN
    PRINT 'Não é possível modificar nem excluir os dados desta tabela!'
    ROLLBACK TRANSACTION
END

--3. Escreva um trigger que não permita a alteração de dados na tabela Faixa Imóvel e a sua exclusão.
CREATE TRIGGER IMPEDE_ALTERACAO_EXCLUSAO2
ON tb_faixaImovel
AFTER UPDATE, DELETE
AS
BEGIN
    PRINT 'Não é possível modificar nem excluir os dados desta tabela!'
    ROLLBACK TRANSACTION
END
