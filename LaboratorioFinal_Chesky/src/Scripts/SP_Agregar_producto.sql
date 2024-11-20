CREATE PROCEDURE SP_Agregar_Producto
	@Nombre_Producto VARCHAR(50),
	@Descripcion_producto VARCHAR(100),
	@Cuidados_producto VARCHAR(100),
	@Link_imagen_referencia VARCHAR(255),
	@Precio_producto FLOAT,
	@Cantidad_existente_producto INT
AS
	BEGIN
		INSERT INTO Producto
		(
			Nombre_produto,
			Descripcion_producto,
			Cuidados_producto,
			Link_imagen_referencia,
			Precio_producto,
			Cantidad_existente_producto
		)
		VALUES
		(
			@Nombre_Producto,
			@Descripcion_producto,
			@Cuidados_producto,
			@Link_imagen_referencia,
			@Precio_producto,
			@Cantidad_existente_producto
		)
	END