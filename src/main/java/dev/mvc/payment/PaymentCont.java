package dev.mvc.payment;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cart.CartProcInter;
import dev.mvc.cart.CartVO;
import dev.mvc.orders.OrdersProcInter;
import dev.mvc.orders.OrdersVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;

@Controller
public class PaymentCont {

  @Autowired
  @Qualifier("dev.mvc.payment.PaymentProc")
  private PaymentProcInter paymentProc;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
  
  @Autowired
  @Qualifier("dev.mvc.orders.OrdersProc")
  private OrdersProcInter ordersProc;
  
  /**
   * 등록 폼
   * @param session
   * @return
   */
  @RequestMapping(value="/payment/create.do", method=RequestMethod.GET)
  public ModelAndView create(HttpSession session) {
ModelAndView mav = new ModelAndView();
    
    int tot =0; // 개별 금액
    int tot_sum=0; // 총합 금액
    int delivery=3000; // 배송 금액
    int tot_order=0;

    int memberno = (int)session.getAttribute("memberno");
    
    // 출력 순서별 출력
    List<CartVO> list = this.cartProc.list(memberno);
    
    for (CartVO cartVO: list) {
      tot = cartVO.getPrice() * cartVO.getCnt(); // 개별 금액        
      cartVO.setTot(tot);
      
      tot_sum = tot_sum + cartVO.getTot();
    }
    
    tot_order = tot_sum + delivery;
    
    mav.addObject("list", list); // request.setAttribute("list", list);
    mav.addObject("tot_sum", tot_sum);
    mav.addObject("delivery", delivery);
    mav.addObject("tot_order", tot_order);
    
    mav.setViewName("/payment/create"); // /WEB-INF/views/categrp/list_by_memberno.jsp

    return mav;
  }
  
  /** http://localhost:9091/payment/create.do
   * 주문 결제 등록 처리
   * @param session
   * @param paymentVO
   * @return
   */
  @RequestMapping(value="/payment/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpSession session, 
                                        PaymentVO paymentVO) {
    ModelAndView mav = new ModelAndView();
    
    int memberno = (int)session.getAttribute("memberno");
    paymentVO.setMemberno(memberno); // 회원 번호 저장
    
    int cnt = this.paymentProc.create(paymentVO);
    //System.out.println("cnt: "+cnt);
    /*
       <!-- 주문 결재 등록 전 paymentno를 PaymentVO에 저장 -->
  <insert id="create" parameterType="dev.mvc.payment.PaymentVO">
    <selectKey keyProperty="paymentno" resultType="int" order="BEFORE">
      SELECT payment_seq.nextval FROM dual
    </selectKey>
    INSERT INTO payment(paymentno, memberno, realname, phone, postcode, address, detaddress,
                                paytype, paymoney, rdate)
    VALUES(#{paymentno}, #{memberno}, #{realname}, #{phone}, #{postcode}, #{address}, #{detaddress},
                #{paytype}, #{paymoney}, sysdate)
  </insert>
     */
    
    int paymentno = paymentVO.getPaymentno();
    //System.out.println("paymentno: "+ paymentno);
    
    OrdersVO ordersVO = new OrdersVO();
    if (cnt == 1) { // 정상적으로 주문 결재 정보가 등록된 경우
      // 회원의 쇼핑카트 정보를 읽어서 주문 상세 테이블로 insert
      // 1. cart 읽음, SELECT
      List<CartVO> list = this.cartProc.list(memberno);
      for (CartVO cartVO:list) {
        int productno = cartVO.getProductno();
        int cartno = cartVO.getCartno();
        
        // 2. orders INSERT
        ordersVO.setMemberno(memberno);
        ordersVO.setPaymentno(paymentno);
        ordersVO.setProductno(productno);
        ordersVO.setCnt(cartVO.getCnt());
        
        ProductVO productVO = this.productProc.read(productno);
        int tot = productVO.getPrice() * cartVO.getCnt();
        
        ordersVO.setTot(tot);
        // 배송 상태(states):  1: 결재 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료  
        ordersVO.setStates(1);
        this.ordersProc.create(ordersVO);
        
        int update_stateno = this.productProc.update_stateno(productno);
        
        // 3. 주문된 상품 cart에서 delete
        int delete_cnt = this.cartProc.delete(cartno);
        System.out.println("-> delete_cnt:" + delete_cnt+" 건 주문 후 cart에서 삭제");
        
      }
           
    } else {
      mav.addObject("code", "create"); // request에 저장, request.setAttribute("cnt", cnt)
      mav.setViewName("/payment/error_msg"); // /WEB-INF/views/categrp/error_msg.jsp
    }
    
    
    mav.addObject("memberno", memberno);
    mav.setViewName("redirect:/payment/list_by_memberno.do");
    
    return mav;
  }
  
  /**
   * 회원별 전체 목록
   * @param session
   * @return
   */
  @RequestMapping(value="/payment/list_by_memberno.do", method=RequestMethod.GET)
  public ModelAndView list_by_memberno(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      List<PaymentVO> list = this.paymentProc.list_by_memberno(memberno);
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/payment/list_by_memberno"); // /views/order_pay/list_by_memberno.jsp   
      
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/payment/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/register/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    
    return mav;
  }
  
}
