<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" /> 

<title>Team 2</title>

<!-- /static 기준 -->
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />


<script type="text/javascript">

</script>
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class="container">
  <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
        <fieldset class='fieldset_basic'>
      <UL>
        <c:choose>
          <c:when test="${param.cnt == 1 }">
            <H3>회원가입이 완료되었습니다.</H3>
          </c:when>
          <c:otherwise>
            <H3>회원 가입에 실패했습니다.</H3>
            <H3>다시한번 시도해주세요.</H3>
            <H3>계속 실패시 ☏ 000-0000-0000 문의해주세요.</H3>
          </c:otherwise>
        </c:choose>
          <br>
          <button type='button' onclick="location.href='./login.do'" class="btn btn-primary">로그인</button>
          <button type='button' onclick="location.href='./create.do'" class="btn btn-primary">회원 등록</button>
          <button type='button' onclick="location.href='./list.do'" class="btn btn-primary">목록</button>
       </UL>
    </fieldset>
  </div>
</div> <!-- container// -->

 
 
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>