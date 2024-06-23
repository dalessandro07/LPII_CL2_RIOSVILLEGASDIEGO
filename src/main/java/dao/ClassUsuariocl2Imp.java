package dao;

import interfaces.IUsuariocl2;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import model.TblUsuariocl2;

public class ClassUsuariocl2Imp implements IUsuariocl2 {

  // Nombre de la unidad de persistencia (proyecto)
  private String persistenceUnitName = "LPII_CL2_RIOSVILLEGASDIEGO";

  @Override
  public TblUsuariocl2 LoginUsuario(TblUsuariocl2 usuario) {
    // Establecer la conexión con la unidad de persistencia
    EntityManagerFactory fabr = Persistence.createEntityManagerFactory(persistenceUnitName);

    // Gestionar las entidades
    EntityManager em = fabr.createEntityManager();

    TblUsuariocl2 usuarioEncontrado = null;

    try {
      // Iniciamos la transacción
      em.getTransaction().begin();

      // Realizamos el login
      TypedQuery<TblUsuariocl2> query = em.createQuery("SELECT u FROM TblUsuariocl2 u WHERE u.usuariocl2 = :usuario AND u.passwordcl2 = :password", TblUsuariocl2.class);
      query.setParameter("usuario", usuario.getUsuariocl2());
      query.setParameter("password", usuario.getPasswordcl2());

      usuarioEncontrado = query.getSingleResult();

      // Emitimos mensaje por consola
      System.out.println("El usuario " + usuario.getUsuariocl2() + " inició sesión.");

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

    return usuarioEncontrado;
  }
}
