package controladores;

import java.io.IOException;
import java.util.List;

import dao.ClassProductocl2Imp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TblProductocl2;

@WebServlet("/ControladorProducto")
public class ControladorProducto extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public ControladorProducto() {
    super();
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    ClassProductocl2Imp daoProducto = new ClassProductocl2Imp();

    if (action == null || "listar".equalsIgnoreCase(action)) {
      List<TblProductocl2> productos = daoProducto.ListadoProducto();
      request.setAttribute("productos", productos);

      request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    } else {
      response.sendRedirect("index.jsp");
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    ClassProductocl2Imp daoProducto = new ClassProductocl2Imp();

    if ("registrar".equalsIgnoreCase(action)) {
      String nombre = request.getParameter("nombre");
      double precioVenta = Double.parseDouble(request.getParameter("precioVenta"));
      double precioCompra = Double.parseDouble(request.getParameter("precioCompra"));
      String estado = request.getParameter("estado");
      String descripcion = request.getParameter("descripcion");

      TblProductocl2 nuevoProducto = new TblProductocl2();
      nuevoProducto.setNombrecl2(nombre);
      nuevoProducto.setPrecioventacl2(precioVenta);
      nuevoProducto.setPreciocompcl2(precioCompra);
      nuevoProducto.setEstadocl2(estado);
      nuevoProducto.setDescripcl2(descripcion);

      daoProducto.RegistrarProducto(nuevoProducto);

      request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    } else if ("actualizar".equalsIgnoreCase(action)) {
      int id = Integer.parseInt(request.getParameter("id"));

      String nombre = request.getParameter("nombre");
      double precioVenta = Double.parseDouble(request.getParameter("precioVenta"));
      double precioCompra = Double.parseDouble(request.getParameter("precioCompra"));
      String estado = request.getParameter("estado");
      String descripcion = request.getParameter("descripcion");

      TblProductocl2 producto = new TblProductocl2();
      producto.setIdproductocl2(id);
      producto.setNombrecl2(nombre);
      producto.setPrecioventacl2(precioVenta);
      producto.setPreciocompcl2(precioCompra);
      producto.setEstadocl2(estado);
      producto.setDescripcl2(descripcion);

      daoProducto.ActualizarProducto(producto);

      request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    } else if ("eliminar".equalsIgnoreCase(action)) {
      int id = Integer.parseInt(request.getParameter("id"));

      TblProductocl2 producto = new TblProductocl2();
      producto.setIdproductocl2(id);

      daoProducto.EliminarProducto(producto);

      request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    } else {
      doGet(request, response);
    }
  }
}
