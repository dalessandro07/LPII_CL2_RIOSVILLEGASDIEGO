<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.TblUsuariocl2" %>
<%@ page import="model.TblProductocl2" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
if (session == null || session.getAttribute("usuario") == null) {
    response.sendRedirect("index.jsp");
    return;
}
TblUsuariocl2 usuario = (TblUsuariocl2) session.getAttribute("usuario");
List<TblProductocl2> productos = (List<TblProductocl2>) request.getAttribute("productos");

if (productos == null) {
  response.sendRedirect("ControladorProducto?action=listar");
  return;
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<script src="https://cdn.tailwindcss.com"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
	// Formatear los montos con la api Intl
    const currencyFormatter = new Intl.NumberFormat('es-PE', { style: 'currency', currency: 'PEN' });
    document.querySelectorAll('.monto').forEach(el => {
      el.textContent = currencyFormatter.format(el.textContent);
    });

    // Controlar la visibilidad del formulario
    const toggleFormBtn = document.getElementById('toggleFormBtn');
    const registerForm = document.getElementById('registerForm');
    toggleFormBtn.addEventListener('click', () => {
      if (registerForm.classList.contains('hidden')) {
        registerForm.classList.remove('hidden');
        toggleFormBtn.textContent = 'Ocultar formulario';
      } else {
        registerForm.classList.add('hidden');
        toggleFormBtn.textContent = 'Ver formulario para agregar producto';
      }
    });
  });
</script>
</head>
<body class="min-h-screen flex gap-5 bg-gray-100">
  <header class="bg-blue-600 w-1/6 text-white p-5 flex flex-col justify-between">
    <div class="flex flex-col gap-5">
      <h2 class="text-2xl font-bold">Bienvenido</h2>
      <section>
        <p><strong>ID Usuario:</strong> <%= usuario.getIdUsuariocl2() %></p>
        <p><strong>Usuario:</strong> <%= usuario.getUsuariocl2() %></p>
      </section>
    </div>
    <form action="ControladorLogout" method="post">
      <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-800 transition-all duration-300">Cerrar sesión</button>
    </form>
  </header>
  
  <main class="flex flex-col grow gap-4 p-6 rounded-lg">
    <h1 class="text-4xl font-bold">Productos</h1>

    <!-- Botón para mostrar/ocultar formulario -->
    <div class="mb-4">
      <button id="toggleFormBtn" class="px-4 py-2 rounded bg-blue-600 text-white hover:bg-blue-800 transition-all duration-300">Ver formulario para agregar producto</button>
    </div>

    <!-- Formulario para registrar un producto -->
    <div id="registerForm" class="flex flex-col gap-5 hidden">
      <h2 class="text-2xl font-bold">Registrar Producto</h2>
      
      <form action="ControladorProducto" method="post" class="flex flex-col gap-4 rounded-lg">
        <input type="hidden" name="action" value="registrar">
        <div>
          <label for="nombre" class="block font-medium">Nombre:</label>
          <input type="text" id="nombre" name="nombre" placeholder="Nombre del producto" required class="mt-1 p-2 border border-black rounded w-full">
        </div>
        
        <div class="flex gap-2">
          <div class="w-1/2">
            <label for="precioVenta" class="block font-medium">Precio Venta:</label>
            <input type="number" step="0.01" id="precioVenta" name="precioVenta" placeholder="0.00" required class="mt-1 p-2 border border-black rounded w-full">
          </div>
          <div class="w-1/2">
            <label for="precioCompra" class="block font-medium">Precio Compra:</label>
            <input type="number" step="0.01" id="precioCompra" name="precioCompra" placeholder="0.00" required class="mt-1 p-2 border border-black rounded w-full">
          </div>
        </div>
        
        <div class="flex gap-2">
          <div class="w-1/2">
            <label for="estado" class="block font-medium">Estado:</label>
            <select id="estado" name="estado" required class="mt-1 p-2 border border-black rounded w-full">
              <option value="Disponible">Disponible</option>
              <option value="Sin existencias">Sin existencias</option>
            </select>
          </div>
          <div class="w-1/2">
            <label for="descripcion" class="block font-medium">Descripción:</label>
            <textarea id="descripcion" name="descripcion" placeholder="Descripción del producto" required class="mt-1 p-2 border border-black rounded w-full resize-y"></textarea>
          </div>
        </div>
        <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-800 transition-all duration-300">Registrar producto</button>
      </form>

    </div>

    <div>
      <h2 class="text-2xl font-bold mt-6">Listado de Productos</h2>
      <table class="min-w-full bg-white mt-4 shadow-md rounded-lg overflow-hidden">
        <thead class="bg-gray-200">
          <tr>
            <th class="py-2 px-4 border-b border-gray-200">ID</th>
            <th class="py-2 px-4 border-b border-gray-200">Nombre</th>
            <th class="py-2 px-4 border-b border-gray-200">Precio Venta</th>
            <th class="py-2 px-4 border-b border-gray-200">Precio Compra</th>
            <th class="py-2 px-4 border-b border-gray-200">Estado</th>
            <th class="py-2 px-4 border-b border-gray-200">Descripción</th>
          </tr>
        </thead>
        <tbody>
          <%
            if (productos != null && !productos.isEmpty()) {
              for (TblProductocl2 producto : productos) {
          %>
                <tr class="hover:bg-gray-100">
                  <td class="py-2 px-4 text-center border-b border-gray-200"><%= producto.getIdproductocl2() %></td>
                  <td class="py-2 px-4 text-center border-b border-gray-200"><%= producto.getNombrecl2() %></td>
                  <td class="py-2 px-4 text-center border-b border-gray-200 monto"><%= producto.getPrecioventacl2() %></td>
                  <td class="py-2 px-4 text-center border-b border-gray-200 monto"><%= producto.getPreciocompcl2() %></td>
                  <td class="py-2 px-4 text-center border-b border-gray-200"><%= producto.getEstadocl2() %></td>
                  <td class="py-2 px-4 text-center border-b border-gray-200"><%= producto.getDescripcl2() %></td>
                </tr>
          <%
              }
            } else {
          %>
              <tr>
                <td colspan="6" class="py-2 px-4 border-b border-gray-200 text-center">No hay productos disponibles</td>
              </tr>
          <%
            }
          %>
        </tbody>
      </table>
    </div>
  </main>
</body>
</html>
