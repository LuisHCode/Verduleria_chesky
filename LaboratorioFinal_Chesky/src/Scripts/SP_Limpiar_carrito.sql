CREATE PROCEDURE SP_LimpiarCarrito
    @ID_Carrito_de_compras INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Eliminar los productos del carrito en la tabla Detalles_Carrito
        DELETE FROM 
			Detalles_Carrito
        WHERE
			ID_Carrito_de_compras = @ID_Carrito_de_compras;

        -- Restablecer los valores en la tabla Carrito_de_compras
        UPDATE
			Carrito_de_compras
        SET 
            Cantidad_Total_productos = 0,
            Precio_Total_Productos = 0
        WHERE
			ID_Carrito_de_compras = @ID_Carrito_de_compras;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
