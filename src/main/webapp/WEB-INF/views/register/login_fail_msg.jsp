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
$(function(){ 
  $('#btn_retry').on('click', function() { 
    location.href="./login.do"
  });

  $('#btn_home').on('click', function() { 
    location.href="/index.do"
  });    
});
</script>
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class="container">
  <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
        <fieldset class='fieldset_basic'>
      <UL>
        <H3>회원 로그인에 실패했습니다.</H3>
        <H3>ID 또는 패스워드가 일치하지 않습니다.</H3>
        <H3>계속 실패시 ☏ 010-5305-0315 문의해주세요.</H3>
        <br>
        <button type='button' id="btn_retry" class="btn btn-primary">로그인 다시 시도</button>
        <button type='button' id="btn_home" class="btn btn-primary">확인</button>
       </UL>
    </fieldset>
  </div>
</div> <!-- container// -->

 
 
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>