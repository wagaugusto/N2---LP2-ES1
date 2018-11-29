drop database Padaria

create database Padaria

set dateformat dmy

go

use Padaria

go

create table Funcoes
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null
)

go

create table TiposUsuario
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null,
)

go

create table Usuarios
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null,
Telefone varchar(11) not null,
Email varchar(50) not null,
Funcao int foreign key references Funcoes(ID) not null,
TipoUsuario int foreign key references TiposUsuario(ID) not null,
Login varchar(50) not null,
Senha varchar(50) not null
)

go

create table Cidades
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null,
)

go

create table Clientes
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null,
Telefone varchar(11) not null,
Email varchar(50) not null,
Endereco varchar(50) not null,
Numero varchar(10) not null,
Complemento varchar(50),
Bairro varchar(50) not null,
Cidade_ID int foreign key references Cidades(ID) not null,
CEP varchar(8) not null
)

create table Categorias
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null
)

go

create table Produtos
(
ID int IDENTITY(1,1) primary key not null,
Categoria_ID int foreign key references Categorias(ID) not null,
Descricao varchar(200) not null,
Valor decimal(10,2) not null,
CaminhoFoto varchar(max),
QuantidadeEstoque decimal(10,2) not null,
Inventario bit not null
)

go

create table TiposPedido
(
ID int IDENTITY(1,1) primary key not null,
Nome varchar(50) not null
)

go

create table Pedidos
(
ID int IDENTITY(1,1) primary key not null,
Usuario_ID int foreign key references Usuarios(ID) not null,
TipoPedido_ID int foreign key references TiposPedido(ID) not null,
Cliente_ID int foreign key references Clientes(ID),
Data date not null,
ValorTotal decimal(10,2) not null
)

go

create table ItensPedido
(
ID int IDENTITY(1,1) primary key not null,
Pedido_ID int foreign key references Pedidos(ID) not null,
Produto_ID int foreign key references Produtos(ID) not null,
Quantidade decimal(10,2) not null,
ValorUnitario decimal(10,2) not null
)

go