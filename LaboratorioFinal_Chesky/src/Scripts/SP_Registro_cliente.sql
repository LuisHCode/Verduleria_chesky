USE verduleria;
GO

CREATE PROCEDURE SP_Registrarse
    @Nombre NVARCHAR(255),
    @Estado NVARCHAR(50),
    @Direccion_envio NVARCHAR(255),
    @Telefono NVARCHAR(50),
    @Correo NVARCHAR(255),
    @Contraseña NVARCHAR(255)
AS
BEGIN
    INSERT INTO Cliente (Nombre, Estado, Direccion_envio, Telefono, Correo, Contraseña)
    VALUES (@Nombre, @Estado, @Direccion_envio, @Telefono, @Correo, @Contraseña);

    SELECT SCOPE_IDENTITY() AS ClienteID;
END;
