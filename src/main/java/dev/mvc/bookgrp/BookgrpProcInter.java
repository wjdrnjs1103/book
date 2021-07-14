package dev.mvc.bookgrp;

import java.util.List;

public interface BookgrpProcInter {
  /**
   * 등록
   * @param bookgrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(BookgrpVO bookgrpVO);
  
  /**
   * 등록 순서별 목록
   * @return
   */
  public List<BookgrpVO> list_bookgrpno_asc();
 
  /**
   * 조회, 수정폼
   * @param bookgrpno 카테고리 그룹 번호, PK
   * @return
   */
  public BookgrpVO read(int bookgrpno);
  
  /**
   * 수정 처리
   * @param bookgrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(BookgrpVO bookgrpVO);
  
  /**
   * 삭제 처리
   * @param bookgrpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int bookgrpno);
  
  /**
   * 출력 순서 상향
   * @param bookgrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_up(int bookgrpno);
 
  /**
   * 출력 순서 하향
   * @param bookgrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int bookgrpno); 
  
  /**
   * 출력 순서별 목록
   * @return
   */
  public List<BookgrpVO> list_seqno_asc();
  
}