package dev.mvc.orders;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.orders.OrdersProc")
public class OrdersProc implements OrdersProcInter {

  @Autowired
  private OrdersDAOInter ordersDAO;
  
  @Override
  public int create(OrdersVO ordersVO) {
    int cnt =this.ordersDAO.create(ordersVO);
    return cnt;
  }

  @Override
  public List<OrdersVO> list_by_memberno(HashMap<String, Object> map) {
    List<OrdersVO> list = this.ordersDAO.list_by_memberno(map);
    return list;
  }
  
  @Override
  public int sum_cnt(int productno) {
    int cnt = this.ordersDAO.sum_cnt(productno);
    return cnt;
  }

  @Override
  public int exist(int productno) {
    int cnt = this.ordersDAO.exist(productno);
    return cnt;
  }

}
