CREATE PROCEDURE AñadirProductoADetallesCarrito
    @ID_Carrito_de_compras INT,
    @ID_Producto INT,
    @Cantidad_producto INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Obtener el precio del producto
        DECLARE 
			@PrecioProducto FLOAT;
        SELECT 
			@PrecioProducto = Precio_producto
        FROM 
			Producto
        WHERE
			ID_Producto = @ID_Producto;

        -- Calcular el precio total para los productos agregados
        DECLARE @PrecioTotal FLOAT;
        SET @PrecioTotal = @PrecioProducto * @Cantidad_producto;

        -- Insertar en Detalles_Carrito
        INSERT INTO Detalles_Carrito	
		(
			ID_Carrito_de_compras,
			ID_Producto,
			Cantidad_producto,
			Precio_total_cantidad
		)
        VALUES 
		(
			@ID_Carrito_de_compras,
			@ID_Producto,
			@Cantidad_producto,
			@PrecioTotal
		);

        -- Actualizar los totales en Carrito_de_compras
        UPDATE Carrito_de_compras
        SET 
            Cantidad_Total_productos = Cantidad_Total_productos + @Cantidad_producto,
            Precio_Total_Productos = Precio_Total_Productos + @PrecioTotal
        WHERE 
			ID_Carrito_de_compras = @ID_Carrito_de_compras;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
