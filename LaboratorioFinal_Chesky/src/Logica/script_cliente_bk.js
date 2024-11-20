// Función genérica para enviar solicitudes al backend
async function sendToBackend(endpoint, data) {
    const baseUrl = 'http://127.0.0.1:5000'; // URL base del backend
    try {
      const response = await fetch(`${baseUrl}${endpoint}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });
  
      if (!response.ok) {
        throw new Error(`Error en la solicitud: ${response.statusText}`);
      }
  
      return await response.json();
    } catch (error) {
      console.error("Error al comunicarse con el backend:", error);
      throw error;
    }
  }  
  
  // Función para registrar usuario
  async function registerUser(userData) {
    return await sendToBackend('/api/register', userData);
  }
  
  // Función para agregar un producto
  async function addProduct(productData) {
    return await sendToBackend('/api/addProduct', productData);
  }
  
  // Función para crear un carrito
  async function createCart(clientId) {
    return await sendToBackend('/api/createCart', { id_cliente: clientId });
  }
  
  // Función para añadir un producto al carrito
  async function addToCart(cartId, productId, quantity) {
    return await sendToBackend('/api/addToCart', {
      id_carrito: cartId,
      id_producto: productId,
      cantidad: quantity,
    });
  }
  
  // Función para generar factura
  async function generateInvoice(cartId) {
    return await sendToBackend('/api/generateInvoice', { id_carrito: cartId });
  }
  
  // Exportar las funciones para usarlas en otros scripts
  export { registerUser, addProduct, createCart, addToCart, generateInvoice };
  