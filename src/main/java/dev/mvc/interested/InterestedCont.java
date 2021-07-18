package dev.mvc.interested;

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
public class InterestedCont {

  @Autowired
  @Qualifier("dev.mvc.interested.InterestedProc")
  private InterestedProcInter interestedProc;
  
  public InterestedCont() {
    System.out.println("-> InterestedCont created.");
  }
  
  /**
   * 관심상품 등록
   * @param session
   * @param boardno
   * @return
   */
  @RequestMapping(value="/interested/create.do", method=RequestMethod.POST)
  @ResponseBody
  public String create(HttpSession session, int productno) {
    InterestedVO interestedVO = new InterestedVO();
    interestedVO.setProductno(productno);
    
    int memberno = (Integer)session.getAttribute("memberno");
    interestedVO.setMemberno(memberno);
    
    int cnt = this.interestedProc.create(interestedVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    System.out.println("-> interestedCont created:"+json.toString());   
    
    return json.toString();
  }
  
  /**
   * 회원별 관심상품 목록
   * @param session
   * @param interestedno
   * @return
   */
  @RequestMapping(value="/interested/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session,
                                  @RequestParam(value="interestedno", defaultValue = "0") int interestedno) {
    ModelAndView mav = new ModelAndView();
    
    int tot =0; // 개별 금액
    int tot_sum=0; // 총합 금액
    int cnt =0; // 상품 갯수
    //int cnt_1=0;
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      //int memberno = 1;
      
      // 출력 순서별 출력
      List<InterestedVO> list = this.interestedProc.list(memberno);
      System.out.println(list);
      
      for (InterestedVO interestedVO: list) {
        tot = interestedVO.getPrice(); // 개별 금액
        
        tot_sum = tot_sum + tot;
        cnt = cnt + 1;
        
        interestedVO.setCnt(cnt);
        //cnt_1 = interestedVO.getCnt();
      }
      //System.out.println("cnt: "+ cnt_1);
      
      mav.addObject("list", list); // request.setAttribute("list", list);
      mav.addObject("interestedno", interestedno); // 쇼핑계속하기에서 사용
      
      mav.addObject("tot_sum", tot_sum);
      
      mav.setViewName("/interested/list"); // /WEB-INF/views/categrp/list_by_memberno.jsp
      
      
   } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/interested/list.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    return mav;
  }
  
  /**
   * 상품 삭제
   * @param session
   * @param interestedno
   * @return
   */
  @RequestMapping(value="/interested/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session,
                                      @RequestParam(value="interestedno", defaultValue="0") int interestedno) {
    ModelAndView mav= new ModelAndView();
    
    this.interestedProc.delete(interestedno);
    System.out.println("interestedno"+ interestedno);
    mav.setViewName("redirect:/interested/list.do");
    
    return mav;
  }
  
}
