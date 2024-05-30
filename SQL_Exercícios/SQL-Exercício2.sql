drop table tb_nacionalidades

create table tb_nacionalidades (id_nacionalidade int primary key, nm_nacionalidade char (30))

insert into tb_nacionalidades values (1, 'Brasileira')
insert into tb_nacionalidades values (2, 'Britânica')
insert into tb_nacionalidades values (3, 'Americana')
insert into tb_nacionalidades values (4, 'Italiana')

-----//-----
drop table tb_autores

create table tb_autores (id_autor int primary key, nm_autor char (30), id_nacionalidade int
foreign key (id_nacionalidade) references tb_nacionalidades (id_nacionalidade))

insert into tb_autores values (1, 'George Orwell', 2)
insert into tb_autores values (2, 'Monteiro Lobato', 1)
insert into tb_autores values (3, 'Machado de Assis', 1)
insert into tb_autores values (4, 'Carlos Drummond de Andrade', 1)
insert into tb_autores values (5, 'Lygia Fagundes Telles', 1)
insert into tb_autores values (6, 'Ernest Hemingway', 3)
insert into tb_autores values (7, 'Dante Alighieri', 4)
select * from tb_autores

-----//-----
drop table tb_livros

create table tb_livros (id_livro int primary key, nm_livro char (50), nr_publicacao int, id_autor int
foreign key (id_autor) references tb_autores (id_autor))

insert into tb_livros values (1, '1984', 1949, 1)
insert into tb_livros values (2, 'A Revolução dos Bichos', 1945, 1)
insert into tb_livros values (3, 'Tudo o que é Sólido se Desmancha', 1936, 1)
insert into tb_livros values (4, 'O Sítio do Picapau Amarelo', 1920, 2)
insert into tb_livros values (5, 'Geografia de Dona Benta', 1935, 2)
insert into tb_livros values (6, 'Memória Póstumas de Brás Cubas', 1981, 3)
insert into tb_livros values (7, 'Quincas Borba', 1991, 3)
insert into tb_livros values (8, 'Alguma Poesia', 1930, 4)
insert into tb_livros values (9, 'O Velho e o Mar', 1952, 6)
insert into tb_livros values (10, 'A Divina Comédia', 1920, 7)

--1 Selecionar o nome dos autores da tabela autores
select nm_autor as 'Nomes dos Autores' from tb_autores 

--2 Quantos autores estão registardos na tabela autores?
select count (*) as 'Quantidade de Autores' from tb_autores

--3 Listar o nome do autor e nome do livro para todos os autores existentes
select nm_autor as 'Nomes autores', nm_livro as 'Nomes Livros' from tb_autores, tb_livros 
	where tb_autores.id_autor = tb_livros.id_autor --Quebrar "distributiva" entre tabelas

--4.0 Quantos livros existem na base cujos autores são brasileiros considerando apenas livros publicados em 1920
select count (*) as 'Quantidade de Livros feitos por Brasileiros em 1920' from tb_livros, tb_autores
	where id_nacionalidade = 1 and nr_publicacao = 1920 and tb_livros.id_autor = tb_autores.id_autor

--4.1 Listar o nome do autor e nome do livro para a questão acima
select nm_autor,nm_livro from tb_livros, tb_autores
	where id_nacionalidade = 1 and nr_publicacao = 1920 and tb_livros.id_autor = tb_autores.id_autor

--5 Listar o nome do autor, nome do livro e a nacionalidade para todos os livros existentes na base
select nm_autor as 'Nome dos Autores', nm_nacionalidade as 'Nacionalidades', nm_livro as 'Nomes do Livros' from tb_autores, tb_nacionalidades, tb_livros
	where tb_autores.id_autor = tb_livros.id_autor and tb_autores.id_nacionalidade = tb_nacionalidades.id_nacionalidade --QUebrar a distributivas das duas relações: tb_autores/tb_livros e tb_autores/tb_nacionalidades

--6 Idem acima para a publicação mais antiga
select nm_autor as 'Nome dos Autores', nm_nacionalidade as 'Nacionalidades', nm_livro as 'Nomes do Livros' from tb_autores, tb_nacionalidades, tb_livros
	where tb_autores.id_autor = tb_livros.id_autor and tb_autores.id_nacionalidade = tb_nacionalidades.id_nacionalidade and nr_publicacao = (select min(nr_publicacao) from tb_livros) 

--7 Listar o nome do autor, nome do livro e a nacionalidade com a publicação mais recente 
select nm_autor as 'Nome dos Autores', nm_nacionalidade as 'Nacionalidades', nm_livro as 'Nomes do Livros' from tb_autores, tb_nacionalidades, tb_livros
	where tb_autores.id_autor = tb_livros.id_autor and tb_autores.id_nacionalidade = tb_nacionalidades.id_nacionalidade and nr_publicacao = (select max(nr_publicacao) from tb_livros) 

--8 Excluir o livro com id=10 e todos os registro selecionados
delete from tb_livros where id_livro = 10  --delete tb_livros where id_livro = 10

--9 Excluir a nacionalidade = 1 e todos os seus registros relacionados. Nacio. esta linkada a outros registros, ent é preciso excluí-los 1º, de forma contrária
delete from tb_livros where id_autor in (2,3,4,5) --Exclui os registros da tb_livros dos autores com nacio=1 
delete from tb_autores where id_nacionalidade = 1 --Exclui os registros da tb_autores dos autores com nacio=1
delete from tb_nacionalidades where id_nacionalidade = 1 --Exclui o registro da tb_nacionalidades com nacio=1

--10 Reconstruir a base original, listando todos os registros de todas as tabelas


--11.0 Quais os nomes dos autores que não tem livros na base de livros?
select nm_autor from tb_autores 
	where not exists (select 1 from tb_livros where tb_autores.id_autor = tb_livros.id_autor)

--11.1 Nomes que tem na base.
select nm_autor from tb_autores 
	where exists (select 1 from tb_livros where tb_autores.id_autor = tb_livros.id_autor)
	
--12 Listar os nomes dos autores e a quantidade de livros de cada um, de formma decrescente
select nm_autor,count(*) as 'Quantidade de livros' from tb_autores,tb_livros
	where tb_autores.id_autor = tb_livros.id_autor 
		group by nm_autor order by count(*) desc
--No SQL Server todas as colunas no SELECT que não são agregadas (como SUM, COUNT, etc.) devem estar presentes no GROUP BY.