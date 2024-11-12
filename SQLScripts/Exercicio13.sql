---1. Escreva uma procedure que receba o nome do bairro e um valor percentual como  parâmetro, aplique este percentual de acréscimo nos imóveis deste bairro.  

CREATE PROCEDURE SP_Valor_Bairro
    @bairro varchar (30),
    @valorporcent float
AS
BEGIN
    UPDATE i
    SET i.vl_preco = i.vl_preco * @valorporcent
    FROM tb_imovel i
    JOIN tb_bairro b on i.cd_bairro = b.cd_bairro
    WHERE b.nm_bairro = @bairro
    AND b.cd_bairro = i.cd_bairro
    AND b.cd_cidade = i.cd_cidade
    AND b.sg_estado = i.sg_estado
END;

exec SP_Valor_Bairro morumbi, 1.10

--2. Escreva uma procedure que receba o código do comprador e um valor percentual como parâmetro,
--aplique este percentual de acréscimo na última oferta com o  maior valor que esse comprador fez,
--se o valor desta oferta representar um valor inferior a 10% de acréscimo do valor do Imóvel, desconsiderar o reajuste.
CREATE PROCEDURE SP_AUMENTA_OFERTA
    @codigoComprador int,
    @valorPercent float
AS
BEGIN
    UPDATE o
    SET vl_oferta = vl_oferta * @valorPercent
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

exec SP_AUMENTA_OFERTA 2, 1.15

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


--5.Escreva uma procedure que receba um valor percentual como parâmetro e aplique um desconto no valor do Imóvel
--somente nos Imóveis do estado de São Paulo.  
CREATE PROCEDURE SP_DESCONTO_IMOVEL_SAOPAULO
    @valorPercent float
AS
BEGIN
    UPDATE i
    SET vl_preco = vl_preco - (vl_preco * @valorPercent)
    FROM tb_imovel i
    where sg_estado = 'SP'
END

exec SP_DESCONTO_IMOVEL_SAOPAULO 0.10

--6. Escreva uma procedure que receba como parâmetro o número do Imóvel e um número que represente a quantidade de parcelas
--em que o valor do imóvel será dividido. A procedure deve obter o valor total deste pedido, calcular o valor de
--cada parcela e gravar cada parcela na tabela Parcelas. Se a quantidade de parcelas for maior que 3, acrescente 10% ao valor
--total do pedido, divida-o na quantidade de parcelas recebida como parâmetro e grave-as na tabela Parcelas.
--Se a quantidade de parcelas for 1, retorne a mensagem: pedido à vista e interrompa o  processamento.
--Não deixe que o número de parcelas ultrapasse a 10. Se  ultrapassar, retorne a mensagem: Quantidade de parcelas inválida.
--Antes de executar esta procedure, criar a tabela Parcelas e fazer o relacionamento com Imóvel e Comprador. 

CREATE TABLE tb_parcelas( --CREATE
    cd_parcela INT IDENTITY(1,1) NOT NULL,  --IDENTITY = INCREMENTA
    cd_imovel INT,
    cd_comprador INT,
    vl_parcela money,
    qnt_parcelas INT
)

ALTER TABLE tb_parcelas  --ALTER (PK)
ADD CONSTRAINT PK_parcela PRIMARY KEY (cd_parcela)

ALTER TABLE tb_parcelas --ALTER (FKs)
ADD FOREIGN KEY (cd_imovel) REFERENCES tb_imovel (cd_imovel)

ALTER TABLE tb_parcelas
ADD FOREIGN KEY (cd_comprador) REFERENCES tb_comprador (cd_comprador)

CREATE PROCEDURE SP_PARCELAS_IMOVEL --PROCEDURE
    @numImovel int,
    @qntParcelas int
AS
BEGIN
    IF @qntParcelas > 10
        BEGIN
        PRINT 'Quantidade de parcelas inválida!'
        RETURN
    END

    IF @qntParcelas = 1
    BEGIN
        PRINT 'Pedido à vista'
        RETURN
    END

    DECLARE @vl_imovelVar MONEY;
    SELECT @vl_imovelVar = vl_preco FROM tb_imovel WHERE cd_imovel = @numImovel
    
    IF @qntParcelas > 3
    BEGIN
        SET @vl_imovelVar = @vl_imovelVar * 1.10
    END

    DECLARE @valorParcela MONEY;
    SET @valorParcela = @vl_imovelVar / @qntParcelas;

    DECLARE @i INT = 1;
    WHILE @i <= @qntParcelas
    BEGIN
        INSERT INTO tb_parcelas (cd_imovel, cd_comprador, vl_parcela, qnt_parcelas)
        SELECT @numImovel, cd_comprador, @valorParcela, @qntParcelas
        FROM tb_comprador

        SET @i = @i + 1;
    END
END

exec SP_PARCELAS_IMOVEL 1, 5


--7.Escreva uma função que receba o código do Imóvel como parâmetro e retorne a quantidade de ofertas recebidas de todos
--os imóveis mesmo que não tenha oferta cadastrada, mostrando zero na quantidade.  

CREATE FUNCTION FN_CONTA_QNT_OFERTAS (@cd_imovel INT)
RETURNS INT
AS
BEGIN
    DECLARE @qtd_ofertas INT

    SELECT @qtd_ofertas =  --recebe o valor
        CASE 
            WHEN COUNT(vl_oferta) > 0 THEN COUNT(vl_oferta)
            ELSE 0
        END
    FROM tb_oferta
    WHERE cd_imovel = @cd_imovel

    RETURN @qtd_ofertas
END

SELECT dbo.FN_CONTA_QNT_OFERTAS(5)AS qtd_ofertas


--8.Escreva uma função que receba o código do Imóvel como parâmetro e mostre o nome do comprador que fez a última oferta.  

CREATE FUNCTION FN_RETORNA_COMPRADOR (@cd_imovel INT)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @nm_comprador VARCHAR(30)

    SELECT @nm_comprador = c.nm_comprador
    FROM tb_oferta o
    JOIN tb_comprador c ON o.cd_comprador = c.cd_comprador
    WHERE o.cd_imovel = @cd_imovel
    ORDER BY o.dt_oferta DESC

    RETURN @nm_comprador
END

SELECT dbo.FN_RETORNA_COMPRADOR(1) AS 'Nom do comprador'
