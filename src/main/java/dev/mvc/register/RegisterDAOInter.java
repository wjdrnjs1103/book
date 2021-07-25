package dev.mvc.register;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface RegisterDAOInter {
  /**
   * 회원 등록
   * @param RegisterVO
   * @return 등록된 갯수
   */
  public int create(RegisterVO registerVO);
  
  /**
   * 회원 전체 목록
   * @return
   */
  public List<RegisterVO> list();
  
  /**
   * 중복 아이디 검사
   * @param id
   * @return 중복 아이디 갯수
   */
  public int checkID(String id);
  
  /**
   * id로 회원 정보 조회
   * @param id
   * @return
   */
  public RegisterVO readById(String id);
    
  /**
   * 현재 패스워드 검사
   * @param map
   * @return 0: 일치하지 않음, 1: 일치함
   */
  public int passwd_check(HashMap<Object, Object> map);
  
  /**
   * 패스워드 변경
   * @param map
   * @return 변경된 패스워드 갯수
   */
  public int passwd_update(HashMap<Object, Object> map);
  
  /**
   * 로그인 처리
   */
  public int login(Map<String, Object> map);
  
  /** 추가
   * memberno로 회원정보 조회
   * @param memberno
   * @return
   */
  public RegisterVO read(int memberno);


}
