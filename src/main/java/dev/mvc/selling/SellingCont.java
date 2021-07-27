package dev.mvc.selling;

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
public class SellingCont {

  @Autowired
  @Qualifier("dev.mvc.selling.SellingProc")
  private SellingProcInter sellingProc;
  
  public SellingCont() {
    System.out.println("-> SellingCont created.");
  }
  
  
  /**
   * 회원별 전체 판매 목록
   * @param memberno
   * @return
   */
    @RequestMapping(value="/selling/list_all.do", method=RequestMethod.GET)
    public ModelAndView list_all(HttpSession session) { 
      ModelAndView mav = new ModelAndView();
    
      if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 판매목록 이동 int
        int memberno = (int)session.getAttribute("memberno");
        
        List<SellingVO> list = this.sellingProc.list_all(memberno);
        mav.addObject("list", list);
        
        mav.setViewName("/selling/list_all");
      
      } else { // 회원으로 로그인하지 않았다면 
        mav.addObject("return_url", "/selling/list_all.do"); // 로그인 후 이동할 주소
        mav.setViewName("redirect:/register/login.do");
      
      }// if end
      
      return mav; 
    }
      
   /**
    * 판매 중인 판매 상품 목록
    * @param session
    * @return
    */
    @RequestMapping(value="/selling/list_selling.do", method=RequestMethod.GET)
    public ModelAndView list_selling(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 판매목록 이동 int
        int memberno = (int)session.getAttribute("memberno");
        
        List<SellingVO> list = this.sellingProc.list_selling(memberno);
        mav.addObject("list", list);
        
        
        mav.setViewName("/selling/list_selling");
      
      } else { // 회원으로 로그인하지 않았다면 
        mav.addObject("return_url", "/selling/list_selling.do"); // 로그인 후 이동할 주소
        mav.setViewName("redirect:/register/login.do");
      
      }// if end
      
      return mav;
    }
   
    
    /**
     * 판매 완료된 판매 상품 목록
     * @param session
     * @return
     */
     @RequestMapping(value="/selling/list_sold.do", method=RequestMethod.GET)
     public ModelAndView list_sold(HttpSession session) {
       ModelAndView mav = new ModelAndView();
       
       if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 판매목록 이동 int
         int memberno = (int)session.getAttribute("memberno");
         
         List<SellingVO> list = this.sellingProc.list_sold(memberno);
         mav.addObject("list", list);
         
         mav.setViewName("/selling/list_sold");
       
       } else { // 회원으로 로그인하지 않았다면 
         mav.addObject("return_url", "/selling/list_sold.do"); // 로그인 후 이동할 주소
         mav.setViewName("redirect:/register/login.do");
       
       }// if end
       
       return mav;
     }
  
  
}
