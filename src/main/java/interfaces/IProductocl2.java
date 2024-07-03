package interfaces;

import java.util.List;

import model.TblProductocl2;

public interface IProductocl2 {
  // Declaramos los métodos
  public void RegistrarProducto(TblProductocl2 producto);

  public List<TblProductocl2> ListadoProducto();

  public void ActualizarProducto(TblProductocl2 producto);

  public void EliminarProducto(TblProductocl2 producto);
}
