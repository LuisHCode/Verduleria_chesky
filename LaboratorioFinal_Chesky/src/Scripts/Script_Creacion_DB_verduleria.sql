--CREATE DATABASE verduleria;

USE verduleria;

CREATE TABLE Producto
(
	ID_Producto INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	Nombre_produto VARCHAR(50) NOT NULL,
	Descripcion_producto VARCHAR(100) NOT NULL,
	Cuidados_producto VARCHAR(100) NOT NULL,
	Link_imagen_referencia VARCHAR(255) NOT NULL,
	Precio_producto FLOAT NOT NULL,
	Cantidad_existente_producto INT NOT NULL
);

CREATE TABLE Cliente
(
	ID_Cliente INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	Nombre_Cliente VARCHAR(120) NOT NULL,
	Estado VARCHAR(25) NOT NULL,
	Direccion_envio_cliente VARCHAR(255) NOT NULL,
	Telefono_cliente VARCHAR(30) NOT NULL,
	Correo_electronico_cliente VARCHAR(50) NOT NULL,
	Contraseña_cliente VARCHAR(255) NOT NULL
);

CREATE TABLE Carrito_de_compras
(
	ID_Carrito_de_compras INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	ID_Cliente INT NOT NULL,
	Precio_Total_Productos FLOAT NOT NULL,
	Cantidad_Total_productos INT NOT NULL,
	FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Detalles_Carrito
(
	ID_Producto INT NOT NULL,
	ID_Carrito_de_compras INT NOT NULL,
	Cantidad_producto INT NOT NULL,
	Precio_total_cantidad FLOAT NOT NULL,
	FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
	FOREIGN KEY (ID_Carrito_de_compras) REFERENCES Carrito_de_compras(ID_Carrito_de_compras)
);

CREATE TABLE Factura
(
	ID_Factura INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	Fecha_Compra DATETIME NOT NULL,
	ID_Carrito_de_compras INT NOT NULL,
	Precio_total_factura FLOAT NOT NULL,
	FOREIGN KEY (ID_Carrito_de_compras) REFERENCES Carrito_de_compras(ID_Carrito_de_compras)
);