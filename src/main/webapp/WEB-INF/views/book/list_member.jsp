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
<A href="../bookgrp/list.do" class='link-primary'>전공도서 그룹</A> > ${bookgrpVO.name }
</DIV>

  <TABLE class='table mt-5'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 60%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
    </colgroup>
   
    <thead>  
    <TR class="table_title">
      <TH class="th_bs">전공서적<br> 번호</TH>
      <TH class="th_bs">전공서적<br> 그룹 번호</TH>
      <TH class="th_bs">전공서적 이름</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">관련 자료수</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="bookVO" items="${list}">
      <c:set var="bookno" value="${bookVO.bookno }" />
      <c:set var="bookgrpno" value="${bookVO.bookgrpno }" />
      <TR>
        <TD class="td_bs">${bookVO.bookno }</TD>
        <TD class="td_bs">${bookVO.bookgrpno }</TD>
        <TD class="td_bs_left">
        <A href="../product/list_member.do?bookno=${bookno }&now_page=1">${bookVO.name }</A>
        <TD class="td_bs">${bookVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${bookVO.cnt }</TD>  
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
  

</DIV>
</section>


 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>