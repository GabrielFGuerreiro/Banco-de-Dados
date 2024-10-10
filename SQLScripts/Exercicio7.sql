-- Tabela sócios
create table tb_socio_propri (
    id_socio int primary key, 
	nm_socio char (50), 
	qt_tempo int
);

insert into tb_socio_propri values 
(10, 'Socio1', 1),
(20, 'Socio2', 8), 
(30, 'Socio3', 3), 
(40, 'Socio4', 9), 
(50, 'Socio5', 4);

-- Tabela dependentes
create table tb_dependente(
    id_dependente int primary key, 
    nm_dependente char(50), 
    id_socio int,
    foreign key (id_socio) references tb_socio_propri(id_socio)
	--ou declarar FK na definição da coluna --> id_socio int references tb_socio_propri(id_socio)
);

insert into tb_dependente values 
(1, 'Dependente1', 50),
(2, 'Dependente2', 30),
(3, 'Dependente3', 20),
(4, 'Dependente4', 50),
(5, 'Dependente5', 30),
(6, 'Dependente6', 20),
(7, 'Dependente7', 40),
(8, 'Dependente8', 50),
(9, 'Dependente9', 30),
(10, 'Dependente10', 30)

--1. Selecione todos os nomes dos sócios proprietários
select nm_socio from tb_socio_propri

--2. Selecione todos os nomes dos sócios proprietários e seus dependentes, caso o campo qt_tempo seja maior que 3 e menor que 7
select nm_socio, nm_dependente from tb_socio_propri, tb_dependente
	where tb_socio_propri.id_socio = tb_dependente.id_socio and qt_tempo > 3 and qt_tempo < 7

--3. Selecione todas as informções existentes (socio e dependentes) quando id_socio = 40 e qt_tempo > 7
select * from tb_socio_propri,tb_dependente 
	where tb_socio_propri.id_socio = tb_dependente.id_socio and tb_dependente.id_socio = 40 and qt_tempo > 7

--4. Quantos dependentes tem o sócio proprietário com id_socio = 20
select count(*) from tb_dependente where id_socio = 20 
--Com os nomes --> select nm_dependente,count(*) from tb_dependente where id_socio = 20 group by nm_dependente

--5. Selecione o id, nome e qt_tempo dos sócios proprietários e os nomes dos seus respectivos dependentes
select tb_dependente.id_socio, nm_socio, qt_tempo, nm_dependente from tb_socio_propri, tb_dependente
	where tb_socio_propri.id_socio = tb_dependente.id_socio

--6. Informar o código do sócio e a qtde de dependentes existentes para cada sócio
select id_socio, count(*) as 'Quantidade de dependentes' from tb_dependente group by id_socio