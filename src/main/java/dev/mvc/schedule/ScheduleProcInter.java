package dev.mvc.schedule;

import java.util.List;

public interface ScheduleProcInter {
  /**
   * 목록
   * @param memberno
   * @return
   */
  public List<ScheduleVO> list(int memberno);
  
  /**
   * 조회
   * @param memberno
   * @return
   */
  public ScheduleVO read(int memberno);
  
  /**
   * 등록
   * @param scheduleVO
   * @return 등록된 레코드 갯수
   */
  public int create(ScheduleVO scheduleVO);

}
