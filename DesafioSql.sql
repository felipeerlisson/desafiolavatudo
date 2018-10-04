CREATE TABLE Cliente(
    Id int NOT NULL PRIMARY KEY Identity,
    Nome varchar(50) NOT NULL,
	Email varchar(100) not null,
	Data_de_Nascimento date not null,
	Telefone int,
	EndereçosID int Foreign key references Endereço(Id)
);

CREATE TABLE Veículo(
    Id int NOT NULL PRIMARY KEY Identity,
    Marca varchar(50) NOT NULL,
	Modelo varchar(100) not null,
	Valor money not null,
	ClienteID int Foreign key references Cliente(Id)
);

CREATE TABLE Concessionária(
    Id int NOT NULL PRIMARY KEY Identity,
    Nome varchar(50) NOT NULL,
	EndereçoID int not null,
	ClienteID int Foreign key references Cliente(Id)	
);

CREATE TABLE Telefone(
    Id int NOT NULL PRIMARY KEY Identity,
    Número varchar(50) NOT NULL,
	Descrição varchar(100) not null,
);

CREATE TABLE Endereço(
    Id int NOT NULL PRIMARY KEY Identity,
    Bairro varchar(50) NOT NULL,
	Cidade varchar(100) not null,
	Estado varchar(2) not null,
	Número varchar(50) NOT NULL,
	Logradouro varchar(50) NOT NULL,
	Referência varchar(150) NOT NULL,
	Complemento varchar(100) NOT NULL,
);
ALTER TABLE Veículo
ADD ConcessionáriaID int;

ALTER TABLE Concessionária
ADD VeículoID int;



ALTER TABLE Veículo
ADD FOREIGN KEY (ConcessionáriaID) REFERENCES Concessionária(Id);

ALTER TABLE Concessionária
ADD FOREIGN KEY (EndereçoID) REFERENCES Endereço(Id);

ALTER TABLE Veículo
ADD FOREIGN KEY (ClienteID) REFERENCES Cliente(Id);

/*Quais alterações devemos fazer nessa estrutura para que o cliente consiga
comprar mais de um veículo por solicitação?
Criar uma tabela do tipo ou serviço ou compra etc e interligar o cliente x solicitou o serviço x com 
x compras de veiculos etc...
*/
--ENDEREÇO
Insert into Endereço(Bairro, Cidade, Estado,Número, Logradouro,Referência, Complemento)
VALUES ('Carlos Prates','Belo Horizonte','MG',201,'Casa','Em frente a upa Carlos Prates','Apto 404 Bloco E');
Insert into Endereço(Bairro, Cidade, Estado,Número, Logradouro,Referência, Complemento)
VALUES ('Bom Prates','Belo Horizonte','MG',166,'Apartamento','Em frente a Delegacia Civil','Apto 22 Bloco 1');
Insert into Endereço(Bairro, Cidade, Estado,Número, Logradouro,Referência, Complemento)
VALUES ('Horto','Belo Horizonte','MG',205,'Loja','Em frente o Banco do Brasil','33');
Insert into Endereço(Bairro, Cidade, Estado,Número, Logradouro,Referência, Complemento)
VALUES ('12 Joao','Sabara ','MG',22,'Casa','Em frente a upa ','Apt E');
Insert into Endereço(Bairro, Cidade, Estado,Número, Logradouro,Referência, Complemento)
VALUES ('Bom dosco','Bh','MG',1366,'Apartamento','Em frente a Delegacia federal','Apto 22 ');


--Telefones

Insert Into Telefone(Número, Descrição)
Values('3567-2146','Telefone Fixo');
Insert Into Telefone(Número, Descrição)
Values('9921-4488','Telefone Celular');
Insert Into Telefone(Número, Descrição)
Values('3344-5566','Telefone Fixo');
Insert Into Telefone(Número, Descrição)
Values('2222-2146','Telefone Fixo');
Insert Into Telefone(Número, Descrição)
Values('1111-4488','Telefone Celular');
Insert Into Telefone(Número, Descrição)
Values('1111-5566','Telefone Fixo');

--Cliente
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, EndereçosID)
Values ('Felipe Erlisson','felipeerlisson@hotmail.com','1997/12/03',2,1);
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, EndereçosID)
Values ('Flávia Rocha','flaviarocha@hotmail.com','1994/05/20',1,2);
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, EndereçosID)
Values ('Erlene ','lene@hotmail.com','1968/1/03',1,2);
Insert into Cliente (Nome, Email, Data_de_Nascimento, Telefone, EndereçosID)
Values ('Dilene Rocha','dedi@hotmail.com','1988/05/20',2,2);

--Veículo
Insert Into Veículo(Marca, Modelo, Valor, ClienteID)
Values('Chevrolet','Camaro', 80.000,1)
--Concessionária
Insert into Concessionária (Nome, EndereçoID,ClienteID)
VALUES ('Bonzai', 3, 1);

--Selecione todas concessionárias e a quantidade de clientes que já compraram nela
SELECT Concessionária.Nome, Cliente.Nome
FROM Concessionária
INNER JOIN Cliente ON Concessionária.Id = Cliente.Id;

--Selecione todos veículos de todas concessionárias

SELECT Concessionária.Nome, Veículo.Marca, Veículo.Modelo
FROM Concessionária
INNER JOIN Veículo ON Concessionária.Id = Veículo.Id;

--Selecione os veículos mais vendidos por marca OBS NÃO FIZ A TABELA MAS SEGUE A LÓGICA
SELECT Id, SUM(quantidade) quantidade FROM Veículo
GROUP BY Id
ORDER BY quantidade DESC

--Atualize o valor fnal de todos os veículos em 10%
update Veículo
set valor=Valor*1.1
select * from Veículo

--Remova o último cliente cadastradoDELETE FROM Cliente where
ID = (select max(Id) from Cliente);--Insira um clienteInsert Into Cliente(Nome, Email, Data_de_Nascimento, Telefone, EndereçosID)Values('Michelly','mi@gmail.com','2000/01/17',1,1)--Insira um veículo e uma concessionáriaInsert Into Veículo(Marca,Modelo,Valor,ClienteID,)VALUES('Honda','Civic',55.000,2)Insert Into Concessionária(Nome,EndereçoID,ClienteID)VALUES ('SolaMotors',1,2)-- Execute uma simulação de compra de veículo com o cliente, veículo e concessionária cadastrado acima/*a tabela compra tem O cliente 1 comprou o veiculo 1 da concessionária 21 cliente pode comprar 1 ou mais carros mas o carro pertence a apenas 1 cliente*/--Gere um relatório de lucratividade por concessionáriaSELECT *FROM ClienteFOR JSON AUTO