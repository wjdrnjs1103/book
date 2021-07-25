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

import dev.mvc.cart.CartVO;

@Controller
public class OrdersCont {

  @Autowired
  @Qualifier("dev.mvc.orders.OrdersProc")
  private OrdersProcInter ordersProc;
  
  public OrdersCont() {
    System.out.println("-> OrdersCont created.");
  }
  
  /**
   * 주문 결제/회원별 목록
   * @param session
   * @param paymentno
   * @return
   */
  @RequestMapping(value="/orders/list_by_memberno.do", method=RequestMethod.GET)
  public ModelAndView list_by_memberno(HttpSession session, int paymentno) {
    ModelAndView mav = new ModelAndView();
    
    int tot =0; // 개별 금액
    int tot_sum=0; // 총합 금액
    int delivery=3000; // 배송비
    int tot_order=0;
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("paymentno", paymentno);
      map.put("memberno", memberno);
      
      // 출력 순서별 출력
      List<OrdersVO> list = this.ordersProc.list_by_memberno(map);
      
      for (OrdersVO ordersVO: list) {
        tot_sum += ordersVO.getTot();
      }
      
      tot_order = tot_sum + delivery;
      
      mav.addObject("list", list); // request.setAttribute("list", list);      
      mav.addObject("tot_order", tot_order);
      mav.addObject("delivery", delivery);
      
      mav.setViewName("/orders/list_by_memberno"); // /WEB-INF/views/categrp/list_by_memberno.jsp
      
   } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/orders/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/register/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    
    return mav;
  }
  
}
