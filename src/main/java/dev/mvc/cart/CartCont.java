package dev.mvc.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CartCont {

  @Autowired
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;
  
  public CartCont() {
    System.out.println("-> CartCont created.");
  }
  
  /**
   * Ajax 관심상품 등록
   * @param session
   * @param boardno
   * @return
   */
  @RequestMapping(value="/cart/create.do", method=RequestMethod.POST)
  @ResponseBody
  public String create(HttpSession session, int productno) {
    
    CartVO cartVO = new CartVO();
    cartVO.setProductno(productno);
    
    int memberno = (Integer)session.getAttribute("memberno");
    cartVO.setMemberno(memberno);
    
    cartVO.setCnt(1);
    
    int cnt = this.cartProc.create(cartVO); // 등록 처리
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    System.out.println("-> cartCont create: " + json.toString());

    return json.toString();
  }
  
  /**
   * 회원별 관심상품 목록
   * @param session
   * @param interestedno
   * @return
   */
  @RequestMapping(value="/cart/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session,
                                  @RequestParam(value="cartno", defaultValue = "0") int cartno) {
    ModelAndView mav = new ModelAndView();
    
    int tot =0; // 개별 금액
    int tot_sum=0; // 총합 금액
    int cnt =0; // 상품 갯수
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      // 출력 순서별 출력
      List<CartVO> list = this.cartProc.list(memberno);
      
      for (CartVO cartVO: list) {
        tot = cartVO.getPrice() * cartVO.getCnt(); // 개별 금액        
        tot_sum = tot_sum + tot;
      }
      
      mav.addObject("list", list); // request.setAttribute("list", list);
      mav.addObject("cartno", cartno); // 쇼핑계속하기에서 사용
      
      mav.addObject("tot_sum", tot_sum);
      
      mav.setViewName("/cart/list"); // /WEB-INF/views/categrp/list_by_memberno.jsp
      
      
   } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/cart/list.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    return mav;
  }
  
  @RequestMapping(value="/cart/update_cnt.do", method=RequestMethod.POST)
  public ModelAndView update_cnt(HttpSession session,
                                            @RequestParam(value="cartno", defaultValue = "0") int cartno,
                                            int cnt) {
    ModelAndView mav = new ModelAndView();
    
    CartVO cartVO = new CartVO();
    cartVO.setCartno(cartno);
    cartVO.setCnt(cnt);
    
    this.cartProc.update_cnt(cartVO);
    mav.setViewName("redirect:/cart/list.do");
    
    return mav;
  }
  
  
  /**
   * 상품 삭제
   * @param session
   * @param interestedno
   * @return
   */
  @RequestMapping(value="/cart/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpSession session,
                                      @RequestParam(value="cartno", defaultValue="0") int cartno) {
    ModelAndView mav= new ModelAndView();
    
    this.cartProc.delete(cartno);
    mav.setViewName("redirect:/cart/list.do");
    
    return mav;
  }
  
  /**
   * 회원별 관심 상품 개수 카운트
   * @param session
   * @param interestedno
   * @return
   */
  @RequestMapping(value="/cart/count_goods.do", method=RequestMethod.GET)
  public ModelAndView count_goods(HttpSession session,
      @RequestParam(value="cartno", defaultValue = "0") int cartno) {
    ModelAndView mav = new ModelAndView();
    
    int cnt=0;
    
     
    int memberno = (int)session.getAttribute("memberno");
    
    // 출력 순서별 출력
    List<CartVO> list = this.cartProc.list(memberno);
    //System.out.println(list);
    
    for (CartVO cartVO: list) {
      cnt = cnt + 1;
      
    }
      
    
    return mav;
  }
  
}
