package dao;

import java.util.Collections;
import java.util.List;

import interfaces.IProductocl2;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.TblProductocl2;

public class ClassProductocl2Imp implements IProductocl2 {

  // Nombre de la unidad de persistencia (proyecto)
  private String persistenceUnitName = "LPII_CL2_RIOSVILLEGASDIEGO";

  @Override
  public void RegistrarProducto(TblProductocl2 producto) {
    // Establecer la conexión con la unidad de persistencia
    EntityManagerFactory fabr = Persistence.createEntityManagerFactory(persistenceUnitName);

    // Gestionar las entidades
    EntityManager em = fabr.createEntityManager();

    try {
      // Iniciamos la transacción
      em.getTransaction().begin();

      // Registramos el producto
      em.persist(producto);

      // Emitimos mensaje por consola
      System.out.println("Producto registrado en la BD.");

      // Confirmamos
      em.getTransaction().commit();
    } catch (Exception e) {
      System.out.println(e.getMessage());
      if (em.getTransaction().isActive()) {
        em.getTransaction().rollback();
      }
    } finally {
      // Cerramos
      em.close();
    }
  }

  @Override
  public List<TblProductocl2> ListadoProducto() {
    // Establecer la conexión con la unidad de persistencia
    EntityManagerFactory fabr = Persistence.createEntityManagerFactory(persistenceUnitName);

    // Gestionar las entidades
    EntityManager em = fabr.createEntityManager();

    try {
      // Iniciamos la transacción
      em.getTransaction().begin();

      // Recuperamos el listado de usuarios de la base de datos
      /*
       * Aplicamos consultas JPQL (JPA Query Language), el método createQuery() sirve para hacer consultas dinámicas
       */
      List<TblProductocl2> listado = em.createQuery("SELECT p FROM TblProductocl2 p", TblProductocl2.class).getResultList();

      // Confirmamos
      em.getTransaction().commit();

      // Retornamos el listado de clientes de la BD
      return listado;
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return Collections.emptyList();
    } finally {
      // Cerramos
      em.close();
    }
  }

}
