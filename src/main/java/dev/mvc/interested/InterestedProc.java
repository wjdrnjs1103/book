package dev.mvc.interested;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.interested.InterestedProc")
public class InterestedProc implements InterestedProcInter {

  @Autowired
  private InterestedDAOInter interestedDAO;
  
  @Override
  public int create(InterestedVO interestedVO) {
    int cnt = this.interestedDAO.create(interestedVO);
    return cnt;
  }

  @Override
  public List<InterestedVO> list(int memberno) {
    List<InterestedVO> list = this.interestedDAO.list(memberno);
    return list;
  }

  @Override
  public int delete(int interestedno) {
    int cnt = this.interestedDAO.delete(interestedno);
    return cnt;
  }

}
