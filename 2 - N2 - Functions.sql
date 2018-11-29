use Padaria

go

create function CalculaValorTotalPedido (@pedido_id int)
returns decimal (10,2)
as
begin
return (select sum(ValorUnitario*Quantidade) from ItensPedido a
where a.Pedido_ID = @pedido_id)
end

go