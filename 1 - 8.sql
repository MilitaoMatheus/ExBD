create database dbDistribuidora1;
use dbDistribuidora1;

create table tbCliente(
ID int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd smallint not null,
CompEnd varchar(50),
CepCli numeric(8) not null
);

create table tbClientePF(
CPF numeric(11) primary key,
RG numeric(9) not null,
RG_Dig char(1) not null,
Nasc date not null,
ID int not null
);

create table tbClientePJ(
CNPJ numeric(14) primary key,
IE numeric(11) not null unique,
ID int not null
);
create table tbEndereco(
logradouro varchar(200) not null,
CEP numeric(8) primary key,
BairroID int not null,
CidadeID int not null,
UFID int not null
);
create table tbBairro(
BairroID int primary key auto_increment,
Bairro varchar(200) not null
);

create table tbCidade(
CidadeID int primary key auto_increment,
Cidade varchar(200) not null
);

create table tbEstado(
UFID int primary key auto_increment,
UF char(2) not null
);

create table tbFornecedor(
	Cod int primary key auto_increment,
    CNPJ decimal (14,0) unique,
    Nome varchar (200) not null,
    Telefone decimal (11,0)
);
create table tbProduto(
CodigoBarras numeric(14) primary key,
Nome varchar(200) not null,
Valor decimal(8,3),
Qtd int
);

create table tbCompra(
	NotaFiscal int primary key,
    DataCompra date not null,
    ValorTotal decimal (8,3) not null,
    QtdTotal int not null,
    Cod int
);

create table tbItemCompra (
	NotaFiscal int,
    CodigoBarras decimal (11,0),
    ValorItem decimal (8,3) not null,
    Qtd int not null,
    primary key (NotaFiscal, CodigoBarras)
);
create table tbVenda(
	NumeroVenda int primary key,
    DataVenda date not null,
    TotalVenda decimal (8,3) not null,
    ID_Cli int not null,
	NF int
);

create table tbItemVenda(
	NumeroVenda int,
    CodigoBarras decimal (14,0),
    ValorItem decimal (8,3) not null,
    Qtd int not null,
    primary key (NumeroVenda, CodigoBarras)
);


create table tbNota_Fiscal(
	NF int primary key,
    TotalNota decimal (8,3) not null,
    DataEmissao date not null
);

alter table tbClientePF add foreign key (ID) references tbCliente(ID);
alter table tbClientePJ add foreign key (ID) references tbCliente(ID);
alter table tbCliente add foreign key (CepCli) references tbEndereco(CEP);

alter table tbEndereco add foreign key (BairroID) references tbBairro(BairroID);
alter table tbEndereco add foreign key (CidadeID) references tbCidade(CidadeID);
alter table tbEndereco add foreign key (UFID) references tbEstado(UFID);

alter table tbCompra add foreign key (Cod) references tbFornecedor (Cod);
alter table tbItemCompra add foreign key (NotaFiscal) references tbCompra (NotaFiscal);
alter table tbItemCompra add foreign key (CodigoBarras) references tbProduto (CodigoBarras);

alter table tbVenda add foreign key (NF) references tbNota_Fiscal (NF);
alter table tbVenda add foreign key (ID_Cli) references tbCliente (ID);

alter table tbItemVenda add foreign key (NumeroVenda) references tbVenda (NumeroVenda);
alter table tbItemVenda add foreign key (CodigoBarras) references tbProduto (CodigoBarras);

-- Exercicio DML --

-- Ex 1
insert into tbFornecedor (Cod, Nome, CNPJ, Telefone)
values
(default, 'Revenda Chico Loco', 1245678937123, 11934567897),
(default, 'José Faz Tudo S/A', 1345678937123, 11934567898),
(default, 'Vadalto Entregas', 1445678937123, 11934567899),
(default,'Astrogildo das Estrela', 1545678937123, 1193457800),
(default,'Amoroso e Doce', 1645678937123, 11934567801),
(default,'Marcelo Dedal', 1745678937123, 11934567802),
(default,'Fransciscano Cachaça', 1845678937123, 11934567803),
(default,'Joãozinho Chupeta', 1945678937123, 11934567804);
select * from tbFornecedor;

-- Ex 2 
delimiter &&
create procedure spinsertCidade(vCidadeID int, vCidade varchar (200))
begin
insert into tbCidade(CidadeID, Cidade)
values(vCidadeID,vCidade);
end &&

call spinsertCidade(1, 'Rio de Janeiro'); 
call spinsertCidade(2, 'São Carlos');
call spinsertCidade(3, 'Campinas');
call spinsertCidade(4, 'Franco da Rocha');
call spinsertCidade(5, 'Osasco');
call spinsertCidade(6, 'Pirituba');     
call spinsertCidade(7, 'Lapa');
call spinsertCidade(8, 'Ponta Grossa'); 
select * from tbCidade;

-- Ex 3
delimiter &&
create procedure spinsertEstado(vUFID int, vUF char (2))
begin
insert into tbEstado(UFID, UF)
values(vUFID,vUF);
end &&

call spinsertEstado(1, 'SP'); 
call spinsertEstado(2, 'RJ');
call spinsertEstado(3, 'RS');

-- Ex 4
delimiter &&
create procedure spinsertBairro(vBairroID int, vBairro varchar (200))
begin
insert into tbBairro(BairroID, Bairro)
values(vBairroID,vBairro);
end &&

call spinsertBairro(1, 'Aclimação'); 
call spinsertBairro(2, 'Capão Redondo');
call spinsertBairro(3, 'Pirituba');
call spinsertBairro(4, 'Liberdade');

-- Ex 5 
delimiter &&
create procedure spinsertproduto(vCodigoBarras numeric(14), vNome varchar (200), vValor decimal (8,3), vQtd int)
begin
insert into tbProduto(CodigoBarras, Nome, Valor, Qtd)
values(vCodigoBarras, vNome, vValor, vQtd);
end &&

call spinsertproduto(12345678910111,'rei de papel mache', 54.61, 120);
call spinsertproduto(12345678910112,'bolinha de sabao', 100.45, 120);
call spinsertproduto(12345678910113,'carro bate', 44.00, 120);
call spinsertproduto(12345678910114,'bola furada', 10.00, 120);
call spinsertproduto(12345678910115,'maçã laranja', 99.44, 120);
call spinsertproduto(12345678910116,'boneco do hitler', 124.00, 200);
call spinsertproduto(12345678910117,'farinha de suruí', 50.00, 200);
call spinsertproduto(12345678910118,'zelador de cemitério', 24.50, 100);

-- Ex 6 
delimiter &&
create procedure spinsertendereco(vlogradouro varchar(200), vCEP numeric(8), vBairroID int, vCidadeID int, vUFID int)
begin
insert into tbEndereco(logradouro, CEP, BairroID, CidadeID, UFID)
values (vlogradouro, vCEP, vBairroID, vCidadeID, vUFID);
end &&

-- Inserção de dados que serão necessários para o exercício 6
-- Usar o insert é uma maneira mais rápida de fazer tal ato
insert into tbBairro(BairroID, Bairro)
values (5, 'Lapa'),
(6, 'consolação'),
(7, 'penha'),
(8, 'barra funda'),
(9, 'Jardim Santa Isabel');

insert into tbCidade(CidadeID, Cidade)
values (9, 'São Paulo'),
(10, 'Barra Mansa'),
(11, 'Cuiabá');

insert into tbEstado(UFID, UF)
values (4, 'MT');

call spinsertendereco('rua da federal', 12345050, 5, 9, 1);
call spinsertendereco('Av Brasil', 12345051, 5, 3, 1);
call spinsertendereco('rua liberdade', 12345052, 6, 9, 1);
call spinsertendereco('Av Paulista', 12345053, 7, 1, 2);
call spinsertendereco('rua ximbú', 12345054, 7, 1, 2);
call spinsertendereco('rua piu XI', 12345055, 7, 3, 1);
call spinsertendereco('rua chocolate', 12345056, 1, 10, 2);
call spinsertendereco('rua pão na chapa', 12345057, 8, 8, 3);
select * from tbEndereco;

-- ex 7
-- Criação de um SP para poder se juntar a tbClientePF
delimiter &&
create procedure spInsertCliente(vNomeCli varchar(200), vNumEnd smallint, vCompEnd varchar(50), vCepCli decimal(8,0))
begin
insert into tbCliente(NomeCli, NumEnd, CompEnd, CepCli)
values(vNomeCli, vNumEnd, vCompEnd, vCepCli);
end &&

delimiter &&
create procedure spInsertClientePF(vCpf decimal(11,0), vRg decimal(9,0), vRg_dig char(1), vNasc date, vId int)
begin
insert into tbClientePF(CPF, RG, RG_Dig, Nasc, ID)
values(vCpf, vRg, vRg_dig, vNasc, vId);
end &&

select * from tbEndereco;
call spinsertendereco('rua veia', 12345059, 9, 11, 4);
call spinsertendereco('rua nova', 12345058, 9, 11, 4);

select * from tbBairro;
select * from tbCidade;
select * from tbEstado;

call spInsertCliente('Pimpão', 325, Null, 12345051);
call spInsertClientePF(12345678911, 12345678, 0, '2000-10-12', 1);
select * from tbClientePF;

call spInsertCliente('Disney Chaplin', 89, 'Ap. 12', 12345053);
call spInsertClientePF(12345678912, 12345679, 0, '2001-11-21', 2);

call spInsertCliente('Marciano', 744, null, 12345054);
call spInsertClientePF(12345678913, 12345680, 0, '2001-06-01', 3);

call spInsertCliente('Lança Perfume', 128, null, 12345059);
call spInsertClientePF(12345678914, 12345681, 'X', '2004-04-05', 4);

call spInsertCliente('Remédio Amargo', 2585, null, 12345058);
call spInsertClientePF(1234567815, 12345682, 0, '2002-07-15', 5);

select * from tbCliente;
select * from tbClientePF;
select * from tbEndereco;

-- ex 8 
-- Insert's na tabela tbBairro, tbCidade e tbEstado para o ex 8
insert into tbBairro(BairroID, Bairro)
values (10, 'Sei lá');
insert into tbCidade(CidadeID, Cidade)
values (12, 'Recife');
insert into tbEstado(UFID, UF)
values (5, 'PE');
-- call para a tbEndereco
call spinsertendereco('rua dos amores', 12345060, 10, 12, 5);

delimiter &&
create procedure spInsertClientePJ(vCNPJ decimal(14,0), vIE decimal(11,0), vID int)
begin
insert into tbClientePJ(CNPJ, IE, ID)
values (vCNPJ, vIE, vID);
end &&

call spinsertcliente('paganada', 159, null, 12345051);
call spInsertClientePJ(12345678912345, 98765432198, 6);

call spinsertcliente('caloteando', 69, null, 12345053);
call spInsertClientePJ(12345678912346, 98765432199, 7);

call spinsertcliente('semgrana', 189, null, 12345060);
call spInsertClientePJ(12345678912347, 98765432100, 8);

call spinsertcliente('cemreais', 5024, 'sala 23', 12345060);
call spInsertClientePJ(12345678912348, 98765432101, 9);

call spinsertcliente('durango', 1254, null, 12345060);
call spInsertClientePJ(12345678912349, 98765432102, 10);

select * from tbEndereco;
select * from tbCliente;
select * from tbClientePJ;