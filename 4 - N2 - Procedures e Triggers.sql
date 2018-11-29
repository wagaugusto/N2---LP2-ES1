use Padaria

go

create procedure sp_Login
(@login varchar(50), @senha varchar(50), @resultado varchar(1) output)
as
if ((select senha from Usuarios where login = @login) = @senha)
	set @resultado = 1
else
	set @resultado = 0

go

--Verifica se o nome de usuário já existe
--Caso positivo, cancela a inclusão
--Caso negativo, conclui a inclusão
create trigger trg_IncluirUsuario on Usuarios
for insert as
if ((select count(login) from Usuarios where login = (select Login from inserted)) > 1)
begin
	RAISERROR('Login já em uso!!!', 16, 1)
	ROLLBACK transaction
end

go

--Verifica se o nome de usuário já existe
--Caso positivo, cancela a inclusão
--Caso negativo, conclui a inclusão
create trigger trg_AlterarUsuario on Usuarios
for update as
if ((select count(login) from Usuarios where login = (select Login from inserted)) > 1)
begin
	RAISERROR('Login já em uso!!!', 16, 1)
	ROLLBACK transaction
end

go

--Verifica se existe quantidade suficiente em estoque
--Caso positivo, prossegue com a inclusão e decrementa o estoque
--Caso negativo, desfaz a inclusão
create trigger trg_IncluirItemPedido on ItensPedido
for insert as
if((select Inventario from Produtos where ID = (select Produto_ID from inserted)) = 1)
begin
	if ((select Quantidade from inserted) > 
	(select QuantidadeEstoque from Produtos where ID = (select Produto_ID from inserted)))
	begin
		RAISERROR('Produto não possui quantidade suficiente em estoque!!!', 16, 1)
		ROLLBACK transaction
	end
	else
	begin
		update Produtos
		set QuantidadeEstoque = QuantidadeEstoque - (select Quantidade from inserted)
		where ID = (select Produto_ID from inserted)
	end
end

go

--Devolve itens para o estoque caso um item do pedido seja excluido
create trigger trg_ExcluirItemPedido on ItensPedido
for delete as
begin
	declare @quantidade decimal(10,2),
	@produto_id int;
	declare devolverEstoque cursor for
	select Quantidade, Produto_ID from deleted
	open devolverEstoque
	FETCH NEXT FROM devolverEstoque
	INTO @quantidade, @produto_id
	while @@fetch_Status = 0
	begin
	if((select Inventario from Produtos where ID = @produto_id) = 1)
		begin
			update Produtos
			set QuantidadeEstoque = QuantidadeEstoque + (@quantidade)
			where ID = (@produto_id)
		end
	FETCH NEXT FROM devolverEstoque
	INTO @quantidade, @produto_id
	end
	close devolverEstoque
	deallocate devolverEstoque
end

go

--Trigger para exclusão de Pedido
--Caso não seja possível excluir todos os itens do pedido, desfaz todo o processo.
create trigger trg_ExcluirPedido on Pedidos
instead of delete as
begin try
	begin transaction
		delete from ItensPedido
		where Pedido_ID = (select ID from deleted)
		delete from Pedidos
		where ID = (select ID from deleted)
	commit;
end try
begin catch
	if @@TranCount > 0 -- se alguma coisa foi modificada no banco, o processo é desfeito
	begin
	rollback
	end
	RAISERROR('Não foi possível excluir o pedido!!!', 16, 1)
end catch

go

--Verifica se o usuário foi utilizada para cadastrar algum pedido
--Se positivo impede a exclusão do usuario
--Caso contrário, prossegue com a exclusão
create trigger trg_ExcluirUsuario on Usuarios
instead of delete as
if ((select count(c.ID) from Usuarios c
inner join Pedidos d
on c.ID = d.Usuario_ID
where c.ID = (select ID from deleted)) > 0)
begin
	RAISERROR('Usuário utilizado em pedidos realizados não pode ser excluido!!!', 16, 1)
	ROLLBACK transaction
end
else
begin
delete from Usuarios
where ID = (select ID from deleted)
end

go

--Verifica se o cliente foi utilizada para cadastrar algum pedido
--Se positivo impede a exclusão do cliente
--Caso contrário, prossegue com a exclusão
create trigger trg_ExcluirCliente on Clientes
instead of delete as
if ((select count(c.ID) from Clientes c
inner join Pedidos d
on c.ID = d.Cliente_ID
where c.ID = (select ID from deleted)) > 0)
begin
	RAISERROR('Cliente utilizado em pedidos realizados não pode ser excluido!!!', 16, 1)
	ROLLBACK transaction
end
else
begin
delete from Clientes
where ID = (select ID from deleted)
end

go

--Verifica se o produto foi utilizada para cadastrar algum pedido
--Se positivo impede a exclusão do produto
--Caso contrário, prossegue com a exclusão
create trigger trg_ExcluirProduto on Produtos
instead of delete as
if ((select count(c.ID) from Produtos c
inner join ItensPedido d
on c.ID = d.Produto_ID
where c.ID = (select ID from deleted)) > 0)
begin
	RAISERROR('Produto utilizado em pedidos realizados não pode ser excluido!!!', 16, 1)
	ROLLBACK transaction
end
else
begin
delete from Produtos
where ID = (select ID from deleted)
end

go

