drop table tb_clientes
drop table tb_vendedores
drop table tb_produtos
drop table tb_vendas

--Tabela clientes
create table tb_clientes(id_cliente int primary key, nm_cliente char (30))

insert into tb_clientes values (1, 'Gabriel'), (2, 'Mariana'), (3, 'Edmilson'), (4, 'Pedro');

--Tabela vendedores
create table tb_vendedores(id_vendedor int primary key, nm_vendedor char(30))

insert into tb_vendedores values (1, 'Joao'), (2, 'Maria');

--Tabela produtos
create table tb_produtos(id_produto int primary key, nm_produto char(30), vl_produto float)

insert into tb_produtos values (1, 'Alcool', 7.5), (2, 'Mascara', 2.5), (3, 'Luva', 3.5), (4, 'Amoniaco', 12.00);

--Tabela vendas
create table tb_vendas(id_venda int primary key, dt_venda char(15), nr_quanti int, vl_venda float, id_cliente int, id_vendedor int, id_produto int,
foreign key(id_cliente) references tb_clientes (id_cliente),
foreign key(id_vendedor) references tb_vendedores (id_vendedor),
foreign key(id_produto) references tb_produtos (id_produto))

insert into tb_vendas values
(1,	'25/03/2023',	3,	7.5, 1, 2, 2),
(2,	'12/06/2023',	6,	21, 1, 1, 3),
(3,	'22/09/2023',	1,	2.5, 2, 2, 2),
(4,	'05/01/2024',	2,	15, 4, 1, 1),
(5,	'09/05/2024',	5,	37.5, 3, 2, 1);


--|EXERCÍCIOS|--

--A) Listar o id_produto, nm_produto, id_cliente, nm_cliente, id_vendedor, nm_vendedor, qtd_venda e vl_venda, pra todas as compras realizads
select tb_vendas.id_produto, nm_produto, tb_vendas.id_cliente, nm_cliente, tb_vendas.id_vendedor, nm_vendedor, nr_quanti, vl_venda
from tb_vendas, tb_produtos, tb_clientes, tb_vendedores
where tb_vendas.id_produto = tb_produtos.id_produto and tb_vendas.id_cliente
= tb_clientes.id_cliente and tb_vendas.id_vendedor = tb_vendedores.id_vendedor

--B) Qual o id_produto, nm_produto e o vl_produto cujo valor do produto é o maior valor entre os produtos cadastrados
select id_produto, nm_produto, vl_produto from tb_produtos
where vl_produto = (select max(vl_produto) from tb_produtos)

--C) Quantos produtos temos cadastrados?
select count (*) from tb_produtos

--D) Idem acima, mas somente para os produtos cujo valor do produto esteja acima da média dos valores dos produtos cadastradosww
select count (*) from tb_produtos where vl_produto > (select avg(vl_produto) from tb_produtos)
--Outra forma, mas com nome --> select nm_produto,count (*) from tb_produtos where vl_produto > (select avg(vl_produto) from tb_produtos) group by nm_produto

--E) Quais os códigos e nomes dos produtos que não foram vendidos?
select id_produto, nm_produto from tb_produtos
where not exists (select 1 from tb_vendas where tb_vendas.id_produto = tb_produtos.id_produto)
--O outro comando não precisa ter as msm tabelas como base. Select --> tb_produtos // not exists --> tb_vendas
