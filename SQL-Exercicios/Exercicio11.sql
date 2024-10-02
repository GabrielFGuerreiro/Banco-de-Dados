--1. Faça uma busca que mostre cd_Imovel, cd_Vendedor, nm_Vendedor e sg_Estado.
SELECT
    cd_imovel AS 'Código imóvel',
    tb_imovel.cd_vendedor AS 'Código vendedor',
    nm_vendedor AS 'Nome vendedor',
    tb_imovel.sg_estado 'Estado'
FROM
    tb_vendedor INNER JOIN tb_imovel
ON
    tb_imovel.cd_vendedor = tb_vendedor.cd_vendedor;

--2. Faça uma busca que mostre cd_Comprador, nm_Comprador, cd_Imovel e vl_Oferta.
SELECT
    tb_comprador.cd_comprador AS 'Código comprador',
    nm_comprador AS 'Nome comprador',
    cd_imovel AS 'Código imóvel',
    vl_oferta AS 'Oferta'
FROM
    tb_comprador INNER JOIN tb_oferta
ON
    tb_comprador.cd_comprador = tb_oferta.cd_comprador;

--3. Faça uma busca que mostre cd_Imovel, vl_Imovel e nm_Bairro, cujo código do vendedor seja 3.
SELECT
    cd_imovel AS 'Código imóvel',
    vl_preco AS 'Preço',
    nm_bairro AS 'Nome bairro'
FROM
    tb_imovel INNER JOIN tb_bairro
ON
    tb_imovel.cd_bairro = tb_bairro.cd_bairro --A tabela bairro possuir um chave composta (cd_bairro, cd_cidade, sg_estado).
    AND tb_imovel.cd_cidade = tb_bairro.cd_cidade --Essa consulta irá retornar registros da tabela tb_imovel e da tabela tb_bairro
    AND tb_imovel.sg_estado = tb_bairro.sg_estado --onde todas as três condições de junção são verdadeiras.
WHERE
    tb_imovel.cd_vendedor = 3;

--4. Faça uma busca que mostre todos os imóveis que tenham ofertas cadastradas.
SELECT DISTINCT --Disctinct remove duplicações
    tb_imovel.cd_imovel AS 'Imóveis com ofertas cadastradas'
FROM
    tb_imovel INNER JOIN tb_oferta
ON
    tb_imovel.cd_imovel = tb_oferta.cd_imovel; --Filtra os imóveis de forma implícita 

--5. Faça uma busca que mostre todos os imóveis e ofertas mesmo que não haja ofertas cadastradas para o imóvel.
SELECT
    tb_imovel.cd_imovel,
    vl_oferta
FROM        
    tb_imovel LEFT OUTER JOIN tb_oferta --Pega os valores da intersecção (imóveis com oferta) e os fora
ON                                      --da intersecção, mas apenas da tabela esquerda (tb_imovel)
    tb_imovel.cd_imovel = tb_oferta.cd_imovel;

--6. Faça uma busca que mostre os compradores e as respectivas ofertas realizadas por eles.
SELECT
    tb_comprador.cd_comprador AS 'Código comprador',
    nm_comprador AS 'Nome comprador',
    vl_oferta AS 'Valor oferta'
FROM
    tb_comprador INNER JOIN tb_oferta
ON
    tb_comprador.cd_comprador = tb_oferta.cd_comprador;

--7. Faça a mesma busca, porém acrescentando os compradores que ainda não fizeram ofertas para os imóveis.
SELECT
    tb_comprador.cd_comprador AS 'Código comprador',
    nm_comprador AS 'Nome comprador',
    vl_oferta AS 'Valor oferta'
FROM
    tb_comprador LEFT JOIN tb_oferta
ON
    tb_comprador.cd_comprador = tb_oferta.cd_comprador;

--8. Faça uma busca que mostre o endereço do imóvel, o bairro e nível de preço do imóvel.
SELECT
    ds_endereco AS 'Endereço do imóvel',
    nm_bairro AS 'Bairro',
    nm_faixa AS 'Nível de preço'
FROM
    tb_imovel
INNER JOIN tb_bairro ON
    tb_imovel.cd_bairro = tb_bairro.cd_bairro
    AND tb_imovel.cd_cidade = tb_bairro.cd_cidade
    AND tb_imovel.sg_estado = tb_bairro.sg_estado
INNER JOIN tb_faixaImovel ON
       tb_imovel.vl_preco >= tb_faixaImovel.vl_minimo AND tb_imovel.vl_preco <= tb_faixaImovel.vl_maximo;

--9. Faça uma busca que retorne o total de imóveis por nome de vendedor. Apresente em ordem de total de imóveis.
SELECT
    COUNT(cd_imovel) AS 'Quantidade de imóveis',
    nm_vendedor AS 'Nome vendedor'
FROM 
    tb_imovel INNER JOIN tb_vendedor
ON
    tb_imovel.cd_vendedor = tb_vendedor.cd_vendedor
GROUP BY
    nm_vendedor;

--10. Verifique a diferença de preços entre o maior e o menor imóvel da tabela.
SELECT
    MAX(vl_preco) - MIN(vl_preco)
FROM
    tb_imovel;

--11. Mostre o código do vendedor e o menor preço de imóvel dele no cadastro. Exclua da busca os valores de imóveis inferiores a 10 mil.
SELECT
    tb_vendedor.cd_vendedor AS 'Código vendedor',
    MIN(vl_preco) AS 'Menor preço de imóvel'
FROM
    tb_imovel INNER JOIN tb_vendedor
ON
    tb_imovel.cd_vendedor = tb_vendedor.cd_vendedor
WHERE
    vl_preco > 10000
GROUP BY
    tb_vendedor.cd_vendedor;

--12. Mostre o código e o nome do comprador e a média do valor das ofertas e o número de ofertas deste comprador.
SELECT 
    tb_comprador.cd_comprador AS 'Código comprador',
    nm_comprador AS 'Nome comprador',
    AVG(vl_oferta) AS 'Média ofertas',
    COUNT(vl_oferta) AS 'Quantidade ofertas'
FROM
    tb_comprador INNER JOIN tb_oferta
ON
    tb_comprador.cd_comprador = tb_oferta.cd_comprador
GROUP BY
    tb_comprador.cd_comprador,
    nm_comprador
select * from tb_oferta