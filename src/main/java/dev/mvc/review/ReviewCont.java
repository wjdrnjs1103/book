package dev.mvc.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReviewCont {
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc")
  private ReviewProcInter reviewProc;
  
  public ReviewCont() {
    System.out.println("-> ReviewCont created.");
  }
  
  /**
   * 등록 폼
   * @return
   */
  @RequestMapping(value="/review/create.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/review/create"); // webapp/WEB-INF/views/bookgrp/create.jsp
    return mav; // forward
  }
  
  /**
   * 목록
   * @param reviewVO
   * @return
   */
  @RequestMapping(value="/review/list.do", method=RequestMethod.GET )
  public ModelAndView list() { 
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/review/list"); // webapp/WEB-INF/views/bookgrp/create.jsp
    return mav; // forward
  }
  
 /**
  * 등록 처리
  * @param reviewVO
  * @return
  */
 @RequestMapping(value="/review/create.do", method=RequestMethod.POST )
 public ModelAndView create(ReviewVO reviewVO) { 
   
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.reviewProc.create(reviewVO); // 등록 처리
   
   mav.setViewName("redirect:/review/list.do");   

   return mav; // forward
 }
  

}
