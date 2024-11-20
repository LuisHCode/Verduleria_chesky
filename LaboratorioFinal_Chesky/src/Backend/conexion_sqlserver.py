import pyodbc
import os

def connect_to_sql_server():
    """
    Establece una conexión con la base de datos SQL Server.
    
    :return: Objeto de conexión o None si falla.
    """
    # Variables de conexión (usar variables de entorno para datos sensibles)
    server = os.getenv('DB_SERVER', 'localhost')
    database = os.getenv('DB_NAME', 'verduleria')
    username = os.getenv('DB_USER', 'AdminPY')
    password = os.getenv('DB_PASSWORD', '123admin')
    conn_str = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'

    try:
        connection = pyodbc.connect(conn_str)
        print("Conexión establecida correctamente")
        return connection
    except pyodbc.Error as e:
        print("Fallo en la conexión")
        print(f"Error: {e}")
        return None

# Ejemplo de uso con contexto
if __name__ == "__main__":
    with connect_to_sql_server() as conn:
        if conn:
            print("Conexión lista para usarse.")
        else:
            print("No se pudo establecer conexión.")
