package dev.mvc.review;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.board.BoardVO;
import dev.mvc.board.Commgrp_BoardVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.review.ReviewProc")
public class ReviewProc implements ReviewProcInter{
  @Autowired
  private ReviewDAOInter reviewDAO;

  @Override
  public int create(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.create(reviewVO);
    return cnt;
  }

  @Override
  public List<ReviewVO> list_reviewno_asc() {
    List<ReviewVO> list = this.reviewDAO.list_reviewno_asc();
    return list;
  }

  @Override
  public List<ReviewVO> list_by_productno(int productno) {
    List<ReviewVO> list = this.reviewDAO.list_by_productno(productno);    
    for (ReviewVO reviewVO : list) { // 제목이 50자 이상이면 50자만 show
      String content = reviewVO.getContent();
      if (content.length() > 50) {
        content = content.substring(0, 50) + "...";
        reviewVO.setContent(content);
      }
    }
    
    return list;
  }
  
  @Override
  public List<ReviewVO> list_by_memberno(int memberno) {
    List<ReviewVO> list = this.reviewDAO.list_by_memberno(memberno);    
    for (ReviewVO reviewVO : list) { // 제목이 50자 이상이면 50자만 show
      String content = reviewVO.getContent();
      if (content.length() > 50) {
        content = content.substring(0, 50) + "...";
        reviewVO.setContent(content);
      }
    }
    
    return list;
  }
  
  @Override
  public List<Product_ReviewVO> list_all_join() {
    List<Product_ReviewVO> list = this.reviewDAO.list_all_join();
    return list;
  }

  @Override
  public List<Product_ReviewVO> list_by_productno_join(HashMap<String, Object> map) {
    
    List<Product_ReviewVO> list = this.reviewDAO.list_by_productno_join(map);
    
    for (Product_ReviewVO product_reviewVO : list) { // 제목이 50자 이상이면 50자만 show
      String content = Tool.convertChar(product_reviewVO.getContent());
      if (content.length() > 50) {
        content = content.substring(0, 50) + "...";
        product_reviewVO.setContent(content);
      }
    }
    return list;
  }
  
  @Override
  public ReviewVO read(int reviewno) {
    ReviewVO reviewVO = this.reviewDAO.read(reviewno);
    
    String content = reviewVO.getContent();
    
    content = Tool.convertChar(content); 
    
    reviewVO.setContent(content);  
    
    long size1 = reviewVO.getRsize();
    reviewVO.setSize1_label(Tool.unit(size1));
    
    return reviewVO;
  }
  
  @Override
  public ReviewVO read_update(int boardno) {
    ReviewVO reviewVO = this.reviewDAO.read(boardno);
    return reviewVO;
  }
  
  @Override
  public int update(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.update(reviewVO);
    return cnt;
  }

  @Override
  public int delete(int reviewno) {
    int cnt = this.reviewDAO.delete(reviewno);
    return cnt;
  }

  // 조회수
  @Override
  public int rcnt_read(ReviewVO reviewVO) throws Exception{
    return reviewDAO.rcnt_read(reviewVO);
  }
}
