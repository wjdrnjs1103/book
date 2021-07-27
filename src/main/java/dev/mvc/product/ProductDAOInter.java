package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

public interface ProductDAOInter {
  /**
   * 등록
   * @param contentsVO
   * @return
   */
  public int create(ProductVO productVO);
  
  /**
   * 특정 카테고리의 등록된 글목록
   * @return
   */
  public List<ProductVO> list_by_bookno(int bookno);
  
  /**
   * 전공도서별 검색 목록
   * @param hashMap
   * @return
   */
  public List<ProductVO> list_by_bookno_search(HashMap<String, Object> hashMap);

  /**
   * 전공도서별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public List<ProductVO> list_by_bookno_search_paging(HashMap<String, Object> map);
  
  /**
   * 조회
   * @param productno
   * @return
   */
  public ProductVO read(int productno);
  
  /**
   * 상품 정보 수정 처리
   * @param productVO
   * @return
   */
  public int product_update(ProductVO productVO);
 
  /**
   * 텍스트 정보 수정
   * @param contentsVO
   * @return
   */
  public int update_text(ProductVO productVO);
  
  /**
   * 파일 정보 수정
   * @param productVO
   * @return
   */
  public int update_file(ProductVO productVO);
  
  /**
   * 삭제
   * @param productno
   * @return
   */
  public int delete(int productno);
  
  /**
   * 판매 여부 상태 수정
   * @param productno
   * @return
   */
  
  public int update_stateno(int productno);
  
  /**
   * 판매 여부 상태 추출
   * @param productno
   * @return
   */
  public int get_stateno(int productno);
  
  /**
   * 최근게시글 추출
   * @return
   */
  public List<ProductVO> load();
  
}