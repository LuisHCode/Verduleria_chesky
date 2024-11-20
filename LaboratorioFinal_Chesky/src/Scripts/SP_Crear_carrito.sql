CREATE PROCEDURE CrearCarrito
    @ID_Cliente INT
AS
BEGIN
    INSERT INTO Carrito_de_compras (ID_Cliente, Precio_Total_Productos, Cantidad_Total_productos)
    VALUES (@ID_Cliente, 0, 0);

    SELECT SCOPE_IDENTITY() AS ID_Carrito_Creado;
END;
