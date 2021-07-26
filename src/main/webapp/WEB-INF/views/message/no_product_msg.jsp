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
<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <LI class='li_none'>
        <H3><span class="span_fail">삭제된 상품입니다.</span></H3>
      </LI>
      <LI class='li_none'>
        <br>
        <c:choose>
          <c:when test="${param.cnt == 1 }">
            <button type='button' 
                         onclick="location.href='http://localhost:9091/product/list_member.do?bookno=1&now_page=1'"
                         class="btn btn-dark">다른상품 구매하기</button>
            <button type='button' 
                         onclick="location.href='/message/list.do?memberno=${sessionScope.memberno }'"
                         class="btn btn-dark">내 쪽지함으로</button>
            <button type='button' 
                         onclick="location.href='/index.do'"
                         class="btn btn-dark">홈으로</button>
          </c:when>
          <c:otherwise>
            <button type='button' onclick="history.back();" class="btn btn-dark">뒤로가기</button>
          </c:otherwise>
        </c:choose>
      </LI>
    </UL>
  </fieldset>

</DIV>
</DIV>
</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>


