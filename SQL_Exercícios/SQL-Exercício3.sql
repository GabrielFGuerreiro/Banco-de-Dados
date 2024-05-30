create table tb_cinemas (id_cinema int primary key, nm_cinema char (30))

insert into tb_cinemas values (1,'cinema 1')
insert into tb_cinemas values (2,'cinema 2')
insert into tb_cinemas values (3,'cinema 3')
insert into tb_cinemas values (4,'cinema 4')
insert into tb_cinemas values (5,'cinema 5')
select * from tb_cinemas


-----//-----
create table tb_generos (id_genero int primary key, nm_genero char (30))

insert into tb_generos values (1,'ação')
insert into tb_generos values (2,'aventura')
insert into tb_generos values (3,'animação')    
insert into tb_generos values (4,'drama')
select * from tb_generos


-----//-----
create table tb_filmes (id_filme int primary key, nm_filme char (30),id_genero int, nr_duracao int
foreign key (id_genero) references tb_generos (id_genero))

insert into tb_filmes values (1,'som da liberdade',1,120)
insert into tb_filmes values (2,'guardiôes da galáxia',2,60)
insert into tb_filmes values (3,'super mario bros',3,150)
insert into tb_filmes values (4,'oppenheimer',4,180)
insert into tb_filmes values (5,'a sociedade da neve',4,115)
select * from tb_filmes


-----//-----
create table tb_salas (id_cinema int, id_sala int, qt_assentos int,in_lotado char(1),qt_assentos_livres int,nm_sala char(30),id_filme int
foreign key (id_filme) references tb_filmes (id_filme),foreign key (id_cinema) references tb_cinemas (id_cinema),primary key (id_cinema,id_sala))

insert into tb_salas values (1,1,100,'S', 0,'sala 1 cinema 1',1)
insert into tb_salas values (1,2, 80,'S', 0,'sala 2 cinema 1',2)
insert into tb_salas values (1,3, 80,'N',15,'sala 3 cinema 1',3)
insert into tb_salas values (2,1, 70,'S', 0,'sala 1 cinema 2',4)
insert into tb_salas values (2,2,150,'N',30,'sala 2 cinema 2',5)
insert into tb_salas values (3,1,140,'S',40,'sala 1 cinema 3',1)
insert into tb_salas values (4,1,100,'S', 0,'sala 1 cinema 4',2)
insert into tb_salas values (5,1, 90,'N',70,'sala 1 cinema 5',3)
select * from tb_salas



--|EXERCÍCIOS|--

--Listar o nome do cinema, da sala e do respectivo filme;
select nm_cinema,nm_sala,nm_filme from tb_cinemas,tb_salas,tb_filmes
where tb_cinemas.id_cinema = tb_salas.id_cinema and tb_filmes.id_filme = tb_salas.id_filme

--O nome do filme que está sendo exibido na sala 2 do cinema 2
select nm_filme from tb_filmes,tb_salas
where id_cinema = 2 and id_sala = 2 and tb_filmes.id_filme = tb_salas.id_filme

--Em que cinema e sala está sendo exibido o filme de maior duração?
select nm_cinema,nm_sala from tb_cinemas,tb_salas,tb_filmes
where nr_duracao = (select max(nr_duracao) from tb_filmes)
and tb_cinemas.id_cinema = tb_salas.id_cinema
and tb_filmes.id_filme = tb_salas.id_filme

--Idem acima para todos os filmes com duração acima da média das durações
select nm_cinema,nm_sala from tb_cinemas,tb_salas,tb_filmes
where nr_duracao > (select avg(nr_duracao) from tb_filmes)
and tb_cinemas.id_cinema = tb_salas.id_cinema
and tb_filmes.id_filme = tb_salas.id_filme

--Qual o cinema e sala possui a menor capacidade em assentos?
select nm_cinema,nm_sala from tb_salas,tb_cinemas
where qt_assentos = (select min(qt_assentos) from tb_salas) and tb_cinemas.id_cinema = tb_salas.id_cinema

--Qual o nome do filme que está sendo exibido na sala acima?
select nm_filme from tb_filmes,tb_salas
where qt_assentos = (select min(qt_assentos) from tb_salas) and tb_filmes.id_filme = tb_salas.id_filme

--Qual o nome do filme, cinema e sala em que está sendo exibido na sala com maior qt de assentos livres?
select nm_filme,nm_cinema,nm_sala from tb_filmes,tb_salas,tb_cinemas
where qt_assentos = (select max(qt_assentos) from tb_salas) and tb_cinemas.id_cinema = tb_salas.id_cinema and tb_filmes.id_filme = tb_salas.id_filme

--Qual o nome do filme que não está sendo exibido em nenhum cinema e sala?
insert into tb_filmes values (6,'novo filme',4,115)
select nm_filme from tb_filmes
where nm_filme not in (select nm_filme from tb_salas,tb_filmes where tb_filmes.id_filme = tb_salas.id_filme)

--Listar o  nome do filme e a qtde de salas em que está sendo exibido.
select nm_filme,count(*) from tb_filmes,tb_salas 
where tb_filmes.id_filme = tb_salas.id_filme
group by nm_filme
--No SQL Server todas as colunas no SELECT que não são agregadas (como SUM, COUNT, etc.) devem estar presentes no GROUP BY.

--Listar o nome do cinema, o nome da sala, o nome do filme e o gênero, para todos os filmes cadastrados.
select nm_cinema,nm_sala,nm_filme,nm_genero from tb_cinemas,tb_salas,tb_filmes,tb_generos
where tb_cinemas.id_cinema = tb_salas.id_cinema and tb_filmes.id_filme = tb_salas.id_filme
and tb_generos.id_genero = tb_filmes.id_genero 