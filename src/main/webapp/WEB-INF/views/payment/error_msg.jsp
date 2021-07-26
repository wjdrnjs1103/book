<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Team2</title>
<%-- /static/css/style.css --%> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>카테고리 그룹 > 알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${code == 'create'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class='glyphicon glyphicon-exclamation-sign' style='font-size:24px'></span>
            <br><br>주문 등록에 실패했습니다.
          </LI>                                                                      
        </c:when>
        <c:when test="${code == 'nonegoods'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class='glyphicon glyphicon-exclamation-sign' style='font-size:24px'></span>
            <br><br> 등록된 상품이 없습니다.<br><br> 상품을 등록해 주세요.
          </LI>                                                                      
        </c:when>        
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="history.back()" class="btn btn-dark">다시 시도</button>
        <button type='button' onclick="location.href='/product/list_by_bookno_search_paging.do'" class="btn btn-dark">상품 목록으로</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>



