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
    <h3>로그인</h3>
  </div>

  <div class="page-header"></div>
  
  <div class="col-sm-6 col-md-offset-3">
    <form name='frm' id='frm' style='margin-top: 50px;' action="/register/login.do" method='post'>
      <%-- 로그인 후 자동으로 이동할 페이지 전달 ★ --%>
      <input type="hidden" name="return_url" value="${return_url}">
      
      <div class="form-group">
          <label for="inputName">아이디</label>
          <input type="text" class="form-control" name="id" id="id" value='${ck_id }' placeholder="아이디을 입력해 주세요" autofocus="autofocus">
          <Label>   
            <input type='checkbox' name='id_save' value='Y' 
                      ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label> 
      </div>
      <div class="form-group">
          <label for="inputPassword">비밀번호</label>
          <input type="text" class="form-control" name="passwd" id="passwd" value='${ck_passwd }' placeholder="비밀번호를 입력해주세요">
          <Label>
            <input type='checkbox' name='passwd_save' value='Y' 
                      ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>
      </div>

      <div class="form-group text-center">
          <button type="submit" class="btn btn-primary">
              로그인<i class="fa fa-check spaceLeft"></i>
          </button>
          <button type="button" onclick="location.href='./create.do'"  class="btn btn-warning">
              회원가입<i class="fa fa-times spaceLeft"></i>
          </button>
      </div>
    </form>
  </div>
</div> <!-- container// -->

 
 
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>