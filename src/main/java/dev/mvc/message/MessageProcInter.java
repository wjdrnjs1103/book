package dev.mvc.message;

import java.util.List;

import dev.mvc.product.ProductVO;

public interface MessageProcInter {
  /**
   * 쪽지 보내기
   * @param MessageVO
   * @return 등록된 갯수
   */
  public int create(MessageVO messageVO);
  
  /**
   * 게시글 작성자의 회원번호 추출
   * @param productno
   * @return 등록된 갯수
   */
  public int get_memberno(int productno);
  
  /**
   * 목록
   * @param recv_member
   * @return
   */
  public List<MessageVO> list(int recv_member);
  
  /**
   * 메세지 갯수출력
   * @param recv_member
   * @return 등록된 갯수
   */
  public int count_by_memberno(int recv_member);
  

}
