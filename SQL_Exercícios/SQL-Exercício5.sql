--Tabela Gerentes
create table tb_gerentes (id_gerente int primary key, nm_gerente char (30))

insert into tb_gerentes values (1, 'João Alves')
insert into tb_gerentes values (2, 'Maria Clara')
insert into tb_gerentes values (3, 'Pedro Cardoso')
insert into tb_gerentes values (4, 'Sandra Regina')

--Tabela Produtos
create table tb_produtos (id_produto int primary key, nm_produto char (30))
insert into tb_produtos values (1, 'Produto 1') 
insert into tb_produtos values (2, 'Produto 2')
insert into tb_produtos values (3, 'Produto 3')
insert into tb_produtos values (4, 'Produto 4')


--Tabela Filiais
create table tb_filiais (id_filial int primary key, nm_filial char (30), id_gerente int, nr_funcionarios int,
foreign key (id_gerente) references tb_gerentes (id_gerente))

insert into tb_filiais values (1, 'São Paulo', 1, 30)
insert into tb_filiais values (2, 'Curitiba', 2, 50)
insert into tb_filiais values (3, 'RJ', 3, 44)
insert into tb_filiais values (4, 'Santos', 4, 40)


--Tabela Estoque
create table tb_estoque (id_filial int, id_produto int, nr_estoque int, nr_estoque_min int, 
foreign key (id_filial) references  tb_filiais (id_filial),
foreign key (id_produto) references  tb_produtos (id_produto),
primary key (id_filial, id_produto))

insert into tb_estoque values (1, 1, 100, 110)
insert into tb_estoque values (1, 2, 24, 15) 
insert into tb_estoque values (1, 3, 55, 50) 
insert into tb_estoque values (1, 4, 700, 400) 
insert into tb_estoque values (2, 1, 130, 140)
insert into tb_estoque values (2, 2, 30, 15) 
insert into tb_estoque values (2, 3, 40, 20) 
insert into tb_estoque values (3, 1, 10, 5) 
insert into tb_estoque values (3, 2, 20, 22)
insert into tb_estoque values (3, 3, 30, 15) 
insert into tb_estoque values (4, 1, 110, 100)
insert into tb_estoque values (4, 2, 124, 100) 
insert into tb_estoque values (4, 3, 155, 160)
insert into tb_estoque values (4, 4, 50, 60)

--*Tabela que foi demembrada e usada como base para criar as tabelas acima 😥😭😨*
select tb_filiais.id_filial, nm_filial, tb_gerentes.id_gerente, nm_gerente, nr_funcionarios, tb_produtos.id_produto, nm_produto, nr_estoque, nr_estoque_min 
from tb_filiais, tb_gerentes, tb_estoque, tb_produtos
where tb_filiais.id_filial = tb_estoque.id_filial and tb_produtos.id_produto = tb_estoque.id_produto and tb_gerentes.id_gerente = tb_filiais.id_gerente


---|EXERCÍCIOS|---

--Qual a filial com maior qtde de funcionários
select nm_filial from tb_filiais
where nr_funcionarios = (select max(nr_funcionarios) from tb_filiais)

--Listar nome da filial, nome do gerente, qt de funcionarios, nome do produto, qt em estoque e qt mínima
select nm_filial, nm_gerente, nr_funcionarios, nm_produto, nr_estoque, nr_estoque_min
from tb_filiais, tb_gerentes, tb_produtos, tb_estoque
where tb_filiais.id_filial = tb_estoque.id_filial and tb_gerentes.id_gerente = tb_filiais.id_filial
and tb_produtos.id_produto = tb_estoque.id_produto

--Idem acima, mas somente para os produtos cujos estoques estejam acima da qt mínima planejada
select nm_filial, nm_gerente, nr_funcionarios, nm_produto, nr_estoque, nr_estoque_min
from tb_filiais, tb_gerentes, tb_produtos, tb_estoque
where tb_filiais.id_filial = tb_estoque.id_filial and tb_gerentes.id_gerente = tb_filiais.id_filial
and tb_produtos.id_produto = tb_estoque.id_produto and nr_estoque > nr_estoque_min

--Qual filial e produto cujo estoque seja o maior da base?
select nm_filial, nm_produto from tb_filiais, tb_produtos, tb_estoque
where nr_estoque = (select max(nr_estoque) from tb_estoque) and tb_filiais.id_filial = tb_estoque.id_filial and
tb_produtos.id_produto = tb_estoque.id_produto

--Quais as filiais e produtos cujos estoque atuais sejam menores que os planejados como estoques mínimos?
select nm_filial, nm_produto from tb_filiais, tb_produtos, tb_estoque
where nr_estoque < nr_estoque_min and tb_filiais.id_filial = tb_estoque.id_filial and tb_produtos.id_produto = tb_estoque.id_produto

--Qual o nome do produto e a somatória de suas qtdes atuais, considereando todos as filiais?
select nm_produto, sum(nr_estoque) as 'Quantidade em estoque' from tb_produtos,tb_estoque
where tb_produtos.id_produto = tb_estoque.id_produto
group by nm_produto

--Idem acima, porém com a qtdes agrupadas por filial?
select nm_filial, nm_produto, sum(nr_estoque) as 'Quantidade em estoque' from tb_filiais, tb_produtos, tb_estoque
where tb_produtos.id_produto = tb_estoque.id_produto and tb_filiais.id_filial = tb_estoque.id_filial
group by tb_filiais.id_filial, tb_filiais.nm_filial, tb_produtos.nm_produto
--No SQL Server todas as colunas no SELECT que não são agregadas (como SUM, COUNT, etc.) devem estar presentes no GROUP BY.
order by tb_filiais.id_filial



