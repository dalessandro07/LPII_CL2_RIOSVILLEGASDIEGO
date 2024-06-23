package testEntidades;

import dao.ClassUsuariocl2Imp;
import model.TblUsuariocl2;

public class TestEntidadUsuario {

  public static void main(String[] args) {
    // Realizamos la respectiva instancia de la clase
    TblUsuariocl2 usuario = new TblUsuariocl2();
    ClassUsuariocl2Imp crud = new ClassUsuariocl2Imp();

    // Asignamos valores
    usuario.setUsuariocl2("usuario1");
    usuario.setPasswordcl2("password1");

    // Invocamos al método login
    crud.LoginUsuario(usuario);
  }

}
