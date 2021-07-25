package dev.mvc.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.schedule.ScheduleProc")
public class ScheduleProc implements ScheduleProcInter {
  @Autowired
  private ScheduleDAOInter scheduleDAO;

  @Override
  public List<ScheduleVO> list(int memberno) {
    List<ScheduleVO> list =this.scheduleDAO.list(memberno);
    return list;
  }

  @Override
  public ScheduleVO read(int memberno) {
    ScheduleVO scheduleVO = this.scheduleDAO.read(memberno);
    return scheduleVO;
  }

  @Override
  public int create(ScheduleVO scheduleVO) {
    int cnt = this.scheduleDAO.create(scheduleVO);
    return cnt;
  } 
  

}
