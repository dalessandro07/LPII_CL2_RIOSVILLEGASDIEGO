package testEntidades;

import java.util.List;

import dao.ClassProductocl2Imp;
import model.TblProductocl2;

public class TestEntidadProducto {

  public static void main(String[] args) {
    // Realizamos la respectiva instancia de la clase
    TblProductocl2 producto = new TblProductocl2();
    ClassProductocl2Imp crud = new ClassProductocl2Imp();

    // Asignamos valores
    producto.setNombrecl2("Producto 200");
    producto.setPrecioventacl2(300.90);
    producto.setPreciocompcl2(150.80);
    producto.setEstadocl2("Disponible");
    producto.setDescripcl2("Producto categoría 200");

    // Invocamos al método registrar
    crud.RegistrarProducto(producto);

    // Invocamos al método listar
    List<TblProductocl2> listado = crud.ListadoProducto();

    for (TblProductocl2 prod : listado) {
      System.out.println("ID: " + prod.getIdproductocl2());
      System.out.println("Nombre: " + prod.getNombrecl2());
      System.out.println("Precio venta: " + prod.getPrecioventacl2());
      System.out.println("Precio compra: " + prod.getPreciocompcl2());
      System.out.println("Estado: " + prod.getEstadocl2());
      System.out.println("Descripcion: " + prod.getDescripcl2());
      System.out.println("\n");
    }

  }

}
