<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="shrink-to-fit=no initial-scale=1, width=device-width" /> 
<meta name="description" content="" />
<meta name="author" content="" /> 

<title>Team2</title>
 
<!-- /static 기준 -->
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<!-- Favicon-->
<link rel="icon" type="/image/x-icon" href="assets/favicon.ico" />

<script type="text/javascript"> 

</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
  <section class="py-5">
    <DIV class='container c_bottom_10'>
      <DIV class='title_line'>
        리뷰 전체 목록(관리자)
      </DIV>
      
      <TABLE class='table mt-5'>
        <colgroup>
          <col style='width: 7%;'/>
          <col style='width: 7%;'/>
          <col style='width: 10%;'/>
          <col style='width: 10%;'/>
          <col style='width: 37%;'/>  
          <col style='width: 7%;'/>  
          <col style='width: 12%;'/>  
          <col style='width: 10%;'/>
        </colgroup>
        <thead>  
          <TR class="table_title">
            <TH class="th_bs">상품번호</TH>
            <TH class="th_bs">리뷰번호</TH>
            <TH class="th_bs">판매 회원번호</TH>
            <TH class="th_bs">리뷰 작성자</TH>
            <TH class="th_bs">내용</TH>
            <TH class="th_bs">평점</TH>
            <TH class="th_bs">날짜</TH>
            <TH class="th_bs">기타</TH>
          </TR>
        </thead>
        
        <tbody>
        <c:forEach var="reviewVO" items="${list}" varStatus="status">
            <c:set var="productno" value="${reviewVO.productno }" />
            <c:set var="memberno" value="${reviewVO.memberno }" />
            <c:set var="r_member" value="${list2[status.index].memberno }" />
            
            <TR>
            <TD class="td_bs"><A href="../product/read.do?productno=${productno }">${productno }</A></TD>
            <TD class="td_bs">${reviewVO.reviewno }</TD>
            <TD class="td_bs">${r_member }</TD>
            <TD class="td_bs">${reviewVO.writer}</TD>
            <TD class="td_bs_left">
              <A href="/review/read.do?reviewno=${reviewVO.reviewno }">${reviewVO.content }</A>
            </TD>
            <TD class="td_bs">${reviewVO.score }</TD>
            <TD class="td_bs">${reviewVO.rdate.substring(0, 16) }</TD>
            <TD class="td_bs">
              <A href="./read_update.do?reviewwno=${reviewwno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
              <A href="./read_delete.do?reviewwno=${reviewwno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
            </TD>  
        </c:forEach> 
        </tbody>
      </TABLE>
    
    </DIV><!-- container c_bottom_10 end -->
    
  </section>
  
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

