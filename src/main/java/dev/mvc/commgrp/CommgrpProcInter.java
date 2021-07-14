package dev.mvc.commgrp;

import java.util.List;

public interface CommgrpProcInter {

  /**
   * 등록
   * 
   * @param commgrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(CommgrpVO commgrpVO);

  /**
   * 등록 순서별 목록
   * 
   * @return
   */
  public List<CommgrpVO> list_commgrpno_asc();

  /**
   * 출력 순서별 목록
   * 
   * @return
   */
  public List<CommgrpVO> list_seqno_asc();

  /**
   * 조회, 수정폼, 삭제폼
   * 
   * @param commgrpno 카테고리 그룹 번호, PK
   * @return
   */
  public CommgrpVO read(int commgrpno);

  /**
   * 수정 처리
   * 
   * @param commgrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(CommgrpVO commgrpVO);
  
  /**
   * 삭제 처리
   * 
   * @param commgrpno
   * @return 처리된 레코드 갯수
  */
  public int delete(int commgrpno);
  
  /**
   * 출력 순서 상향
   * 
   * @param commgrpno
   * @return 처리된 레코드 갯수
  */
  public int update_seqno_up(int commgrpno);
    
  /**
   * 출력 순서 하향
   * 
   * @param commgrpno
   * @return 처리된 레코드 갯수
  */
  public int update_seqno_down(int commgrpno);
         
}
