package dev.mvc.orders;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OrdersCont {

  @Autowired
  @Qualifier("dev.mvc.orders.OrdersProc")
  private OrdersProcInter OrdersProc;
  
  public OrdersCont() {
    System.out.println("-> OrdersCont created.");
  }
  
  /**
   * 주문 결제/회원별 목록
   * @return
   */
  @RequestMapping(value="/orders/list_by_memberno.do", method=RequestMethod.GET)
  public ModelAndView list_by_memberno(HttpSession session,
                                                      int paymentno) {
    ModelAndView mav = new ModelAndView();
    
    int delivery = 3000; // 배송비 합계
    int tot_sum=0; // 상품 총 주문액
    int tot_order=0; // delivery+tot_sum
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("paymentno", paymentno);
      map.put("memberno", memberno);
      
      List<OrdersVO> list = this.OrdersProc.list_by_memberno(map);
      
      for (OrdersVO ordersVO: list) {
        tot_sum += ordersVO.getTot();
      }
      
      
      tot_order = tot_sum + delivery; // 전체 주문 금액
      
      mav.addObject("delivery", delivery); // 배송비
      mav.addObject("tot_order", tot_order);     // 할인 금액 총 합계(금액)
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/orders/list_by_memberno"); // /views/order_item/list_by_memberno.jsp
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/orders/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    
    return mav;
  }
  
}
