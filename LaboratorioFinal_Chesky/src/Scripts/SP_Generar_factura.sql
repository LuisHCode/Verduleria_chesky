CREATE PROCEDURE GenerarFactura
    @ID_Carrito_de_compras INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Obtener el precio total del carrito
        DECLARE @PrecioTotal FLOAT;
        SELECT 
			@PrecioTotal = Precio_Total_Productos
        FROM	
			Carrito_de_compras
        WHERE
			ID_Carrito_de_compras = @ID_Carrito_de_compras;

        -- Insertar la factura
        INSERT INTO Factura 
		(
			ID_Carrito_de_compras,
			Fecha_Compra,
			Precio_total_factura
		)
        VALUES 
		(	
			@ID_Carrito_de_compras,
			GETDATE(),
			@PrecioTotal
		);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
