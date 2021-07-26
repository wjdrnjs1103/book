<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Team2</title>
<style type="text/css">
  .title_line {
    text-align: left;
    border-bottom: solid 3px #555555;
    width: 100%;
    margin: 20px auto;
    font-size: 20px;    
  }
  
  .content_body {
    width: 90%;
  }
  
  .aside_right {
    float: right;
    font-size: 0.9em;
  }
</style>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
 
<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
<div class="py-5">
  
  <DIV class='container c_bottom_10' style=""> 
      <DIV class='title_line'>
        ${sessionScope.mname }님 주문 결재 상세 내역
      </DIV>
    
      <DIV class='content_body' style='width: 100%;'>
    
        <ASIDE class="aside_right">
          <A href="javascript:location.reload();">새로고침</A>
        </ASIDE> 
       
        <div class='menu_line'></div>
       
       
        <table class="table table_top_margin" style='width: 100%;'>
          <colgroup>
            <col style='width: 5%;'/>
            <col style='width: 10%;'/>
            <col style='width: 35%;'/>
            <col style='width: 5%;'/>
            <col style='width: 5%;'/>
            <col style='width: 15%;'/>
            <col style='width: 15%;'/>
            <col style='width: 10%;'/>
           
          </colgroup>
          <TR class="table_title">
            <TH class='th_bs'>주문<br>번호</TH>
            <TH class='th_bs'>회원<br>이름</TH>
  <!--           <TH class='th_bs'>상품<br>번호</TH> -->
            <TH class='th_bs'>상품명</TH>
            <TH class='th_bs'>가격</TH>
            <TH class='th_bs'>수량</TH>
            <TH class='th_bs'>배송상태</TH>
            <TH class='th_bs'>주문일</TH>
            <TH class='th_bs'>환불신청</TH>
          </TR>
         
          <c:forEach var="ordersVO" items="${list }">
            <c:set var="paymentno" value ="${ordersVO.paymentno}" />
            <c:set var="ordersno" value ="${ordersVO.ordersno}" />
            <c:set var="memberno" value ="${ordersVO.memberno}" />
            <c:set var="productno" value ="${ordersVO.productno}" />
            <c:set var="title" value ="${ordersVO.title}" />
            <c:set var="price" value ="${ordersVO.price}" />
            <c:set var="cnt" value ="${ordersVO.cnt}" />
            <c:set var="tot" value ="${ordersVO.tot}" />
            <c:set var="states" value ="${ordersVO.states}" />
            <c:set var="rdate" value ="${ordersVO.rdate}" />
            <c:set var="mname" value ="${ordersVO.mname}" />
               
          <TR>
            <TD class=td_basic>${ordersno}</TD>
            <TD class=td_basic>${mname}</TD>
            <!--<TD class=td_basic><A href="/member/read.do?memberno=${memberno}">${memberno}</A></TD>-->
            <%-- <TD class=td_basic><A href="/product/read.do?productno=${productno}">${productno}</A></TD> --%>
            <TD class='td_left'>${title}</TD>
            <TD class='td_left'><fmt:formatNumber value="${price }" pattern="#,###" /></TD>
            <TD class='td_basic'>${cnt }</TD>
            <TD class='td_basic'>
              <c:choose>
                <c:when test="${states == 1}">결재 완료</c:when>
                <c:when test="${states == 2}">상품 준비중</c:when>
                <c:when test="${states == 3}">배송 시작</c:when>
                <c:when test="${states == 4}">배달중</c:when>
                <c:when test="${states == 5}">오늘 도착</c:when>
                <c:when test="${states == 6}">배달 완료</c:when>
              </c:choose>
            </TD>
            
            <TD class='td_basic'>${rdate.substring(0,16) }</TD>
            <TD class='td_basic'>
              <A href="/refund/create.do?ordersno=${ordersno }">환불신청</A>
            </TD>
          </TR>
          </c:forEach>
          
      </TABLE>
      
      <table class="table table-striped" style='width: 100%;'>
        <TR>
          <TD colspan="10"  style="text-align: right; font-size: 1.3em;">
            배송비: <fmt:formatNumber value="${delivery }" pattern="#,###" /> &nbsp;&nbsp;
            총 주문 금액: <fmt:formatNumber value="${tot_order }" pattern="#,###" />  
          </TD>
        </TR>  
      </table>    
       
      <DIV class='bottom_menu'>
        <button type='button' onclick="location.href='/payment/list_by_memberno.do?memberno=${memberno}'" 
                    class="btn btn-dark" style="font-size:1.2em;">결재 목록</button>
      </DIV>
    </DIV>
  </DIV>
</DIV>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>