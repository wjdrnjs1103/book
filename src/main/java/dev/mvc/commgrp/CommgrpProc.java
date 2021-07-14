package dev.mvc.commgrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;



@Component("dev.mvc.commgrp.CommgrpProc")
public class CommgrpProc implements CommgrpProcInter{
  
  @Autowired  // DI: Spring 자동으로 구현한 DAO class 객체를 할당
  private CommgrpDAOInter commgrpDAO;
  
  @Override
  public int create(CommgrpVO commgrpVO) {
    int cnt = commgrpDAO.create(commgrpVO);
    
    return cnt;
  }
  
  @Override
  public List<CommgrpVO> list_commgrpno_asc() {
    List<CommgrpVO> list = null;
    list = this.commgrpDAO.list_commgrpno_asc();
    return list;
  }
  
  @Override
  public List<CommgrpVO> list_seqno_asc() {
    List<CommgrpVO> list = null;
    list = this.commgrpDAO.list_seqno_asc();
    return list;
  }

  @Override
  public CommgrpVO read(int commgrpno) {
    CommgrpVO commgrpVO = null;
    commgrpVO = this.commgrpDAO.read(commgrpno);
    
    return commgrpVO;
  }

  
  @Override 
  public int update(CommgrpVO commgrpVO) { 
    int cnt = 0; 
    cnt = this.commgrpDAO.update(commgrpVO);
  
    return cnt; 
  }
    
  
  @Override 
  public int delete(int commgrpno) { 
    int cnt = 0; 
    cnt = this.commgrpDAO.delete(commgrpno);
  
    return cnt; 
  }
  
  @Override
  public int update_seqno_up(int commgrpno) {
    int cnt = 0;
    cnt = this.commgrpDAO.update_seqno_up(commgrpno);
    
    return cnt;
  }

  @Override
  public int update_seqno_down(int commgrpno) {
    int cnt = 0;
    cnt = this.commgrpDAO.update_seqno_down(commgrpno);    
    return cnt;
  }
  
}
