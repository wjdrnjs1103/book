package dev.mvc.commgrp;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class CommgrpCont {
  @Autowired
  @Qualifier("dev.mvc.commgrp.CommgrpProc")
  private CommgrpProcInter commgrpProc;

  public CommgrpCont() {
    System.out.println("-> CommgrpCont created.");
  }

  /**
   * 새로고침 방지
   * 
   * @return
   */
  @RequestMapping(value = "/commgrp/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward

    return mav; // forward
  }

  /**
   * 등록 폼 http://localhost:9091/commgrp/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/commgrp/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/commgrp/create");

    return mav; // forward
  }

  /**
   * 등록 처리 http://localhost:9091/commgrp/create.do
   * 
   * @param commgrpVO
   * @return
   */
  @RequestMapping(value = "/commgrp/create.do", method = RequestMethod.POST)
  public ModelAndView create(CommgrpVO commgrpVO) { // commgrpVO 자동 생성, Form -> VO
    // CategrpVO commgrpVO <FORM> 태그의 값으로 자동 생성됨.
    // request.setAttribute("commgrpVO", commgrpVO); 자동 실행

    ModelAndView mav = new ModelAndView();

    int cnt = this.commgrpProc.create(commgrpVO); // 등록 처리

    // cnt = 0; // error test
    if (cnt == 1) {
      mav.setViewName("redirect:/commgrp/list.do");
    } else {
      mav.addObject("code", "create");
      mav.setViewName("/commgrp/error_msg");
    }

    return mav; // forward

  }

//  /**
//   * 목록  
//   * http://localhost:9091/commgrp/list.do 
//   * @return
//   */
//  @RequestMapping(value = "/commgrp/list.do", method = RequestMethod.GET)
//  public ModelAndView list() {
//    ModelAndView mav = new ModelAndView();
//
//    // 등록 순서별 출력
//    // List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
//
//    // 출력 순서별 출력
//    List<CommgrpVO> list = this.commgrpProc.list_seqno_asc();
//
//   mav.addObject("list", list); // request.setAttribute("list", list);
//
//    mav.setViewName("/commgrp/list"); // /WEB-INF/views/commgrp/list.jsp
//    return mav;
//  }
  
  
  /**
  * Ajax 기반 목록
  *  http://localhost:9091/commgrp/list.do
  * @return
  */
  @RequestMapping(value = "/commgrp/list.do", method = RequestMethod.GET)
  public ModelAndView list_ajax() { 
    ModelAndView mav = new ModelAndView();
    
    // 등록 순서별 출력 
    // List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
    
    // 출력 순서별 출력 
    List<CommgrpVO> list = this.commgrpProc.list_seqno_asc();
    
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    mav.setViewName("/commgrp/list_ajax"); //
    return mav; 
  }
      
         

  /**
   * 조회 + 수정폼
   * http://localhost:9091/categrp/read_update.do
   * @param commgrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value = "/commgrp/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int commgrpno) {
    // request.setAttribute("commgrpno", int commgrpno) 작동 안됨.

    ModelAndView mav = new ModelAndView();

    CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno);
    mav.addObject("commgrpVO", commgrpVO); // request 객체에 저장

    List<CommgrpVO> list = this.commgrpProc.list_commgrpno_asc();
    mav.addObject("list", list); // request 객체에 저장

    mav.setViewName("/commgrp/read_update"); // /WEB-INF/views/commgrp/read_update.jsp
    return mav; // forward
  }

//  /**
//   * 
//   * 조회 + 수정폼 + Ajax, VO 전체를 JSON으로 변환하는경우
//   * http://localhost:9091/commgrp/read_update_ajax.do?commgrpno=1
//   * {"commgrpVO":"[commgrpno=1, name=문화, seqno=1, rdate=2021-04-08 17:01:28]"}
//   * 
//   * @param categrpno 조회할 카테고리 번호
//   * @return
//   */
//  @RequestMapping(value = "/commgrp/read_update_ajax.do", method = RequestMethod.GET)
//  @ResponseBody
//  public String read_update_ajax(int commgrpno) {
//    CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno);
//
//    JSONObject json = new JSONObject();
//    json.put("commgrpVO", commgrpVO);
//
//    return json.toString();
//
//  }
  
  /**
   * 조회 + 수정폼/삭제폼 + Ajax, , VO에서 각각의 필드를 JSON으로 변환하는경우
   * http://localhost:9091/commgrp/read_ajax.do?commgrpno=1
   * {"commgrpno":1,"seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
   * @param commgrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/commgrp/read_ajax.do", 
                              method=RequestMethod.GET )
  @ResponseBody
  public String read_ajax(int commgrpno) {
    CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno);
    
    JSONObject json = new JSONObject();
    json.put("commgrpno", commgrpVO.getCommgrpno());
    json.put("name", commgrpVO.getName());
    json.put("seqno", commgrpVO.getSeqno());
    json.put("rdate", commgrpVO.getRdate());
    
    // 자식 레코드의 갯수 추가
    // int count_by_categrpno = this.cateProc.count_by_categrpno(categrpno);
    // json.put("count_by_categrpno", count_by_categrpno);
    
    return json.toString();

  }
  
  /**
   * 수정 처리
   * http://localhost:9091/commgrp/update.do
   * @param commgrpVO
   * @return
   */
  @RequestMapping(value="/commgrp/update.do", 
                              method=RequestMethod.POST )
  public ModelAndView update(CommgrpVO commgrpVO) {
    // CategrpVO categrpVO <FORM> 태그의 값으로 자동 생성됨.
    // request.setAttribute("commgrpVO", commgrpVO); 자동 실행
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.commgrpProc.update(commgrpVO);
    mav.addObject("cnt", cnt); // request에 저장
    
    if (cnt == 1) {
      mav.setViewName("redirect:/commgrp/list.do");   
    } else {
      mav.setViewName("/commgrp/update_msg"); // /WEB-INF/views/commgrp/update_msg.jsp
    }
    
    return mav;
  }
  
  /**
   * 조회 + 삭제폼
   * http://localhost:9091/commgrp/read_delete.do
   * @param commgrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/commgrp/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int commgrpno) {
    ModelAndView mav = new ModelAndView();
    
    CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno); // 삭제할 자료 읽기
    mav.addObject("commgrpVO", commgrpVO);  // request 객체에 저장
    
    List<CommgrpVO> list = this.commgrpProc.list_commgrpno_asc();
    mav.addObject("list", list);  // request 객체에 저장

    mav.setViewName("/commgrp/read_delete"); // read_delete.jsp
    return mav;
  }
  
  
   /**
    * 삭제
    * http://localhost:9091/commgrp/delete.do
    * @param categrpno 조회할 카테고리 번호
    * @return
    */
   @RequestMapping(value="/commgrp/delete.do", 
                               method=RequestMethod.POST )
   public ModelAndView delete(int commgrpno) {
     ModelAndView mav = new ModelAndView();
     
     CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno); // 삭제 정보
     mav.addObject("commgrpVO", commgrpVO);  // request 객체에 저장
     
     int cnt = this.commgrpProc.delete(commgrpno); // 삭제 처리
     mav.addObject("cnt", cnt);  // request 객체에 저장
     
     if (cnt == 1) {
       mav.setViewName("redirect:/commgrp/list.do");   
     } else {
       mav.setViewName("/commgrp/delete_msg"); // /WEB-INF/views/commgrp/delete_msg.jsp
     }
  
     return mav;
   }
   
   // http://localhost:9091/commgrp/update_seqno_up.do?commgrpno=1
   // http://localhost:9091/commgrp/update_seqno_up.do?commgrpno=1000
   /**
   * 우선순위 상향 up 10 ▷ 1
   * 
   * @param commgrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value = "/commgrp/update_seqno_up.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_up(int commgrpno) {
    ModelAndView mav = new ModelAndView();

    CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno); // 카테고리 그룹 정보
    mav.addObject("commgrpVO", commgrpVO); // request 객체에 저장

    int cnt = this.commgrpProc.update_seqno_up(commgrpno); // 우선 순위 상향 처리
    mav.addObject("cnt", cnt); // request 객체에 저장

    // mav.setViewName("/commgrp/update_seqno_up_msg"); // update_seqno_up_msg.jsp
    mav.setViewName("redirect:/commgrp/list.do");

    return mav;
  }

  // http://localhost:9091/commgrp/update_seqno_down.do?commgrpno=1
  // http://localhost:9091/commgrp/update_seqno_down.do?commgrpno=1000
  /**
   * 우선순위 하향 up 1 ▷ 10
   * 
   * @param commgrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value = "/commgrp/update_seqno_down.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_down(int commgrpno) {
    ModelAndView mav = new ModelAndView();

    CommgrpVO commgrpVO = this.commgrpProc.read(commgrpno); // 카테고리 그룹 정보
    mav.addObject("commgrpVO", commgrpVO); // request 객체에 저장

    int cnt = this.commgrpProc.update_seqno_down(commgrpno);
    mav.addObject("cnt", cnt); // request 객체에 저장

    // mav.setViewName("/commgrp/update_seqno_up_msg"); // update_seqno_up_msg.jsp
    mav.setViewName("redirect:/commgrp/list.do");

    return mav;
  }
}
