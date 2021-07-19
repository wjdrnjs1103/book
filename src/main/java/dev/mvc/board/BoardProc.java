package dev.mvc.board;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.board.BoardProc")
public class  BoardProc implements BoardProcInter {
  
  @Autowired
  private BoardDAOInter boardDAO;

  @Override
  public int create(BoardVO boardVO) {
    int cnt = this.boardDAO.create(boardVO);
    return cnt;
  }

  @Override
  public List<BoardVO> list_by_commgrpno(int commgrpno) {
    List<BoardVO> list = this.boardDAO.list_by_commgrpno(commgrpno);
    
    for (BoardVO boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = boardVO.getTitle();
      if (title.length() > 50) {
        title = title.substring(0, 50) + "...";
        boardVO.setTitle(title);
      }
    }
    
    return list;
  }

  @Override
  public List<BoardVO> list_by_commgrpno_search(HashMap<String, Object> hashMap) {
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_search(hashMap);
    
    for (BoardVO boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = boardVO.getTitle();
      if (title.length() > 50) {
        title = title.substring(0, 50) + "...";
        boardVO.setTitle(title);
      }
    }
    return list;
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int count = boardDAO.search_count(hashMap);
    return count;
  }
  
  /** 
   * List 페이징 구현 paggingBox
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param list_file 목록 파일명 
   * @param cateno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param now_page     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(String list_file, int commgrpno, int search_count, String word, int now_page){ 
    int total_page = (int)(Math.ceil((double)search_count/Boards.RECORD_PER_PAGE)); // 전체 페이지 수 
    int total_grp = (int)(Math.ceil((double)total_page/Boards.PAGE_PER_BLOCK)); // 전체 그룹  수
    int now_grp = (int)(Math.ceil((double)now_page/Boards.PAGE_PER_BLOCK));  // 현재 그룹 번호
    
    // 1 group: 1 2 3
    // 2 group: 4 5 6
    // 3 group: 7 8 9
    int start_page = ((now_grp - 1) * Boards.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
    int end_page = (now_grp * Boards.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link { color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{ background-color: white; color: black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none; color: #c9c9c9; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    text-weight: bold;");
    str.append("    color: black;");
    str.append("    font-size: 1em;");
    str.append("    border: 1px;"); 
    str.append("    border-style: none;"); 
    str.append("    border-color: white;"); 
    str.append("    padding:3px 7px 3px 7px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 9px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    text-weight: bold;");    
    str.append("    background-color: white;"); 
    str.append("    color: black;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #c9c9c9;"); 
    str.append("    padding:3px 7px 3px 7px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 8px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // now_grp: 1 (1 ~ 10 page)
    // now_grp: 2 (11 ~ 20 page)
    // now_grp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
    int _now_page = (now_grp - 1) * Boards.PAGE_PER_BLOCK;  
    if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 이전 그룹으로 갈수 있는 링크 생성 
      str.append("<span class='span_box_1'><A href='"+list_file+"?commgrpno="+commgrpno+"&word="+word+"&now_page="+_now_page+"'>이전</A></span>"); 
    } 
 
    // 중앙의 페이지 목록
    for(int i=start_page; i<=end_page; i++){ 
      if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이 출력 종료
        break; 
      } 
  
      if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
        str.append("<span class='span_box_1'><A href='"+list_file+"?commgrpno="+commgrpno+"&word="+word+"&now_page="+i+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 시작페이지 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 시작페이지 21
    _now_page = (now_grp * Boards.PAGE_PER_BLOCK)+1;  
    if (now_grp < total_grp){ 
      str.append("<span class='span_box_1'><A href='"+list_file+"?commgrpno="+commgrpno+"&word="+word+"&now_page="+_now_page+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  // 자유게시판 목록
  @Override
  public List<BoardVO> list_by_commgrpno_search_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지 시작 rownum: now_page = 1, (1 - 1) * 10 --> 0 
    2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10
    3 페이지 시작 rownum: now_page = 3, (3 - 1) * 10 --> 20
    */
    int begin_of_page = ((Integer)map.get("now_page") - 1) * Boards.RECORD_PER_PAGE;
   
    // 시작 rownum 결정
    // 1 페이지 = 0 + 1, 2 페이지 = 10 + 1, 3 페이지 = 20 + 1 
    int start_num = begin_of_page + 1;
    
    //  종료 rownum
    // 1 페이지 = 0 + 10, 2 페이지 = 0 + 20, 3 페이지 = 0 + 30
    int end_num = begin_of_page + Boards.RECORD_PER_PAGE;   
    /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
    map.put("start_num", start_num);
    map.put("end_num", end_num);
   
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_search_paging(map);
    
    for (BoardVO boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = boardVO.getTitle();
      if (title.length() > 30) {
        title = title.substring(0, 30) + "...";
        boardVO.setTitle(title);
      }      
    }
    return list;
  }
  
  // 공지사항 목록
  @Override
  public List<BoardVO> list_by_commgrpno_notice_search_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지 시작 rownum: now_page = 1, (1 - 1) * 10 --> 0 
    2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10
    3 페이지 시작 rownum: now_page = 3, (3 - 1) * 10 --> 20
    */
    int begin_of_page = ((Integer)map.get("now_page") - 1) * Boards.RECORD_PER_PAGE;
   
    // 시작 rownum 결정
    // 1 페이지 = 0 + 1, 2 페이지 = 10 + 1, 3 페이지 = 20 + 1 
    int start_num = begin_of_page + 1;
    
    //  종료 rownum
    // 1 페이지 = 0 + 10, 2 페이지 = 0 + 20, 3 페이지 = 0 + 30
    int end_num = begin_of_page + Boards.RECORD_PER_PAGE;   
    /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
    map.put("start_num", start_num);
    map.put("end_num", end_num);
   
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_notice_search_paging(map);
    
    for (BoardVO boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = boardVO.getTitle();
      if (title.length() > 30) {
        title = title.substring(0, 30) + "...";
        boardVO.setTitle(title);
      }      
    }
    return list;
  }
  
  // QnA 목록
  @Override
  public List<BoardVO> list_by_commgrpno_qna_search_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지 시작 rownum: now_page = 1, (1 - 1) * 10 --> 0 
    2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10
    3 페이지 시작 rownum: now_page = 3, (3 - 1) * 10 --> 20
     */
    int begin_of_page = ((Integer)map.get("now_page") - 1) * Boards.RECORD_PER_PAGE;
    
    // 시작 rownum 결정
    // 1 페이지 = 0 + 1, 2 페이지 = 10 + 1, 3 페이지 = 20 + 1 
    int start_num = begin_of_page + 1;
    
    //  종료 rownum
    // 1 페이지 = 0 + 10, 2 페이지 = 0 + 20, 3 페이지 = 0 + 30
    int end_num = begin_of_page + Boards.RECORD_PER_PAGE;   
    /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
     */
    map.put("start_num", start_num);
    map.put("end_num", end_num);
    
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_notice_search_paging(map);
    
    for (BoardVO boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = boardVO.getTitle();
      if (title.length() > 30) {
        title = title.substring(0, 30) + "...";
        boardVO.setTitle(title);
      }      
    }
    return list;
  }
  
  @Override
  public List<Commgrp_BoardVO> list_all_join() {
    List<Commgrp_BoardVO> list = this.boardDAO.list_all_join();
    return list;
  }
  
  @Override
  public List<Commgrp_BoardVO> list_by_commgrpno_join(HashMap<String, Object> map) {
    
    List<Commgrp_BoardVO> list = this.boardDAO.list_by_commgrpno_join(map);
    
    for (Commgrp_BoardVO commgrp_boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = Tool.convertChar(commgrp_boardVO.getTitle());
      if (title.length() > 50) {
        title = title.substring(0, 50) + "...";
        commgrp_boardVO.setTitle(title);
      }
    }
    return list;
  }
  
  /** 
   * Grid 페이징 구현 paggingBox2
   */
  @Override
  public String pagingBox2(String list_file, int commgrpno, int search_count, int now_page) {
    int total_page = (int)(Math.ceil((double)search_count/Boards.RECORD_PER_PAGE2)); // 전체 페이지 수 
    int total_grp = (int)(Math.ceil((double)total_page/Boards.PAGE_PER_BLOCK)); // 전체 그룹  수
    int now_grp = (int)(Math.ceil((double)now_page/Boards.PAGE_PER_BLOCK));  // 현재 그룹 번호
    
    int start_page = ((now_grp - 1) * Boards.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
    int end_page = (now_grp * Boards.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link { color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{ background-color: white; color: black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none; color: #c9c9c9; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    text-weight: bold;");
    str.append("    color: black;");
    str.append("    font-size: 1em;");
    str.append("    border: 1px;"); 
    str.append("    border-style: none;"); 
    str.append("    border-color: white;"); 
    str.append("    padding:3px 7px 3px 7px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 9px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    text-weight: bold;");    
    str.append("    background-color: white;"); 
    str.append("    color: black;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #c9c9c9;"); 
    str.append("    padding:3px 7px 3px 7px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 8px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging2'>"); 
    // str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // now_grp: 1 (1 ~ 10 page)
    // now_grp: 2 (11 ~ 20 page)
    // now_grp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
    int _now_page = (now_grp - 1) * Boards.PAGE_PER_BLOCK;  
    if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 이전 그룹으로 갈수 있는 링크 생성 
      str.append("<span class='span_box_1'><A href='"+list_file+"?commgrpno="+commgrpno+"&now_page="+_now_page+"'>이전</A></span>"); 
    } 
 
    // 중앙의 페이지 목록
    for(int i=start_page; i<=end_page; i++){ 
      if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이 출력 종료
        break; 
      } 
  
      if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
        str.append("<span class='span_box_1'><A href='"+list_file+"?commgrpno="+commgrpno+"&now_page="+i+"'>"+i+"</A></span>");   

      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 시작페이지 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 시작페이지 21
    _now_page = (now_grp * Boards.PAGE_PER_BLOCK)+1;  
    if (now_grp < total_grp){ 
      str.append("<span class='span_box_1'><A href='"+list_file+"?commgrpno="+commgrpno+"&now_page="+_now_page+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
/*  @Override
  public List<BoardVO> list_by_commgrpno_grid_paging(HashMap<String, Object> map) {
     
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지 시작: LIMIT 0, 10 
    2 페이지 시작: LIMIT 10, 10 
    3 페이지 시작: LIMIT 20, 10 

    offset 결정, 1페이지당 출력할 레코드 갯수 10개
    1 페이지 = 0 * 10: LIMIT 0, 10
    2 페이지 = 1 * 10: LIMIT 10, 10
    3 페이지 = 2 * 10: LIMIT 20, 10
      
    int offset = ((Integer)map.get("now_page") - 1) * Boards.RECORD_PER_PAGE2;
    System.out.println("-> offset: " + offset);
    
    map.put("offset", offset);
    map.put("page_size", Boards.RECORD_PER_PAGE2);
    System.out.println("-> grid page_size: " + Boards.RECORD_PER_PAGE2);
    
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_grid_paging(map);
    
    System.out.println("-> grid lis: "+list.size());
    
    for (BoardVO boardVO : list) { // 제목이 50자 이상이면 50자만 show
      String title = Tool.convertChar(boardVO.getTitle());
      if (title.length() > 50) {
        title = title.substring(0, 50) + "...";
        boardVO.setTitle(title);
      }
    }
    return list;
  }
  */
  
  @Override
  public List<BoardVO> list_by_commgrpno_grid(int commgrpno) {
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_grid(commgrpno);
    
    for (BoardVO boardVO : list) { // 제목이 30자 이상이면 18자만 show
      String title = Tool.convertChar(boardVO.getTitle());
      if (title.length() > 30) {
        title = title.substring(0, 30) + "...";
        boardVO.setTitle(title);
      }
    }
    
    return list;
  }

  @Override
  public List<BoardVO> list_by_commgrpno_grid_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지 시작 rownum: now_page = 1, (1 - 1) * 10 --> 0 
    2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10
    3 페이지 시작 rownum: now_page = 3, (3 - 1) * 10 --> 20
    */
    int begin_of_page = ((Integer)map.get("now_page") - 1) * Boards.RECORD_PER_PAGE2;
   
    // 시작 rownum 결정
    // 1 페이지 = 0 + 1, 2 페이지 = 10 + 1, 3 페이지 = 20 + 1 
    int start_num = begin_of_page + 1;
    
    //  종료 rownum
    // 1 페이지 = 0 + 10, 2 페이지 = 0 + 20, 3 페이지 = 0 + 30
    int end_num = begin_of_page + Boards.RECORD_PER_PAGE2;   
    /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
    map.put("start_num", start_num);
    map.put("end_num", end_num);
   
    List<BoardVO> list = this.boardDAO.list_by_commgrpno_grid_paging(map);
    
    for (BoardVO boardVO : list) { // 제목이 30자 이상이면 30자만 show
      String title = Tool.convertChar(boardVO.getTitle());
      if (title.length() > 30) {
        title = title.substring(0, 30) + "...";
        boardVO.setTitle(title);
      }      
    }
    return list;
  }

  @Override
  public BoardVO read(int boardno) {
    BoardVO boardVO = this.boardDAO.read(boardno);
    
    String title = boardVO.getTitle();
    // String bcon = boardVO.getBcon();
    
    title = Tool.convertChar(title);  // 특수 문자 처리
    boardVO.setTitle(title); 
    
    // bcon = Tool.convertChar(bcon); 
    // boardVO.setContent(bcon);  
    
    long bsize = boardVO.getBsize();
    boardVO.setSize1_label(Tool.unit(bsize));
    
    return boardVO;
  }
  
  @Override
  public BoardVO read_update(int boardno) {
    BoardVO boardVO = this.boardDAO.read(boardno);
    return boardVO;
  }
  
  @Override
  public int update(BoardVO boardVO) {
    int cnt = this.boardDAO.update(boardVO);
    return cnt;
  }

  @Override
  public int delete(int boardno) {
    int cnt = this.boardDAO.delete(boardno);
    return cnt;
  }
 
  
}
