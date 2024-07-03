<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>CL3 - LPII Diego Alessandro Rios Villegas</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
  <main class="flex items-center gap-10 p-10 justify-center min-h-screen">
    <aside class="flex flex-col gap-1 w-1/2">
      <h1 class="text-8xl font-bold text-balance">Examen CL3 - LPII</h1>
      <p class="text-2xl text-gray-500">Diego Alessandro Rios Villegas</p>
    </aside>

    <!-- Formulario de login -->
    <div class="w-1/2 p-8 rounded-lg">
      <h2 class="text-3xl font-bold text-center mb-4">Iniciar sesión</h2>
      
      <form action="ControladorLogin" method="POST" class="space-y-4">
        <div>
          <label for="username" class="block text-sm font-medium text-gray-700">Usuario</label>
          <input type="text" id="username" name="username" required placeholder="Ingrese su usuario"
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
            autocomplete="username" />
        </div>
        
        <div>
          <label for="password" class="block text-sm font-medium text-gray-700">Contraseña</label>
          <input type="password" id="password" name="password" required placeholder="Ingrese su contraseña"
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
            autocomplete="current-password" />
        </div>
        
        
          <button type="submit"
            class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
            Ingresar
          </button>
      </form>
      
      <%
        String mensajeError = (String) request.getAttribute("mensajeError");
        if (mensajeError != null) {
      %>
        <p class="text-red-700 bg-red-100 p-2 text-center mt-4"><%= mensajeError %></p>
      <%
        }
      %>
    </div>
    
    
  </main>
</body>
</html>
