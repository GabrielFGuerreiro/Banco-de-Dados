--- criação da tabela de status das provas ---
create table tb_status1 (cd_status int primary key, ds_status char (30))
insert into tb_status1 values (0,'não realizada')
insert into tb_status1 values (1,'aprovado')
insert into tb_status1 values (2,'reprovado')
select * from tb_status1


--- criação da tabela alunos ---
create table tb_alunos (cd_aluno int primary key, nm_aluno char (30))
insert into tb_alunos values (1,'aluno 1')
insert into tb_alunos values (2,'aluno 2')
insert into tb_alunos values (3,'aluno 3')
insert into tb_alunos values (4,'aluno 4')
insert into tb_alunos values (5,'aluno 5')
select * from tb_alunos


--- criação da tabela disciplinas ---

create table tb_disciplinas (cd_disciplina int primary key, nm_disciplina char (30))
insert into tb_disciplinas values (1, 'disciplina 1')
insert into tb_disciplinas values (2, 'disciplina 2')
insert into tb_disciplinas values (3, 'disciplina 3')
insert into tb_disciplinas values (4, 'disciplina 4')
insert into tb_disciplinas values (5, 'disciplina 5')
insert into tb_disciplinas values (6, 'disciplina 6')
insert into tb_disciplinas values (7, 'disciplina 7')
insert into tb_disciplinas values (8, 'disciplina 8')
insert into tb_disciplinas values (9, 'disciplina 9')
insert into tb_disciplinas values (10, 'disciplina 10')
select * from tb_disciplinas


--- criação da tabela provas ---
create table tb_provas(cd_prova int primary key,
cd_aluno int foreign key references tb_alunos (cd_aluno),
cd_disciplina int foreign key references tb_disciplinas(cd_disciplina),vl_nota int,
cd_status int foreign key references tb_status1 (cd_status))

insert into tb_provas values (1,1,1,0,0)
insert into tb_provas values (2,1,2,0,0)
insert into tb_provas values (3,2,1,8,1)
insert into tb_provas values (4,1,2,9,1)
insert into tb_provas values (5,2,2,10,1)
insert into tb_provas values (6,2,3,10,1)
insert into tb_provas values (7,2,4,0,0)
insert into tb_provas values (8,3,4,0,0)
insert into tb_provas values (9,3,5,9,1)
insert into tb_provas values (10,1,6,6,1)
insert into tb_provas values (11,4,7,6,1)
insert into tb_provas values (12,4,7,3,2)
insert into tb_provas values (13,2,8,4,2)
insert into tb_provas values (14,2,8,2,2)
insert into tb_provas values (15,1,1,9,1)
insert into tb_provas values (16,4,9,0,0)
insert into tb_provas values (17,4,7,0,0)
insert into tb_provas values (18,3,8,10,1)
select * from tb_provas


--|EXERCÍCIOS|--

--Selecionar o código da prova,nome do aluno, da disciplina e o status de todas as provas
select cd_prova,nm_aluno,nm_disciplina,vl_nota,ds_status from tb_provas,tb_alunos,tb_disciplinas,tb_status1
where tb_alunos.cd_aluno = tb_provas.cd_aluno and tb_disciplinas.cd_disciplina = tb_provas.cd_disciplina and tb_status1.cd_status = tb_provas.cd_status

--Idem anterior, mas cuja nota foi a maior da base
select cd_prova,nm_aluno,nm_disciplina,vl_nota,ds_status from tb_provas,tb_alunos,tb_disciplinas,tb_status1
where tb_alunos.cd_aluno = tb_provas.cd_aluno
and tb_disciplinas.cd_disciplina = tb_provas.cd_disciplina
and tb_status1.cd_status = tb_provas.cd_status
and vl_nota = (select max(vl_nota) from tb_provas)

--Idem anterior, mas cuja nota foi a menor da base e com a prova realizada
select cd_prova,nm_aluno,nm_disciplina,vl_nota,ds_status from tb_provas,tb_alunos,tb_disciplinas,tb_status1
where tb_alunos.cd_aluno = tb_provas.cd_aluno
and tb_disciplinas.cd_disciplina = tb_provas.cd_disciplina
and tb_status1.cd_status = tb_provas.cd_status
and vl_nota = (select min(vl_nota) from tb_provas where cd_status <> 0)

--Listar a quantidade de provas de cada disciplina de acordo com seu código
select cd_disciplina as 'Código da disciplina',count (*) as 'Qnt de provas' from tb_provas
group by cd_disciplina

--Listar a quantidade de provas de cada disciplina de acordo com seu nome
select nm_disciplina as 'Nome da disciplina',count (*) as 'Qnt de provas' from tb_disciplinas, tb_provas
where tb_disciplinas.cd_disciplina = tb_provas.cd_disciplina
group by nm_disciplina
--No SQL Server todas as colunas no SELECT que não são agregadas (como SUM, COUNT, etc.) devem estar presentes no GROUP BY.

