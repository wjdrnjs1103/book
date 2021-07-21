package dev.mvc.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import dev.mvc.register.RegisterProcInter;

@Controller
public class ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc") // 이름 지정
  private ReplyProcInter replyProc;
  
  // @Autowired
  // @Qualifier("dev.mvc.admin.AdminProc") // 이름 지정
  // private AdminProcInter adminProc;

  @Autowired
  @Qualifier("dev.mvc.register.RegisterProc") // 이름 지정
  private RegisterProcInter registerProc;
  
  public ReplyCont(){
    System.out.println("-> ReplyCont created.");
  }
  
  @ResponseBody
  @RequestMapping(value = "/reply/create.do",
                            method = RequestMethod.POST,
                            produces = "text/plain;charset=UTF-8")
  public String create(HttpServletRequest request, ReplyVO replyVO) {
    int count = replyProc.create(replyVO);
    
    JSONObject obj = new JSONObject();
    obj.put("count",count);
    // System.out.println("count " + count);
    return obj.toString(); // {"count":1}
  }
  
  @RequestMapping(value="/reply/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (registerProc.isAdmin(session)) {
      List<ReplyVO> list = replyProc.list();
      
      mav.addObject("list", list);
      mav.setViewName("/reply/list_join"); // /webapp/reply/list.jsp

    } else {
      mav.setViewName("redirect:/admin/login_need.jsp"); // /webapp/admin/login_need.jsp
    }
    
    return mav;
  }
  
  
  /**
   <xmp>
   http://localhost:9090/ojt/reply/list_by_boardno.do?boardno=1
   글이 없는 경우: {"list":[]}
   글이 있는 경우
   {"list":[
            {"memberno":1,"rdate":"2019-12-18 16:46:43","passwd":"123","replyno":3,"content":"댓글 3","contentsno":1}
            ,
            {"memberno":1,"rdate":"2019-12-18 16:46:39","passwd":"123","replyno":2,"content":"댓글 2","contentsno":1}
            ,
            {"memberno":1,"rdate":"2019-12-18 16:46:35","passwd":"123","replyno":1,"content":"댓글 1","contentsno":1}
            ] 
   }  
     </xmp>  
   * @param boardno
   * @return
   */
   @ResponseBody
   @RequestMapping(value = "/reply/list_by_boardno.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
   public String list_by_boardno(int boardno) {
     List<ReplyVO> list = replyProc.list_by_boardno(boardno);
    
     JSONObject obj = new JSONObject();
     obj.put("list", list);
     return obj.toString(); 
 
   }
    
   /**
   컨텐츠별 댓글 목록 
   {
   "list":[
            {
              "memberno":1,
              "replydate":"2019-12-18 16:46:35",
              "replypwd":"123",
              "replyno":1,
              "id":"user1",
              "replycontent":"댓글 1",
              "boardno":1
            }
            ,
            {
              "memberno":1,
              "replydate":"2019-12-18 16:46:35",
              "replypwd":"123",
              "replyno":1,
              "id":"user1",
              "replycontent":"댓글 1",
              "boardno":1
            }
          ]
    }
    * http://localhost:9090/reply/list_by_boardno_join.do?boardno=53
    * @param boardno
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "/reply/list_by_boardno_join.do",
                               method = RequestMethod.GET,
                               produces = "text/plain;charset=UTF-8")
   public String list_by_boardno_join(int boardno) {
     // String msg="JSON 출력";
     // return msg;
     
     List<ReplyMemberVO> list = replyProc.list_by_boardno_join(boardno);
     
     JSONObject obj = new JSONObject();
     obj.put("list", list);
  
     return obj.toString();     
   }
   
   /**
    * 패스워드를 검사한 후 삭제 
    * http://localhost:9090/resort/reply/delete.do?replyno=1&replypwd=1234
    * {"delete_cnt":0,"replypwd_cnt":0}
    * {"delete_cnt":1,"replypwd_cnt":1}
    * @param replyno
    * @param passwd
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "/reply/delete.do", 
                               method = RequestMethod.POST,
                               produces = "text/plain;charset=UTF-8")
   public String delete(int replyno, String replypwd) {
     Map<String, Object> map = new HashMap<String, Object>();
     map.put("replyno", replyno);
     map.put("replypwd", replypwd);
     
     int replypwd_cnt = replyProc.checkPasswd(map); // 패스워드 일치 여부, 1: 일치, 0: 불일치
     int delete_cnt = 0;                                    // 삭제된 댓글
     if (replypwd_cnt == 1) { // 패스워드가 일치할 경우
       delete_cnt = replyProc.delete(replyno); // 댓글 삭제
     }
     
     JSONObject obj = new JSONObject();
     obj.put("replypwd_cnt", replypwd_cnt); // 패스워드 일치 여부, 1: 일치, 0: 불일치
     obj.put("delete_cnt", delete_cnt); // 삭제된 댓글
     
     return obj.toString();
   }
   
   /**
    * 더보기 버튼 페이징 목록
    * http://localhost:9090/resort/reply/list_by_boardno_join_add.do?boardno=53&replyPage=1
    * @param contentsno 댓글 부모글 번호
    * @param replyPage 댓글 페이지
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "/reply/list_by_boardno_join_add.do",
                               method = RequestMethod.GET,
                               produces = "text/plain;charset=UTF-8")
   public String list_by_boardno_join_add(int boardno, int replypage) {
   //    System.out.println("boardno: " + boardno);
   //    System.out.println("replypage: " + replypage);
     
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("boardno", boardno); 
     map.put("replypage", replypage);    

     
     List<ReplyMemberVO> list = replyProc.list_by_boardno_join_add(map);
     
     JSONObject obj = new JSONObject();
     obj.put("list", list);
  
     return obj.toString();     
   }
}
