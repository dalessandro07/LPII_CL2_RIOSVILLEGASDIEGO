package model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

/**
 * The persistent class for the tbl_usuariocl2 database table.
 * 
 */
@Entity
@Table(name = "tbl_usuariocl2")
@NamedQuery(name = "TblUsuariocl2.findAll", query = "SELECT t FROM TblUsuariocl2 t")
public class TblUsuariocl2 implements Serializable {
  public interface IUsuariocl2 {

  }

  private static final long serialVersionUID = 1L;

  @Id
  @Column(name = "id_usuariocl2")
  private int idUsuariocl2;

  private String passwordcl2;

  private String usuariocl2;

  public TblUsuariocl2() {
  }

  public int getIdUsuariocl2() {
    return this.idUsuariocl2;
  }

  public void setIdUsuariocl2(int idUsuariocl2) {
    this.idUsuariocl2 = idUsuariocl2;
  }

  public String getPasswordcl2() {
    return this.passwordcl2;
  }

  public void setPasswordcl2(String passwordcl2) {
    this.passwordcl2 = passwordcl2;
  }

  public String getUsuariocl2() {
    return this.usuariocl2;
  }

  public void setUsuariocl2(String usuariocl2) {
    this.usuariocl2 = usuariocl2;
  }

}