package dev.mvc.team2;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeCont {
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }

  // http://localhost:9091
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp
    
    return mav;
  }
  
  // http://localhost:9091/cookie/notice.do
  @RequestMapping(value = {"/cookie/notice.do"}, method = RequestMethod.GET)
  public ModelAndView notice() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cookie/notice");  // /WEB-INF/views/cookie/notice.jsp
    
    return mav;
  }
  
  // http://localhost:9091/cookie/notice_cookie.do
  @RequestMapping(value = {"/cookie/notice_cookie.do"}, method = RequestMethod.POST)
  public ModelAndView notice_cookie() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cookie/notice_cookie");  // /WEB-INF/views/cookie/notice_cookie.jsp
    
    return mav;
  }
  
  
}


