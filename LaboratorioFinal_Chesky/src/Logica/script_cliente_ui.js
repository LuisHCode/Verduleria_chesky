import { registerUser } from './script_cliente_bk.js'; // Importamos la función para registrar usuario

document.addEventListener("DOMContentLoaded", () => {
  // Elementos DOM
  const registerButton = document.getElementById("registerButton");
  const loginButton = document.getElementById("loginButton");
  const registerModal = document.getElementById("registerModal");
  const loginModal = document.getElementById("loginModal");
  const closeRegisterModal = document.getElementById("closeRegisterModal");
  const closeLoginModal = document.getElementById("closeLoginModal");

  // Incrementar y decrementar cantidades
  document.querySelectorAll(".increment").forEach((button) => {
    button.addEventListener("click", () => {
      const input = button.previousElementSibling;
      input.value = parseInt(input.value) + 1;
    });
  });

  document.querySelectorAll(".decrement").forEach((button) => {
    button.addEventListener("click", () => {
      const input = button.nextElementSibling;
      if (parseInt(input.value) > 1) {
        input.value = parseInt(input.value) - 1;
      }
    });
  });

  // Mostrar modal de registro y cerrar el de inicio de sesión si está abierto
  registerButton.addEventListener("click", () => {
    if (loginModal.style.display === "block") {
      loginModal.style.display = "none";
    }
    registerModal.style.display = "block";
  });

  // Mostrar modal de inicio de sesión y cerrar el de registro si está abierto
  loginButton.addEventListener("click", () => {
    if (registerModal.style.display === "block") {
      registerModal.style.display = "none";
    }
    loginModal.style.display = "block";
  });

  // Cerrar modal de registro
  closeRegisterModal.addEventListener("click", () => {
    registerModal.style.display = "none";
  });

  // Cerrar modal de inicio de sesión
  closeLoginModal.addEventListener("click", () => {
    loginModal.style.display = "none";
  });

  // Cerrar modales al hacer clic fuera del contenido
  window.addEventListener("click", (event) => {
    if (event.target === registerModal) {
      registerModal.style.display = "none";
    } else if (event.target === loginModal) {
      loginModal.style.display = "none";
    }
  });

  // Manejar el registro de usuarios
  document.getElementById("registerForm").addEventListener("submit", async (event) => {
    event.preventDefault();

    // Recoger datos del formulario
    const userData = {
      nombre: document.getElementById("registerName").value,
      direccion_envio: document.getElementById("registerAddress").value,
      telefono: document.getElementById("registerPhone").value,
      correo: document.getElementById("registerEmail").value,
      contraseña: document.getElementById("registerPassword").value,
    };

    // Validar que los datos no estén vacíos
    if (!validateUserInput(userData)) {
      alert("Por favor, completa todos los campos.");
      return;
    }

    try {
      // Enviar datos al backend
      const response = await registerUser(userData);
      if (response.success) {
        alert("Usuario registrado con éxito.");
        clearRegisterForm();
        registerModal.style.display = "none";
      } else {
        alert(`Error al registrar usuario: ${response.message}`);
      }
    } catch (error) {
      console.error("Error al registrar usuario:", error);
      alert("Ocurrió un error durante el registro.");
    }
  });

  // Función para validar datos de entrada
  function validateUserInput(userData) {
    return Object.values(userData).every(value => value.trim() !== "");
  }

  // Función para limpiar el formulario de registro
  function clearRegisterForm() {
    document.getElementById("registerName").value = "";
    document.getElementById("registerState").value = "";
    document.getElementById("registerAddress").value = "";
    document.getElementById("registerPhone").value = "";
    document.getElementById("registerEmail").value = "";
    document.getElementById("registerPassword").value = "";
  }
});
