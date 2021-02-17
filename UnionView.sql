create database Palestra
go
use palestra

create table Curso(
Codigo_Curso int not null,
Nome varchar(70) not null,
Sigla varchar(10) not null
primary key(Codigo_Curso)
)

create table Aluno(
Ra char(7) not null,
Nome varchar(250) not null,
Codigo_Curso int not null
primary key(Ra),
foreign key (Codigo_Curso) references Curso(Codigo_Curso)
)

create table Palestrante(
Codigo_Palestrante int identity,
Nome varchar(250) not null,
Empresa varchar(100) not null
primary key(Codigo_Palestrante))

create table Alunos_Inscritos(
Ra char(7) not null,
Codigo_Palestra int not null,
foreign key(Ra) references Aluno(Ra),
foreign key(Codigo_Palestra) references Palestra(Codigo_Palestra),
primary key(Ra,Codigo_Palestra))

create table Palestra(
Codigo_Palestra int identity,
Titulo varchar(MAX) not null,
Carga_Horaria int null,
Data_Palestra datetime not null,
Codigo_Palestrante int not null
primary key(Codigo_Palestra),
foreign key (Codigo_Palestrante) references Palestrante(Codigo_Palestrante)
)


create table Nao_Alunos_Incritos(
Codigo_Palestra int Not Null,
RG varchar(9) not null,
Orgao_Exp char(5) not null,
foreign key(Codigo_Palestra) references Palestra(Codigo_Palestra),
foreign key(RG,Orgao_Exp) references Nao_Aluno(RG, Orgao_Exp),
primary key(Codigo_Palestra,RG,Orgao_Exp))

create table Nao_Aluno(
RG varchar(9) not null,
Orgao_Exp char(5) not null,
Nome varchar(250) not null
primary key(RG, Orgao_Exp))


insert into Curso values(100,'Análise e Desenvolvimento de Sistemas','ADS'),
(101,'Elétrica','ELE'),
(102,'Dança','DAN')

insert into Aluno values
(1111111,'Roberto',100),
(2222222,'Leonardo',100),
(3333333,'Eletro',101),
(4444444,'BOOM',101),
(5555555,'Cris',102),
(6666666,'AHHHHHKL',102)

select * from Aluno

insert into Palestrante values
('Leandro Leonardo','FATEC'),
('Eletrico','BOOM.com'),
('Critahhhhl','ATOLS')

select * from Nao_Aluno

insert into Palestra values
('ProgramaCao',80,GETDATE(),1),
('Gerando 1 bilhao de volts usando uma batata',60,GETDATE(),2),
('Persona dancing: A perspective tier list',50,GETDATE(),3)

insert into Alunos_Inscritos values
(1111111,1),
(2222222,1),
(3333333,2),
(4444444,2),
(5555555,3),
(6666666,3)

select * from Aluno
select * from Palestra

insert into Nao_Aluno values
('123546987','RJ','Ratao da Silva'),
('321654987','SP','Alberto'),
('123456789','SP','Junpei')

insert into Nao_Alunos_Incritos values
(1,'123546987','RJ'),
(2,'321654987','SP'),
(3,'123456789','SP')

create view v_presenca
as
select a.Ra as Num_Documento,a.Nome as Nome_Pessoa, p.Titulo as Titulo_Palestra,p.Codigo_Palestra,
pa.Nome as Nome_Palestrante, p.Carga_Horaria as Carga_Horaria, p.Data_Palestra as Data
from Aluno a, Alunos_Inscritos ai, Palestra p,Palestrante pa
where a.Ra = ai.Ra and ai.Codigo_Palestra = p.Codigo_Palestra and p.Codigo_Palestrante = pa.Codigo_Palestrante
UNION
select (na.RG + ' ' + na.Orgao_Exp) as Num_Documento, na.Nome as Nome_Pessoa, p.Titulo as Titulo_Palestra,p.Codigo_Palestra,
pa.Nome as Nome_Palestrante, p.Carga_Horaria as Carga_Horaria, p.Data_Palestra as Data
from Nao_Aluno na,Nao_Alunos_Incritos nai, Palestra p,Palestrante pa
where na.RG = nai.RG and na.Orgao_Exp = nai.Orgao_Exp and nai.Codigo_Palestra = p.Codigo_Palestra and p.Codigo_Palestrante = pa.Codigo_Palestrante

select * from v_presenca where Codigo_Palestra = 1
Order by Nome_Pessoa