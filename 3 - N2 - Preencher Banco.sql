use Padaria

go

insert into Funcoes
Values
('Gerente'),
('Operador de caixa'),
('Auxiliar administrativo'),
('Atendente')

go

insert into TiposUsuario
Values
('Operador'),
('Administrador')

go

insert into Usuarios
Values
('Marcos Costa Cardoso','11912665678','mccardoso@padaria.com',1,2,'mcc','123'),
('Paulo Silva Pereira','11912885678','pspereira@padaria.com',2,1,'psp','123'),
('Bruno Cunha Rodrigues','11917347678','bcrodrigues@padaria.com',2,1,'bcr','123'),
('Mateus Oliveira Santos','11912545078','mosantos@padaria.com',2,1,'mos','123'),
('Sarah Almeida Castro','11902305608','sacastro@padaria.com',3,1,'sac','123'),
('Alice Costa Sousa','11910349678','acsousa@padaria.com',3,1,'acs','123'),
('Matilde Martins Dias','11912045078','mmdias@padaria.com',3,1,'mmd','123'),
('Tânia Martins Oliveira','11912983678','tmoliveira@padaria.com',4,1,'tmo','123'),
('Luiza Cardoso Carvalho','11916785678','lccarvalho@padaria.com',4,1,'lcc','123'),
('Melissa Fernandes Barbosa','11914565678','mfbarbosa@padaria.com',4,1,'mfb','123')

go

insert into Cidades
Values
('São Paulo'),
('São Bernardo do Campo'),
('São Caetano do Sul'),
('Santo André'),
('Mauá')

go

insert into Clientes
Values
('Gabrielle Rocha Barros','11912345678','grbarros@gmail.com', 'Rua sete de abril','112','Ap. 77','Centro',1,'09876560'),
('Leila Ribeiro Santos','11965333678','lrsantos@gmail.com','Rua da Moóca','112','','Moóca',1,'09400060'),
('Vitór Barros Silva','11916785678','vbsilva@yahoo.com','Avenida Robert Kennedy','2500','','Assunção',2,'09895500'),
('Julieta Goncalves Melo','11968765678','jgmelo@gmail.com', 'Rua dos Sabiás','401','','Parque dos Passáros',2,'09896560'),
('Letícia Dias Cavalcanti','11990945678','ldcavalcanti@gmail.com','Avenida Goiás','5550','Ap. 96','Centro',3,'09776560'),
('Danilo Melo Alves','11900965678','dmalves@outlook.com','Rua São Caetano','560','','Santa Paula',3,'09777560'),
('Tiago Carvalho Rocha','11912345678','tcrocha@uol.com.br', 'Avenida dos Estados','6025','Ap. 65 - Torre 2','Utinga',4,'09656560'),
('Sophia Ferreira Alves','11965543678','sfalves@gmail.com', 'Rua da Paz','1119','','Jardim do Estádio',4,'09666560'),
('Giovanna Sousa Fernandes','11914565678','gsfernandes@yahoo.com', 'Avenida João Ramalho','457','','Centro',5,'09386560'),
('Vitoria Pinto Ferreira','11965923478','vpferreira@gmail.com', 'Rua João Cesário Simão','44B','Casa 2','Jardim Zaira 8',5,'09345560')

go

insert into Categorias
Values
('Pães'),
('Doces'),
('Bebidas'),
('Salgados'),
('Outros')

go

insert into Produtos
Values
(1,'Pão Francês','15.99',
'Paozinho.jpg',0, 0),
(1,'Pão doce','20.00',
'Paodoce.jpg',0,0),
(2,'Bolo de Chocolate','50.00',
'Bolo.jpg',0,0),
(2,'Chocolate Twix 45gr','3.00',
'Twix.jpg',100, 1),
(3,'Café com leite 300ml','7.00',
'cafezinho.jpg',0,0),
(3,'Cocacola lata 350ml','6.00',
'Cocacola.jpg',50,1),
(4,'Croissant de queijo','12.00',
'Croissant.jpg',0,0),
(4,'Coxinha','5.00',
'Coxinha.jpg',0,0),
(5,'Chaveiro','10.00',
'Chaveiro.jpg',50,1),
(5,'Cabo USB','26.00',
'CaboUSB.jpg',25,1)

go

insert into TiposPedido
Values
('Comanda'),
('Encomenda')

go

set dateformat dmy
insert into Pedidos
Values
(1,1,null,'20/04/2018','0'),
(2,1,null,'21/04/2018','0'),
(3,2,1,'22/04/2018','0'),
(4,1,null,'23/04/2018','0'),
(5,1,null,'24/04/2018','0')

go

insert into ItensPedido
Values
(1,1,1,'15.99'),
(1,2,1,'20.00'),
(2,3,1,'50.00'),
(2,4,1,'3.00'),
(3,5,1,'7.00'),
(3,6,1,'6.00'),
(4,7,1,'12.00'),
(4,8,1,'5.00'),
(5,9,1,'10.00'),
(5,10,1,'26.00')

go

update Pedidos
set ValorTotal = (select dbo.CalculaValorTotalPedido(1))
where Pedidos.ID = 1
go
update Pedidos
set ValorTotal = (select dbo.CalculaValorTotalPedido(2))
where Pedidos.ID = 2
go
update Pedidos
set ValorTotal = (select dbo.CalculaValorTotalPedido(3))
where Pedidos.ID = 3
go
update Pedidos
set ValorTotal = (select dbo.CalculaValorTotalPedido(4))
where Pedidos.ID = 4
go
update Pedidos
set ValorTotal = (select dbo.CalculaValorTotalPedido(5))
where Pedidos.ID = 5
go