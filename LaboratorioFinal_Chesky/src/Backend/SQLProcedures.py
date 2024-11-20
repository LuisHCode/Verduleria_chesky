from conexion_sqlserver import connect_to_sql_server

# Crear una conexión global
connection = connect_to_sql_server()


def ejecutar_query(query, params):
    """
    Ejecuta una consulta SQL con los parámetros proporcionados.

    :param query: Cadena de la consulta SQL.
    :param params: Tupla con los parámetros necesarios.
    :return: Resultados del SELECT o mensaje de éxito.
    """
    if not connection:
        print("No hay conexión establecida.")
        return None

    try:
        cursor = connection.cursor()
        cursor.execute(query, params)

        if cursor.description:  # Si la consulta devuelve filas
            result = cursor.fetchall()  # Obtén los resultados
        else:
            connection.commit()  # Confirma los cambios si no hay filas devueltas
            result = {"success": True, "message": "Consulta ejecutada correctamente"}

        cursor.close()
        return result
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")
        return {"success": False, "message": str(e)}


# Métodos para cada procedimiento almacenado


def sp_agregar_producto(
    nombre_producto, descripcion, cuidados, link_imagen, precio, cantidad
):
    """
    Prepara la consulta para SP_AgregarProducto.

    :return: Query y datos necesarios.
    """
    query = "EXEC SP_AgregarProducto ?, ?, ?, ?, ?, ?"
    params = (nombre_producto, descripcion, cuidados, link_imagen, precio, cantidad)
    return ejecutar_query(query, params)


def sp_añadir_producto_a_carrito(id_carrito, id_producto, cantidad):
    """
    Prepara la consulta para SP_AñadirProductoADetallesCarrito.

    :return: Query y datos necesarios.
    """
    query = "EXEC SP_AñadirProductoADetallesCarrito ?, ?, ?"
    params = (id_carrito, id_producto, cantidad)
    return ejecutar_query(query, params)


def sp_crear_carrito(id_cliente):
    """
    Prepara la consulta para SP_CrearCarrito.

    :return: Query y datos necesarios.
    """
    query = "EXEC SP_CrearCarrito ?"
    params = (id_cliente,)
    return ejecutar_query(query, params)


def sp_generar_factura(id_carrito):
    """
    Prepara la consulta para SP_GenerarFactura.

    :return: Query y datos necesarios.
    """
    query = "EXEC SP_GenerarFactura ?"
    params = (id_carrito,)
    return ejecutar_query(query, params)


def sp_registrarse(nombre, direccion_envio, telefono, correo, contraseña):
    query = "EXEC SP_Registrarse ?, ?, ?, ?, ?, ?"
    params = (nombre, "Activo", direccion_envio, telefono, correo, contraseña)

    result = ejecutar_query(query, params)

    print("Resultado de ejecutar_query:", result)  # Depuración

    if isinstance(result, list) and len(result) > 0:
        cliente_id = result[0][0]  # Obtén el primer valor de la primera fila
        return {"success": True, "ClienteID": cliente_id}
    else:
        return {"success": False, "message": "No se pudo obtener el ID del cliente"}
