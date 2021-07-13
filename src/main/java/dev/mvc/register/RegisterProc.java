package dev.mvc.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.register.RegisterProc")
public class RegisterProc implements RegisterProcInter {
  @Autowired
  private RegisterDAOInter registerDAOInter;
  
  
  @Override
  public int create(RegisterVO registerVO) {
    int cnt = this.registerDAOInter.create(registerVO);
    return cnt;
  }

}
