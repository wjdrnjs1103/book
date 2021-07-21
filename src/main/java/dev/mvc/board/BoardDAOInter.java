package dev.mvc.board;

import java.util.HashMap;
import java.util.List;


public interface BoardDAOInter {
  
  /**
   * 등록
   * @param boardVO
   * @return
   */
  public int create(BoardVO boardVO);
  
  /**
   * 특정 커뮤니티 등록된 글 목록, List
   * @param commgrpno
   * @return
   */
  public List<BoardVO> list_by_commgrpno(int commgrpno);
 
  /**
   * 커뮤니티 그룹별 목록 +검색
   * @param hashMap
   * @return
   */
  public List<BoardVO> list_by_commgrpno_search(HashMap<String, Object> hashMap);

  /**
   * 커뮤니티 그룹별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * 커뮤니티 그룹별 목록 + 검색 + 페이징
   * @param map
   * @return
   */
  public List<BoardVO> list_by_commgrpno_search_paging(HashMap<String, Object> map);
  
  /**
   * 공지사항 그룹별 목록 + 검색 + 페이징
   * @param map
   * @return
   */
  public List<BoardVO> list_by_commgrpno_notice_search_paging(HashMap<String, Object> map);
  
  /**
   * QnA 그룹별 목록 + 검색 + 페이징
   * @param map
   * @return
   */
  public List<BoardVO> list_by_commgrpno_qna_search_paging(HashMap<String, Object> map);
  
  /**
   * Commgrp + Board join 연결 목록
   * @return
   */
  public List<Commgrp_BoardVO> list_all_join();  
  
  /**
   * Commgrp + Board join 연결, commgrp 선택 목록
   * @return
   */
  public List<Commgrp_BoardVO> list_by_commgrpno_join(HashMap<String, Object> map); 
  
  /**
   * Grid 
   * 페이지 목록 문자열 생성, Box 형태
   * @param list_file 목록 파일명 
   * @param commgrpno 카테고리번호
   * @param search_count 검색 갯수
   * @param now_page 현재 페이지, now_page는 1부터 시작
   * @return
   */
  public String pagingBox2(String list_file, int commgrpno, int search_count, int now_page);
  
  /**
   * 특정 커뮤니티 등록된 글 목록, Grid List
   * @param commgrpno
   * @return
   */
  public List<BoardVO> list_by_commgrpno_grid(int commgrpno);

  /**
   * 커뮤니티 그룹별 Grid 목록 + 페이징
   * @param map
   * @return
   */
  public List<BoardVO> list_by_commgrpno_grid_paging(HashMap<String, Object> map);

  /**
   * 조회
   * @param boardno
   * @return
   */
  public BoardVO read(int boardno);
  
  /**
   * 게시글 수정 및 파일 수정
   * @param boardVO
   * @return
   */
  public int update(BoardVO boardVO);
  
  /**
   * 삭제
   * @param boardno
   * @return
   */
  public int delete(int boardno);
  
  /**
   * 댓글 수 증가
   * @param boardno
   * @return
   */ 
  public int increaseBreplycnt(int boardno);
 
  /**
   * 댓글 수 감소
   * @param boardno
   * @return
   */   
  public int decreaseBreplycnt(int boardno);
 
 
}
