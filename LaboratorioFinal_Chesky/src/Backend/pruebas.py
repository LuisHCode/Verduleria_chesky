import requests

url = "http://127.0.0.1:5000/api/register"
data = {
    "nombre": "Cristian solano",
    "direccion_envio": "123 Calle Principal",
    "telefono": "1231321",
    "correo": "ronaldo@correo.com",
    "contraseña": "segura123"
}

response = requests.post(url, json=data)

print("Código de estado:", response.status_code)
print("Respuesta:", response.json())
