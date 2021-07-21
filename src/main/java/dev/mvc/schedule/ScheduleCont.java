package dev.mvc.schedule;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ScheduleCont {
  
  public ScheduleCont() {
    System.out.println("-> ScheduleCont created.");
  }
  
  /**
   * 스케줄 폼 
   * http://localhost:9091/schedule/schedule.do
   * @return
   */
  @RequestMapping(value="/schedule/schedule.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/schedule/schedule"); // webapp/member/create.jsp
   
    return mav; // forward
  }

}
