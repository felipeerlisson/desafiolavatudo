CREATE TABLE Cliente(
    Id int NOT NULL PRIMARY KEY Identity,
    Nome varchar(50) NOT NULL,
	Email varchar(100) not null,
	Data_de_Nascimento date not null,
	Telefone int,
	Endere�osID int Foreign key references Endere�o(Id)
);

CREATE TABLE Ve�culo(
    Id int NOT NULL PRIMARY KEY Identity,
    Marca varchar(50) NOT NULL,
	Modelo varchar(100) not null,
	Valor money not null,
	ClienteID int Foreign key references Cliente(Id)
);

CREATE TABLE Concession�ria(
    Id int NOT NULL PRIMARY KEY Identity,
    Nome varchar(50) NOT NULL,
	Endere�oID int not null,
	ClienteID int Foreign key references Cliente(Id)	
);

CREATE TABLE Telefone(
    Id int NOT NULL PRIMARY KEY Identity,
    N�mero varchar(50) NOT NULL,
	Descri��o varchar(100) not null,
);

CREATE TABLE Endere�o(
    Id int NOT NULL PRIMARY KEY Identity,
    Bairro varchar(50) NOT NULL,
	Cidade varchar(100) not null,
	Estado varchar(2) not null,
	N�mero varchar(50) NOT NULL,
	Logradouro varchar(50) NOT NULL,
	Refer�ncia varchar(150) NOT NULL,
	Complemento varchar(100) NOT NULL,
);
ALTER TABLE Ve�culo
ADD Concession�riaID int;

ALTER TABLE Concession�ria
ADD Ve�culoID int;



ALTER TABLE Ve�culo
ADD FOREIGN KEY (Concession�riaID) REFERENCES Concession�ria(Id);

ALTER TABLE Concession�ria
ADD FOREIGN KEY (Endere�oID) REFERENCES Endere�o(Id);

ALTER TABLE Ve�culo
ADD FOREIGN KEY (ClienteID) REFERENCES Cliente(Id);

/*Quais altera��es devemos fazer nessa estrutura para que o cliente consiga
comprar mais de um ve�culo por solicita��o?
Criar uma tabela do tipo ou servi�o ou compra etc e interligar o cliente x solicitou o servi�o x com 
x compras de veiculos etc...
*/
--ENDERE�O
Insert into Endere�o(Bairro, Cidade, Estado,N�mero, Logradouro,Refer�ncia, Complemento)
VALUES ('Carlos Prates','Belo Horizonte','MG',201,'Casa','Em frente a upa Carlos Prates','Apto 404 Bloco E');
Insert into Endere�o(Bairro, Cidade, Estado,N�mero, Logradouro,Refer�ncia, Complemento)
VALUES ('Bom Prates','Belo Horizonte','MG',166,'Apartamento','Em frente a Delegacia Civil','Apto 22 Bloco 1');
Insert into Endere�o(Bairro, Cidade, Estado,N�mero, Logradouro,Refer�ncia, Complemento)
VALUES ('Horto','Belo Horizonte','MG',205,'Loja','Em frente o Banco do Brasil','33');
Insert into Endere�o(Bairro, Cidade, Estado,N�mero, Logradouro,Refer�ncia, Complemento)
VALUES ('12 Joao','Sabara ','MG',22,'Casa','Em frente a upa ','Apt E');
Insert into Endere�o(Bairro, Cidade, Estado,N�mero, Logradouro,Refer�ncia, Complemento)
VALUES ('Bom dosco','Bh','MG',1366,'Apartamento','Em frente a Delegacia federal','Apto 22 ');


--Telefones

Insert Into Telefone(N�mero, Descri��o)
Values('3567-2146','Telefone Fixo');
Insert Into Telefone(N�mero, Descri��o)
Values('9921-4488','Telefone Celular');
Insert Into Telefone(N�mero, Descri��o)
Values('3344-5566','Telefone Fixo');
Insert Into Telefone(N�mero, Descri��o)
Values('2222-2146','Telefone Fixo');
Insert Into Telefone(N�mero, Descri��o)
Values('1111-4488','Telefone Celular');
Insert Into Telefone(N�mero, Descri��o)
Values('1111-5566','Telefone Fixo');

--Cliente
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, Endere�osID)
Values ('Felipe Erlisson','felipeerlisson@hotmail.com','1997/12/03',2,1);
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, Endere�osID)
Values ('Fl�via Rocha','flaviarocha@hotmail.com','1994/05/20',1,2);
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, Endere�osID)
Values ('Erlene ','lene@hotmail.com','1968/1/03',1,2);
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, Endere�osID)
Values ('Dilene Rocha','dedi@hotmail.com','1988/05/20',2,2);

--Ve�culo
Insert Into Ve�culo(Marca, Modelo, Valor, ClienteID)
Values('Chevrolet','Camaro', 80.000,1)
--Concession�ria
Insert into Concession�ria (Nome, Endere�oID,ClienteID)
VALUES ('Bonzai', 3, 1);

--Selecione todas concession�rias e a quantidade de clientes que j� compraram nela
SELECT Concession�ria.Nome, Cliente.Nome
FROM Concession�ria
INNER JOIN Cliente ON Concession�ria.Id = Cliente.Id;

--Selecione todos ve�culos de todas concession�rias

SELECT Concession�ria.Nome, Ve�culo.Marca, Ve�culo.Modelo
FROM Concession�ria
INNER JOIN Ve�culo ON Concession�ria.Id = Ve�culo.Id;

--Selecione os ve�culos mais vendidos por marca OBS N�O FIZ A TABELA MAS SEGUE A L�GICA
SELECT Id, SUM(quantidade) quantidade FROM Ve�culo
GROUP BY Id
ORDER BY quantidade DESC

--Atualize o valor fnal de todos os ve�culos em 10%
update Ve�culo
set valor=Valor*1.1
select * from Ve�culo

--Remova o �ltimo cliente cadastradoDELETE FROM Cliente where
ID = (select max(Id) from Cliente);--Insira um clienteInsert Into Cliente(Nome, Email, Data_de_Nascimento, Telefone, Endere�osID)Values('Michelly','mi@gmail.com','2000/01/17',1,1)--Insira um ve�culo e uma concession�riaInsert Into Ve�culo(Marca,Modelo,Valor,ClienteID,)VALUES('Honda','Civic',55.000,2)Insert Into Concession�ria(Nome,Endere�oID,ClienteID)VALUES ('SolaMotors',1,2)-- Execute uma simula��o de compra de ve�culo com o cliente, ve�culo e concession�ria cadastrado acima/*a tabela compra tem O cliente 1 comprou o veiculo 1 da concession�ria 21 cliente pode comprar 1 ou mais carros mas o carro pertence a apenas 1 cliente*/--Gere um relat�rio de lucratividade por concession�riaSELECT *FROM ClienteFOR JSON AUTO