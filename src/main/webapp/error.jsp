<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Error</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-dvh">
  <div class="p-10 text-center">
    <h1 class="text-7xl font-bold text-red-600 mb-4">¡Oops!</h1>
    <p class="text-2xl text-gray-800 mb-4">Ha ocurrido un error inesperado.</p>
    
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="text-red-600 mb-8"><%= request.getAttribute("errorMessage") %></p>
    <% } else { %>
        <p class="text-gray-600 mb-8">Por favor, inténtalo de nuevo más tarde.</p>
    <% } %>
    
    <a href="index.jsp" class="bg-blue-600 text-white px-6 py-3 rounded hover:bg-blue-800 transition-all duration-300">Volver al inicio</a>
  </div>
</body>
</html>
