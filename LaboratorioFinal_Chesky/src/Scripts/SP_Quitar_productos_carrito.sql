CREATE PROCEDURE SP_QuitarProductoDelCarrito
    @ID_Carrito_de_compras INT,
    @ID_Producto INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Variables para almacenar la cantidad y el precio total del producto a eliminar
        DECLARE @CantidadProducto INT;
        DECLARE @PrecioTotalProducto FLOAT;

        -- Obtener los valores antes de eliminar el producto
        SELECT 
			@CantidadProducto = Cantidad_producto, 
            @PrecioTotalProducto = Precio_total_cantidad
        FROM 
			Detalles_Carrito
        WHERE
			ID_Carrito_de_compras = @ID_Carrito_de_compras AND ID_Producto = @ID_Producto;

        -- Eliminar el producto de Detalles_Carrito
        DELETE FROM
			Detalles_Carrito
        WHERE 
			ID_Carrito_de_compras = @ID_Carrito_de_compras AND ID_Producto = @ID_Producto;

        -- Actualizar los totales en Carrito_de_compras
        UPDATE Carrito_de_compras
        SET 
            Cantidad_Total_productos = Cantidad_Total_productos - @CantidadProducto,
            Precio_Total_Productos = Precio_Total_Productos - @PrecioTotalProducto
        WHERE
			ID_Carrito_de_compras = @ID_Carrito_de_compras;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
