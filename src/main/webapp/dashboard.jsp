<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.TblUsuariocl2"%>
<%@ page import="model.TblProductocl2"%>
<%@ page import="java.util.List"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
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
</head>
<body class="min-h-screen flex gap-5 bg-gray-100 overflow-x-hidden">
  <aside class="bg-gray-800 w-1/5 text-white p-6 flex flex-col justify-between shadow-lg max-h-dvh fixed left-0 top-0 bottom-0">
    <div class="flex flex-col gap-6">
      <h2 class="text-3xl font-semibold border-b border-gray-700 pb-2">Bienvenido</h2>
      <section class="text-gray-400 flex flex-col gap-4">
        <div class="flex flex-col">
          <strong class="text-white">ID:</strong> <span><%=usuario.getIdUsuariocl2()%></span>
        </div>
        <div class="flex flex-col">
          <strong class="text-white">Usuario:</strong> <span><%=usuario.getUsuariocl2()%></span>
        </div>
        <div class="flex flex-col">
          <strong class="text-white">Total de Productos:</strong> <span><%=productos != null ? productos.size() : 0%></span>
        </div>
      </section>
    </div>
    <form action="ControladorLogout" method="post" class="mt-6">
      <button type="submit" class="w-full px-4 py-2 bg-red-500 text-white font-semibold rounded hover:bg-red-600 transition-all duration-300">Cerrar sesión</button>
    </form>
  </aside>



  <main class="flex flex-col gap-4 p-6 rounded-lg w-4/5 ml-auto">
    <h1 class="text-4xl font-bold">Productos</h1>

    <!-- Botón para mostrar el modal -->
    <div class="mb-4">
      <button id="openModalBtn" class="px-4 py-2 rounded bg-blue-600 text-white hover:bg-blue-800 transition-all duration-300">Agregar producto</button>
    </div>

    <!-- Overlay -->
    <div id="overlay" class="absolute inset-0 w-full h-full bg-gray-800 bg-opacity-75 hidden"></div>

    <!-- Modal -->
    <div id="modal" class="fixed inset-0 m-auto hidden flex w-max h-max items-center justify-center">
      <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
        <h2 id="formTitle" class="text-xl font-bold mb-4">Registrar Producto</h2>
        <form action="ControladorProducto" method="post" class="flex flex-col gap-4">
          <input type="hidden" id="action" name="action" value="registrar" /> <input type="hidden" id="id" name="id" value="" />
          <div>
            <label for="nombre" class="block font-medium">Nombre:</label> <input type="text" id="nombre" name="nombre" placeholder="Nombre del producto" required
              class="mt-1 p-2 border border-gray-300 rounded w-full"
            />
          </div>
          <div class="flex gap-2">
            <div class="w-1/2">
              <label for="precioVenta" class="block font-medium">Precio Venta:</label> <input type="number" step="0.01" id="precioVenta" name="precioVenta" placeholder="0.00" required
                class="mt-1 p-2 border border-gray-300 rounded w-full"
              />
            </div>
            <div class="w-1/2">
              <label for="precioCompra" class="block font-medium">Precio Compra:</label> <input type="number" step="0.01" id="precioCompra" name="precioCompra" placeholder="0.00" required
                class="mt-1 p-2 border border-gray-300 rounded w-full"
              />
            </div>
          </div>
          <div class="flex flex-col gap-4">
            <div class="w-full">
              <label for="estado" class="block font-medium">Estado:</label> <select id="estado" name="estado" required class="mt-1 p-2 border border-gray-300 rounded w-full">
                <option value="Disponible">Disponible</option>
                <option value="Sin existencias">Sin existencias</option>
              </select>
            </div>
            <div class="w-full">
              <label for="descripcion" class="block font-medium">Descripción:</label>
              <textarea id="descripcion" name="descripcion" placeholder="Descripción del producto" required class="mt-1 p-2 border border-gray-300 rounded w-full resize-y max-h-[200px]"></textarea>
            </div>
          </div>
          <div class="flex justify-end gap-2 mt-4">
            <button id="closeModalBtn" type="button" class="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600 transition-all duration-300">Cancelar</button>
            <button id="formSubmitButton" type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-800 transition-all duration-300">Crear
              producto</button>
          </div>
        </form>
      </div>
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
            <th class="py-2 px-4 border-b border-gray-200">Acciones</th>
          </tr>
        </thead>
        <tbody id="tableProducts">
          <%
          if (productos != null && !productos.isEmpty()) {
          	for (TblProductocl2 producto : productos) {
          %>
          <tr class="hover:bg-gray-100">
            <td class="py-2 px-4 text-center border-b border-gray-200"><%=producto.getIdproductocl2()%></td>
            <td class="py-2 px-4 text-center border-b border-gray-200"><%=producto.getNombrecl2()%></td>
            <td class="py-2 px-4 text-center border-b border-gray-200 monto"><%=producto.getPrecioventacl2()%></td>
            <td class="py-2 px-4 text-center border-b border-gray-200 monto"><%=producto.getPreciocompcl2()%></td>
            <td class="py-2 px-4 text-center border-b border-gray-200"><%=producto.getEstadocl2()%></td>
            <td class="py-2 px-4 text-center border-b border-gray-200"><%=producto.getDescripcl2()%></td>
            <td class="flex gap-2 items-center py-2 px-4 text-center border-b border-gray-200">
              <!-- Editar producto -->
              <button class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-800 transition-all duration-300"
                onclick='fillUpdateForm({
                      id: <%=producto.getIdproductocl2()%>,
                      nombre: "<%=producto.getNombrecl2()%>",
                      precioVenta: <%=producto.getPrecioventacl2()%>,
                      precioCompra: <%=producto.getPreciocompcl2()%>,
                      estado: "<%=producto.getEstadocl2()%>",
                      descripcion: "<%=producto.getDescripcl2()%>"
                    })'
              >
                <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
                    d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10"
                  /></svg>
              </button> <!-- Eliminar producto -->
              <form action="ControladorProducto" method="post" style="display: inline;" onsubmit="return confirm('¿Está seguro que desea eliminar este producto?')">
                <input type="hidden" name="action" value="eliminar"> <input type="hidden" name="id" value="<%=producto.getIdproductocl2()%>">
                <button type="submit" class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-700 transition-all duration-300">
                  <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
                      d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"
                    /></svg>
                </button>
              </form>
            </td>
          </tr>
          <%
          }
          } else {
          %>
          <tr>
            <td colspan="7" class="py-2 px-4 border-b border-gray-200 text-center">No hay productos disponibles</td>
          </tr>
          <%
          }
          %>
        </tbody>
      </table>
    </div>
  </main>

  <script>
  	// Formatear los montos con la api Intl
    const currencyFormatter = new Intl.NumberFormat('es-PE', { style: 'currency', currency: 'PEN' });
    document.querySelectorAll('.monto').forEach(el => {
      el.textContent = currencyFormatter.format(el.textContent);
    });
  
    // Controlar la visibilidad del modal
    const modal = document.getElementById('modal');
    const openModalBtn = document.getElementById('openModalBtn');
    const closeModalBtn = document.getElementById('closeModalBtn');
    const overlay = document.getElementById('overlay');
  
    openModalBtn?.addEventListener('click', () => {
      openModal('registrar');
    });
  
    closeModalBtn?.addEventListener('click', () => {
      modal.classList.add('hidden');
      overlay.classList.add('hidden');
      document.body.style.overflow = 'auto';
    });
  
    overlay?.addEventListener('click', () => {
      modal.classList.add('hidden');
      overlay.classList.add('hidden');
      document.body.style.overflow = 'auto';
    });
    
    function openModal(action) {
	  document.body.style.overflow = 'hidden';
    	
      const modal = document.getElementById('modal');
      modal.classList.remove('hidden');
      
      const overlay = document.getElementById('overlay');
      overlay.classList.remove('hidden');
      
      modal.classList.add('modal-enter');
      modal.classList.add('modal-enter-active');
      
      document.getElementById('action').value = action;
      document.getElementById('formTitle').textContent = action === 'registrar' ? 'Registrar Producto' : 'Editar Producto';
      document.getElementById('formSubmitButton').textContent = action === 'registrar' ? 'Crear producto' : 'Actualizar producto';
    }
  
    // Llenar el formulario de actualización con datos del producto
    function fillUpdateForm(producto) {    
      // Abrir el modal
      openModal('editar');
        
      // Actualizar título del formulario
      document.getElementById('formTitle').textContent = 'Actualizar Producto';
      
      // Actualizar el texto del botón
      document.getElementById('formSubmitButton').textContent = 'Actualizar producto';
      
      // Llenar los campos del formulario con los datos del producto
        document.getElementById('id').value = producto.id;
        document.getElementById('nombre').value = producto.nombre;
        document.getElementById('precioVenta').value = producto.precioVenta;
        document.getElementById('precioCompra').value = producto.precioCompra;
        document.getElementById('estado').value = producto.estado;
        document.getElementById('descripcion').value = producto.descripcion;
      
      // Actualizar el valor del campo action
      document.getElementById('action').value = 'actualizar';
    }
</script>
</body>
</html>
