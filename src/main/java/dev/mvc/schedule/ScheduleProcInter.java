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
   * 조회
   * @param classno
   * @return
   */
  public ScheduleVO read_by_classno(int classno);
  
  /**
   * 등록
   * @param scheduleVO
   * @return 등록된 레코드 갯수
   */
  public int create(ScheduleVO scheduleVO);
  
  /**
   * 수정 처리
   * @param scheduleVO
   * @return 처리된 레코드 갯수
   */
  public int update(ScheduleVO scheduleVO);
  
  /**
   * 삭제 처리
   * @param classno
   * @return 처리된 레코드 갯수
   */
  public int delete(int classno);

}
