package dev.mvc.message;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.commgrp.CommgrpProcInter;
import dev.mvc.product.ProductDAOInter;
import dev.mvc.product.ProductVO;
import dev.mvc.register.RegisterVO;
import dev.mvc.tool.Tool;

@Component("dev.mvc.message.MessageProc")
public class MessageProc implements MessageProcInter {
  @Autowired
  private MessageDAOInter messageDAO;
  
  @Autowired
  private ProductDAOInter productDAO;
  
  
  public MessageProc(){
    System.out.println("-> MessageProc created.");
  }
  
  @Override
  public int create(MessageVO messageVO) {
    int cnt = this.messageDAO.create(messageVO);
    return cnt;
  }

  @Override
  public int get_memberno(int productno) {
    int cnt = this.messageDAO.get_memberno(productno);
    return cnt;
  }

  @Override
  public List<MessageVO> list(int recv_member) {
    List<MessageVO> list =this.messageDAO.list(recv_member);
    return list;
  }

  @Override
  public int count_by_memberno(int recv_member) {
    int cnt = this.messageDAO.count_by_memberno(recv_member);
    return cnt;
  }

}
