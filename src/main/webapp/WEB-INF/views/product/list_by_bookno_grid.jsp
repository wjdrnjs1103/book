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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

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
  <A href="../bookgrp/list.do" class='title_link'>전공도서 그룹</A> > 
  <A href="../book/list_by_bookgrpno.do?bookgrpno=${bookgrpVO.bookgrpno }" class='title_link'>${bookgrpVO.name }</A> >
  <A href="./list_by_bookno_search_paging.do?bookno=${bookVO.bookno }" class='title_link'>${bookVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?bookno=${bookVO.bookno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_bookno_search_paging.do?bookno=${bookVO.bookno }">기본목록형</A>
  </ASIDE> 

  <DIV class='menu_line_1_g'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="productVO" items="${list }" varStatus="status">
      <c:set var="productno" value="${productVO.productno }" />
      <c:set var="title" value="${productVO.title }" />
      <c:set var="content" value="${productVO.content }" />
      <c:set var="file1" value="${productVO.file1 }" />
      <c:set var="size1" value="${productVO.size1 }" />
      <c:set var="thumb1" value="${productVO.thumb1 }" />    
      <c:set var="price" value="${productVO.price }" />


      <%-- 하나의 행에 이미지를 4개씩 출력후 행 변경 --%>
      <c:if test="${status.index % 7 == 0 && status.index != 0 }"> 
        <HR class='menu_line_1_g'>
      </c:if>
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV style='width: 12%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #FFFFFF; text-align: center;'>
        <c:choose>
          <c:when test="${size1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./read.do?productno=${productno}">               
                  <IMG src="./storage/${thumb1 }" style='width: 100%; height: 140px;'>
                </a><br>
                <a href="./read.do?productno=${productno}">${title}</a> <br>
                <%-- <del><fmt:formatNumber value="${price}" pattern="#,###" /></del> --%>
                <span style="color: #FF0000; font-size: 1.0em;">가격: ${price}원</span><br>
                <span style="color: #FF0000; font-size: 1.0em;">수량: ${cnt }</span>
                <%-- <strong><fmt:formatNumber value="${price}" pattern="##,###" /></strong> --%>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 140px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="./read.do?productno=${productno}">${file1}</a><br>
                  </DIV>
                </DIV>
                ${title} (${cnt})              
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="./read.do?productno=${productno}">
              <img src='/product/storage/noimage.png' style='width: 100%; height: 140px;'>
            </a><br>
            <a href="./read.do?productno=${productno}">${title}</a> <br>
            <span style="color: #FF0000; font-size: 1.0em;">가격: ${price}원</span><br>
            <span style="color: #FF0000; font-size: 1.0em;">수량: ${cnt }</span>
          </c:otherwise>
        </c:choose>         
      </DIV>  
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>

</DIV>
</DIV>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>