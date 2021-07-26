package dev.mvc.selling;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.selling.SellingProc")
public class SellingProc implements SellingProcInter {

  @Autowired
  private SellingDAOInter sellingDAO;

  @Override
  public List<SellingVO> list_all(int memberno) {
    List<SellingVO> list = this.sellingDAO.list_all(memberno);
    return list;
  }

  @Override
  public List<SellingVO> list_selling(int memberno) {
    List<SellingVO> list = this.sellingDAO.list_selling(memberno);
    return list;
  }

  @Override
  public List<SellingVO> list_sold(int memberno) {
    List<SellingVO> list = this.sellingDAO.list_sold(memberno);
    return list;
  }

}
