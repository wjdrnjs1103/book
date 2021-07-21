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
<DIV class="py-5">
  
      <DIV class='container c_bottom_10'> 
<DIV class='title_line'>
  <A href="../bookgrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="./list_by_bookgrpno.do?bookgrpno=${param.bookgrpno }" class='title_link'>${bookgrpVO.name }</A> > 
  ${bookVO.name } 수정 
</DIV>

<DIV class='content_body'>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./update.do'>
      <input type="hidden" name="bookno" value="${param.bookno }">
      
      <label>카테고리 그룹 번호</label>
      <input type='number' name='bookgrpno' value='${param.bookgrpno }' 
                 required="required" min="1" max="100" step="1" autofocus="autofocus">
      <label>카테고리 이름</label>
      <input type='text' name='name' value='${bookVO.name }' required="required" style='width: 25%;'>
      <label>등록 자료수</label>
      <input type='number' name='cnt' value='${bookVO.cnt }' 
                 required="required" min="0" max="10000000" step="1">    
  
      <button type="submit" id='submit' class="btn btn-dark">수정</button>
      <button type="button" onclick="location.href='./list_by_bookgrpno.do?bookgrpno=${bookVO.bookgrpno}'" class="btn btn-dark">취소</button>
    </FORM>
  </DIV>

   <TABLE class='table mt-5'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 50%;'/>
      <col style='width: 10%;'/>    
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
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="bookVO" items="${list}">
      <c:set var="bookno" value="${bookVO.bookno }" />
      <c:set var="bookgrpno" value="${bookVO.bookgrpno }" />
      <TR>
        <TD class="td_bs">${bookVO.bookno }</TD>
        <TD class="td_bs">${bookVO.bookgrpno }</TD>
        <TD class="td_bs_left">${bookVO.name }</TD>
        <TD class="td_bs">${bookVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${bookVO.cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?bookno=${bookno }&bookgrpno=${bookgrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?bookno=${bookno }&bookgrpno=${bookgrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>
</DIV>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>