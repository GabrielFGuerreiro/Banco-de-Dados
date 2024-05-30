-- Exercícios inicias com linguagem sql

drop table tb_alunos --exclui a tabela inteira
truncate table tb_alunos --exclui todas as linhas (não gera log, "passado" recuperável)
delete from tb_alunos where id_aluno = 1 --sem o where é igual o truncate (gera log); com where exclui uma linha específica 


create table tb_alunos
(id_aluno char(30) primary key,
nm_aluno char (30),
nr_nota1 float (2),
nr_nota2 float (2),
nr_media float (2),
nm_result char (1),)

select * from tb_alunos

insert into tb_alunos values (1,'aluno1',5,6,0,NULL)
insert into tb_alunos values (2,'aluno2',6,6,0,NULL)
insert into tb_alunos values (3,'aluno3',9,9,0,NULL)
insert into tb_alunos values (4,'aluno4',5,6,0,NULL)
insert into tb_alunos values (5,'aluno5',6,8,0,NULL)


update tb_alunos set nr_media = (nr_nota1 + nr_nota2)/2
select * from tb_alunos where nr_media > 8

select count(*) from tb_alunos where nr_media > 8
select avg (nr_media) from tb_alunos
select max (nr_media) from tb_alunos
select min (nr_media) from tb_alunos
select avg(nr_media) as Média,max(nr_media) as Máximo ,min(nr_media) as Mínimo from tb_alunos

select * from tb_alunos

select nm_aluno,nr_media from tb_alunos where nr_media = (select max (nr_media) from tb_alunos)
select nm_aluno,nr_media from tb_alunos where nr_media = (select min (nr_media) from tb_alunos)
select nm_aluno,nr_media from tb_alunos where nr_media < (select avg (nr_media) from tb_alunos)

update tb_alunos set nm_result = NULL
update tb_alunos set nm_result = 'R' where nr_media < 6
update tb_alunos set nm_result = 'A' where nr_media >= 6

--==================================--

drop table tb_gr_inst

create table tb_gr_inst
(gr_inst int primary key,
nm_grinst char (30),)

insert into tb_gr_inst values (1,'superior completo')
insert into tb_gr_inst values (2,'pós superior completo')
insert into tb_gr_inst values (3,'mestrado completo')
insert into tb_gr_inst values (4,'doutorado completo')
select * from tb_gr_inst


drop table tb_funcionario

create table tb_funcionario
(id_func int primary key,
nm_func char (30),
gr_inst int 
	foreign key (gr_inst) references tb_gr_inst (gr_inst))
	
insert into tb_funcionario values (1,'func1',3)
insert into tb_funcionario values (2,'func2',4)
insert into tb_funcionario values (3,'func3',1)
insert into tb_funcionario values (4,'func4',2)
insert into tb_funcionario values (5,'func5',1)

select * from tb_funcionario

select nm_func from tb_funcionario where gr_inst = 1

--==================================--

create table tb_socios (cd_socio int primary key,nm_socio char (30))

insert into tb_socios values (1,'socio1')
insert into tb_socios values (2,'socio2')
insert into tb_socios values (3,'socio3')
select * from tb_socios


create table tb_dependentes (cd_socio int, cd_dependente int, nm_dependente char (30)
foreign key (cd_socio) references tb_socios (cd_socio)
primary key (cd_socio, cd_dependente))

insert into tb_dependentes values (1,1,'dependente1 do socio1')
insert into tb_dependentes values (1,2,'dependente2 do socio1')
insert into tb_dependentes values (3,1,'dependente1 do socio3')
select * from tb_dependentes

select nm_socio,nm_dependente from tb_socios, tb_dependentes
	where tb_socios.cd_socio = tb_dependentes.cd_socio

--==================================--
drop table tb_proprietario

create table tb_proprietario (cd_prop int primary key,nm_prop char (30))

insert into tb_proprietario values (1,'proprietario1')
insert into tb_proprietario values (2,'proprietario2')
insert into tb_proprietario values (3,'proprietario3')
insert into tb_proprietario values (4,'proprietario4')
insert into tb_proprietario values (5,'proprietario5')
select * from tb_proprietario
select nm_prop as 'proprietarios' from tb_proprietario --lista os proprietários
select count (*) as 'qtde de proprietarios' from tb_proprietarios --mostra quantidade de proprietários



create table tb_aptos (cd_apto int primary key, nm_apto char (30), nr_metragem int, cd_prop int
foreign key (cd_prop) references tb_proprietario (cd_prop))

insert into tb_aptos values (1, 'apartamento1', 100, 1)
insert into tb_aptos values (2, 'apartamento2', 100, 1)
insert into tb_aptos values (3, 'apartamento3', 100, 2)
insert into tb_aptos values (4, 'apartamento4', 100, 4)
insert into tb_aptos values (5, 'apartamento5', 100, 5)
select * from tb_aptos

update tb_aptos set nr_metragem = 80 -- alterar conteúdo da tabela toda
update tb_aptos set nr_metragem = 100 where cd_prop = 1 -- alterar conteúdo da tabela, só do prop 1
update tb_aptos set nr_metragem = 150 where cd_apto = 1 -- alterar conteúdo da tabela, só do apto 1

delete from tb_aptos --exclusão de linha(s) da tabela. Todas as linhas, só fica a estrutura
delete from tb_aptos where cd_apto = 2 --exclusão de linha(s) da tabela com apto = 2

--máximo, mínimo, média, somatória
select max(nr_metragem) from tb_aptos
select min(nr_metragem) from tb_aptos
select avg(nr_metragem) from tb_aptos
select sum(nr_metragem) from tb_aptos
select max(nr_metragem) as 'Máximo',min(nr_metragem) as	'Mínimo',avg(nr_metragem)as 'Média',sum(nr_metragem) as 'Soma'
	   from tb_aptos

--Leitura de duas tabelas
select nm_prop,nm_apto,nr_metragem from tb_proprietario,tb_aptos
	where tb_proprietario.cd_prop = tb_aptos.cd_prop --and tb_proprietario.cd_prop = 1 
			     --PK                    --FK	     --só printa do proprietário 1
		
--Lista o nome do proprietário cujo apto tem a maior metragem
select nm_prop,nr_metragem from tb_proprietario,tb_aptos
	where nr_metragem = (select max(nr_metragem) from tb_aptos)
	and tb_proprietario.cd_prop = tb_aptos.cd_apto

--Listar os nomes dos aptos e sua metragem para todos os aptos cuja metragem seja maior que a media das metragem
select nm_prop,nr_metragem from tb_proprietario,tb_aptos
	where nr_metragem > (select avg(nr_metragem) from tb_aptos)
	and tb_proprietario.cd_prop = tb_aptos.cd_apto

--Somatória com agrupamento
select  cd_prop as 'Proprietário',sum(nr_metragem) as'Total metragem' from tb_aptos
	group by cd_prop

--Excluir as linhas da tabela aptos para o registro para os registros menores que a media
select count(*) from tb_aptos where nr_metragem < (select avg(nr_metragem) from tb_aptos) --saber quantas linhas serão afetadas
delete tb_aptos where nr_metragem < (select avg(nr_metragem) from tb_aptos) 

--Alterar a qntd de metragem para 85 de todos os registros com metragem =
update tb_aptos set nr_metragem = 85 where nr_metragem = (select min(nr_metragem) from tb_aptos) --igual metragem mínima
update tb_aptos set nr_metragem = 85 where nr_metragem = 150 --igual a150

--Excluir todas as informações (das 2 tabelas) do proprietátio = 3
delete from tb_aptos where cd_prop = 3
delete from tb_proprietario where cd_prop = 3

select * from tb_proprietario,tb_aptos --Lista as duas tabelas
