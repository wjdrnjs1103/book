package dev.mvc.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RegisterCont {
  @Autowired // CategrpProcInter를 구현한 CategrpProc.java의 객체가 할당
  @Qualifier("dev.mvc.register.RegisterProc")
  private RegisterProcInter registerProc;
  
  public RegisterCont() {
    System.out.println("-> RegisterCont created.");
  }
  
  /**
   * 새로고침 방지
   * @return
   */
  @RequestMapping(value="/register/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
   * 등록폼 http://localhost:9091/register/register.do
   * 
   * @return
   */
  @RequestMapping(value = "/register/register.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/register/register"); // /webapp/WEB-INF/views/register/register.jsp
     
    return mav;
  }
  

}
