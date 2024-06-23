package controladores;

import java.io.IOException;

import dao.ClassUsuariocl2Imp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TblUsuariocl2;

/**
 * Servlet implementation class ControladorLogin
 */
@WebServlet("/ControladorLogin")
public class ControladorLogin extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public ControladorLogin() {
    super();
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.getWriter().append("Served at: ").append(request.getContextPath());
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Obtener parámetros del formulario de inicio de sesión
    String usuario = request.getParameter("username");
    String password = request.getParameter("password");

    // Crear instancia del DAO
    ClassUsuariocl2Imp daoUsuario = new ClassUsuariocl2Imp();

    // Crear objeto usuario con los datos del formulario
    TblUsuariocl2 usuarioLogin = new TblUsuariocl2();
    usuarioLogin.setUsuariocl2(usuario);
    usuarioLogin.setPasswordcl2(password);

    // Intentar iniciar sesión
    TblUsuariocl2 usuarioAutenticado = daoUsuario.LoginUsuario(usuarioLogin);

    if (usuarioAutenticado != null) {
      // Usuario autenticado correctamente, crear sesión
      HttpSession session = request.getSession();
      session.setAttribute("usuario", usuarioAutenticado);

      // Redirigir a la página principal
      response.sendRedirect("dashboard.jsp");
    } else {
      // Usuario no encontrado, redirigir a la página de login con mensaje de error
      request.setAttribute("mensajeError", "Usuario o contraseña incorrectos.");
      request.getRequestDispatcher("index.jsp").forward(request, response);
    }
  }
}
