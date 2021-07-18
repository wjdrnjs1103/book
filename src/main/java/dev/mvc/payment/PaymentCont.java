package dev.mvc.payment;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.interested.InterestedProcInter;
import dev.mvc.interested.InterestedVO;
import dev.mvc.orders.OrdersProcInter;
import dev.mvc.orders.OrdersVO;

@Controller
public class PaymentCont {

  @Autowired
  @Qualifier("dev.mvc.interested.InterestedProc")
  private InterestedProcInter interestedProc;
  
  @Autowired
  @Qualifier("dev.mvc.payment.PaymentProc")
  private PaymentProcInter paymentProc;
  

  @Autowired
  @Qualifier("dev.mvc.orders.OrdersProc")
  private OrdersProcInter ordersProc;

  
/*
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
*/
  
  public PaymentCont() {
    System.out.println("-> PaymentCont created.");
  }
  
  /**
   * http://localhost:9091/payment/create.do
   * 등록 폼
   * @param session
   * @return
   */
  @RequestMapping(value="/payment/create.do", method=RequestMethod.GET)
  public ModelAndView create(HttpSession session) {
    
ModelAndView mav = new ModelAndView();
    
    int tot =0;
    int tot_sum=0;
    int delivery = 3000;
    int tot_order =0;
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      //int memberno = 1;
      
      // 출력 순서별 출력
      List<InterestedVO> list = this.interestedProc.list(memberno);
      
      for (InterestedVO interestedVO: list) {
        tot = interestedVO.getPrice(); // 개별 금액
        
        tot_sum = tot_sum + tot;
      }
      
      tot_order=tot_sum+delivery;
      
      mav.addObject("list", list); // request.setAttribute("list", list);
      
      mav.addObject("tot_sum", tot_sum);
      mav.addObject("delivery", delivery);
      mav.addObject("tot_order", tot_order);
      
      mav.setViewName("/payment/create"); // /WEB-INF/views/categrp/list_by_memberno.jsp
      
      
   } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/payment/create.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    return mav;
  }
  
  /**
   * 주문 결재 등록 처리
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
    
    /*
  <!-- 주문 결재 등록 전 paymentno를 PaymentVO에 저장 -->
  <insert id="create" parameterType="dev.mvc.payment.PaymentVO">
    <selectKey keyProperty="paymentno" resultType="int" order="BEFORE">
      SELECT payment_seq.nextval FROM dual
    </selectKey>
    INSERT INTO payment(paymentno, memberno, realname, phone, postcode, address, detaddress,
                                paytype, paymoney, rdate)
    VALUES(#{paymentno}, #{memberno}, #{realname}, #{phone}, #{postcode}, #{address}, #{detaddress}
                #{paytype}, #{paymoney}, sysdate)
  </insert>
     */
    
    int paymentno = paymentVO.getPaymentno();
    
    OrdersVO ordersVO = new OrdersVO();
    if (cnt == 1) { // 정상적으로 주문 결제 정보가 등록된 경우
      // 회원의 관심 상품 정보를 읽어서 주문 상세 테이블로 insert
      // 1. interested 읽음, select
      List<InterestedVO> list = this.interestedProc.list(memberno);
      for (InterestedVO interestedVO: list) {
        int productno = interestedVO.getProductno();
        int interestedno = interestedVO.getInterestedno();
        
        // 2. orders insert
        ordersVO.setMemberno(memberno);
        ordersVO.setOrdersno(paymentno);
        ordersVO.setProductno(productno);
        ordersVO.setCnt(interestedVO.getCnt());
        
        
        
      }
    }
    
    mav.addObject("memberno", memberno);
    mav.setViewName("redirect:/orders/list.do");
    
    return mav;
  }

  
  
}
