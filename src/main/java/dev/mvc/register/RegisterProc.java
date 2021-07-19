package dev.mvc.register;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.register.RegisterProc")
public class RegisterProc implements RegisterProcInter {
  @Autowired
  private RegisterDAOInter registerDAO;
  
  public RegisterProc(){
    System.out.println("-> RegisterProc created.");
  }

  @Override
  public int checkID(String id) {
    // this.memberDAO.hashCode();
    int cnt = this.registerDAO.checkID(id);
    return cnt;
  }
  
  @Override
  public int create(RegisterVO registerVO) {
    int cnt = this.registerDAO.create(registerVO);
    return cnt;
  }
  
  @Override
  public RegisterVO readById(String id) {
    RegisterVO registerVO = this.registerDAO.readById(id);
    return registerVO;
  }
  
  @Override
  public int passwd_check(HashMap<Object, Object> map) {
    int cnt = this.registerDAO.passwd_check(map);
    return cnt;
  }

  @Override
  public int passwd_update(HashMap<Object, Object> map) {
    int cnt = this.registerDAO.passwd_update(map);
    return cnt;
  }
  
  @Override
  public int login(Map<String, Object> map) {
    int cnt = this.registerDAO.login(map);
    return cnt;
  }
  

  @Override
  public boolean isMember(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    int grade = 99;
    
    // System.out.println("-> grade: " + session.getAttribute("grade"));
    if (session != null) {
      String id = (String)session.getAttribute("id");
      if (session.getAttribute("grade") != null) {
        grade = (int)session.getAttribute("grade");
      }
      
      if (id != null && grade <= 20){ // 관리자 + 회원
        sw = true;  // 로그인 한 경우
      }
    }
    
    return sw;
  }

  @Override
  public boolean isAdmin(HttpSession session) {
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    int grade = 99;
    
    // System.out.println("-> grade: " + session.getAttribute("grade"));
    if (session != null) {
      String id = (String)session.getAttribute("id");
      if (session.getAttribute("grade") != null) {
        grade = (int)session.getAttribute("grade");
      }
      
      if (id != null && grade <= 10){ // 관리자
        sw = true;  // 로그인 한 경우
      }
    }
    
    return sw;
  }  
  
  // 아이디 조회
  @Override
  public RegisterVO read(int memberno) {
    RegisterVO registerVO = this.registerDAO.read(memberno);
    return registerVO;
  }  

}
