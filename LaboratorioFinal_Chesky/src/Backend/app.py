from flask import Flask, request, jsonify
import SQLProcedures as sp  # Importamos SQLProcedures como módulo
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Habilita CORS para todas las rutas

@app.route('/api/addProduct', methods=['POST'])
def add_product():
    data = request.json
    result = sp.sp_agregar_producto(
        data['nombre_producto'], 
        data['descripcion'], 
        data['cuidados'], 
        data['link_imagen'], 
        data['precio'], 
        data['cantidad']
    )
    return jsonify(result)

@app.route('/api/register', methods=['POST'])
def register_user():
    try:
        data = request.json
        result = sp.sp_registrarse(
            data['nombre'], 
            data['direccion_envio'], 
            data['telefono'], 
            data['correo'], 
            data['contraseña']
        )
        return jsonify(result)
    except Exception as e:
        return jsonify({"success": False, "message": f"Error en el servidor: {str(e)}"}), 500

@app.route('/api/createCart', methods=['POST'])
def create_cart():
    data = request.json
    result = sp.sp_crear_carrito(data['id_cliente'])
    return jsonify(result)

@app.route('/api/addToCart', methods=['POST'])
def add_to_cart():
    data = request.json
    result = sp.sp_añadir_producto_a_carrito(
        data['id_carrito'], 
        data['id_producto'], 
        data['cantidad']
    )
    return jsonify(result)

@app.route('/api/generateInvoice', methods=['POST'])
def generate_invoice():
    data = request.json
    result = sp.sp_generar_factura(data['id_carrito'])
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
