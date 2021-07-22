package dev.mvc.message;

import java.util.List;

import dev.mvc.product.ProductVO;

public interface MessageDAOInter {
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
  
  /**
   * 보낸이 이름출력
   * @param send_member
   * @return 등록된 갯수
   */
  public MessageVO get_sender_name(int send_member);
  
  /**
   * 쪽지 삭제 처리
   * @param memberno
   * @return
   */
  public int delete(int messageno);
  
  /**
   * message로 쪽지 정보 조회
   * @param memberno
   * @return
   */
  public MessageVO read(int messageno);

}
