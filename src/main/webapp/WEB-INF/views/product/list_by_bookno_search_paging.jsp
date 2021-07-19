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

    <DIV class='container2'>
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
    <A href="./list_by_bookno_grid.do?bookno=${bookVO.bookno }">갤러리형</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_bookno_search_paging.do'>
      <input type='hidden' name='bookno' value='${bookVO.bookno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_bookno_search_paging.do?bookno=${bookVO.bookno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <table class="table table-container" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="productVO" items="${list }">
        <c:set var="productno" value="${productVO.productno }" />
        <c:set var="title" value="${productVO.title }" />
        <c:set var="content" value="${productVO.content }" />
        <c:set var="file1" value="${productVO.file1 }" />
        <c:set var="thumb1" value="${productVO.thumb1 }" />
        <c:set var="price" value="${productVO.price }" />
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/product/storage/ --%>
                <a href="./read.do?productno=${productno}&now_page=${param.now_page }&word=${param.word }"><IMG src="/product/storage/${thumb1 }" style="width: 130px; height: 170px;"></a> 
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                ${file1}
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?productno=${productno}&now_page=${param.now_page }"><strong>${title}</strong><br> ${content}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
          
           <%-- <del><fmt:formatNumber value="${productVO.price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${productVO.dc} %</span>
            <strong><fmt:formatNumber value="${productVO.saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${productVO.point}" pattern="#,###" /></span>
            <strong><fmt:formatDatevalue="${productVO.rdate}" type="date" /></strong>                                                                                     --%>
            <span style="font-size: 0.9em;">가격: ${productVO.price}원</span>
            
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?productno=${productno}&now_page=${now_page }"><span class="glyphicon glyphicon-pencil"></span></A>
            <A href="./delete.do?productno=${productno}&now_page=${now_page }"><span class="glyphicon glyphicon-trash"></span></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  <DIV class='bottom_menu'>${paging }</DIV>
</DIV>
</DIV>
</DIV>


 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>