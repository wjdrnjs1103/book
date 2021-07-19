package dev.mvc.orders;

import java.util.HashMap;
import java.util.List;

public interface OrdersProcInter {

  /**
   *  주문 등록
   * @param ordersVO
   * @return
   */
  public int create(OrdersVO ordersVO);
  
  /**
   * 회원별 주문 결제 목록
   * @param map
   * @return
   */
  public List<OrdersVO> list_by_memberno(HashMap<String, Object> map);
}
