<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title></title>
 
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
  
  <DIV class='container c_bottom_10'> 
    <DIV class='title_line'>
      ${sessionScope.mname }님 주문결제 내역
    </DIV>
  
    <DIV class='content_body' style='width: 100%;'>
  
      <ASIDE class="aside_right">
        <A href="javascript:location.reload();">새로고침</A>
      </ASIDE> 
     
      <div class='menu_line'></div>
     
     
      <table class="table table_top_margin" style='width: 100%;'>
      <colgroup>
        <col style='width: 5%;'/>
        <col style='width: 5%;'/>
        <col style='width: 7%;'/>
        <col style='width: 15%;'/>
        <col style='width: 30%;'/>
        <col style='width: 10%;'/>
        <col style='width: 10%;'/>
        <col style='width: 13%;'/>
        <col style='width: 5%;'/>
      </colgroup>
      <TR class="table_title">
        <TH class='th_bs'>주문<br>번호</TH>
        <TH class='th_bs'>회원<br>번호</TH>
        <TH class='th_bs'>수취인<br>성명</TH>
        <TH class='th_bs'>수취인<br>전화번호</TH>
        <TH class='th_bs'>수취인<br>주소</TH>
        <TH class='th_bs'>결제 타입</TH>
        <TH class='th_bs'>결제 금액</TH>
        <TH class='th_bs'>주문일</TH>
        <TH class='th_bs'>조회</TH>
      </TR>
     
      <c:forEach var="paymentVO" items="${list }">
        <c:set var="paymentno" value ="${paymentVO.paymentno}" />
        <c:set var="memberno" value ="${paymentVO.memberno}" />
        <c:set var="realname" value ="${paymentVO.realname}" />
        <c:set var="phone" value ="${paymentVO.phone}" />
        <c:set var="address" value ="(${paymentVO.postcode}) ${paymentVO.address} ${paymentVO.detaddress}" />
        <c:set var="paytype" value ="${paymentVO.paytype}" />
        <c:set var="paymoney" value ="${paymentVO.paymoney}" />
        <c:set var="rdate" value ="${paymentVO.rdate}" />
           
         
      <TR>
        <TD class=td_basic>${paymentno}</TD>
        <TD class=td_basic><A href="/member/read.do?memberno=${memberno}">${memberno}</A></TD>
        <TD class='td_basic'>${realname}</TD>
        <TD class='td_basic'>${phone}</TD>
        <TD class='td_basic'>${address}</TD>
        <TD class='td_basic'>
          <c:choose>
            <c:when test="${paytype == 1}">모바일</c:when>
            <c:when test="${paytype == 2}">계좌 이체</c:when>
            <c:when test="${paytype == 3}">신용카드</c:when>
          </c:choose>
        </TD>
        <TD class='td_basic'><fmt:formatNumber value="${paymoney }" pattern="#,###" /></TD>
        <TD class='td_basic'>${rdate.substring(0,16) }</TD>
        <TD class='td_basic'>
          <A href="/orders/list_by_memberno.do?paymentno=${paymentno}">
            <!-- <img src="/payment/images/bu6.png" title="주문 내역 상세 조회"> -->
            <span class="glyphicon glyphicon-share" title="주문 내역 상세 조회"></span>
          </A>
        </TD>
        
      </TR>
      </c:forEach>
      
    </TABLE>
     
  <!--   <DIV class='bottom_menu'>
      <button type='button' onclick="location.reload();" class="btn btn-primary">새로 고침</button>
    </DIV> -->
  </DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>